#!/usr/bin/env bash

source ./__helpers.sh

# Set variables
HOST="localhost"
PORT="8080"
HTTP_URL="${HOST}:${PORT}"

check_httpbin_gloo() {
    test_info "Checking if httpbin is accessible via Gloo Edge..."
    curl -s -I $HTTP_URL/get > /dev/null
    if [ $? -eq 0 ]; then
        test_success "httpbin is accessible via Gloo Edge."
    else
        test_failed "Failed to access httpbin via Gloo Edge." >&2
        exit 1
    fi
}

check_gloo_headers() {
    expected_host_name="my-host"
    expected_x_forward_host="from-some-where"

    test_info "Checking if request headers are maintained during the request..."
    headers=$(curl -s --header "Host: ${expected_host_name}" --header "X-Forwarded-Host: ${expected_x_forward_host}" ${HTTP_URL}/headers 2> /dev/null)
    if [ $? -eq 0 ]; then
        obtained_host_name=$(echo $headers | jq -r '.headers.Host')
        if [ ${obtained_host_name} !=  ${expected_host_name} ]; then
            test_failed "The response host header is different of what is expected..."  >&2
            exit 1
        fi
        obtained_x_forward_host=$(echo $headers | jq -r '.headers."X-Forwarded-Host"')
        if [ ${obtained_x_forward_host} !=  ${expected_x_forward_host} ]; then
            test_failed "The response X-Forwarded-Host header is different of what is expected..."  >&2
            exit 1
        fi
        test_success "The headers are as expected"
    else
        test_failed "Failed to access httpbin to check the headers." >&2
        exit 1
    fi
}

# Run tests
check_httpbin_gloo
check_gloo_headers

test_success "******************"
test_success "All checks passed!"



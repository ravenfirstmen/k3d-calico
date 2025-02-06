#!/usr/bin/env bash

# headers path
echo "Testing headers path (10 req/minute) ...."
for i in {1..11}; do 
    echo -n "Executing ${i} request ...."
    status_code=$(curl -k -s -o /dev/null -I -w "%{http_code}" https://httpbin.127-0-0-1.nip.io/headers 2>/dev/null)
    echo "status code of response was: ${status_code}."
done


#get path
echo "Testing get path (2 req/minute) ...."
for i in {1..3}; do 
    echo -n "Executing ${i} request ...."
    status_code=$(curl -k -s -o /dev/null -I -w "%{http_code}" https://httpbin.127-0-0-1.nip.io/get 2>/dev/null)
    echo "status code of response was: ${status_code}."
done

#get path
echo "Testing 'an_http_header' header (1 req/minute) ...."
for i in {1..2}; do 
    echo -n "Executing ${i} request ...."
    status_code=$(curl -k -s -o /dev/null -I -w "%{http_code}" --header "x-an-header: an_http_header" https://httpbin.127-0-0-1.nip.io 2>/dev/null)
    echo "status code of response was: ${status_code}."
done

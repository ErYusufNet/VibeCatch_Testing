*** Settings ***
Library    OperatingSystem
Library    ../resources/poll_generator.py

*** Variables ***
${url}           https://env-5369504.paas.datacenter.fi/
${email}         yusuf.er@brightstraining.com
${password}      tenor!embedded9PING
${poll_name}     Evaluate    get_random_poll_name()    modules=poll_generator
${language}      Finnish
${confirm_text}  DESTROY

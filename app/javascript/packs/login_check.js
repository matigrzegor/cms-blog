const BASE_URL = 'http://localhost:3000'

const login_check = async () => {
    const email = document.querySelector('#user_email');
    const password = document.querySelector('#password');
    
    const data = {
        password: password.value,
        user: {
            email: email.value
        }
    };

    const response = await fetch(`${BASE_URL}/login_checks`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })

    return response;
};

const authorizationGrant = () => {
    const authenticity_token = document.querySelector('form input')
    const client_id = document.querySelector('#client_id');
    const redirect_uri = document.querySelector('#redirect_uri');
    const state = document.querySelector('#state');
    const response_type = document.querySelector('#response_type');
    const scope = document.querySelector('#scope');
    const code_challenge = document.querySelector('#code_challenge');
    const code_challenge_method = document.querySelector('#code_challenge_method');
    const email = document.querySelector('#user_email');
    const password = document.querySelector('#password');
    
    const data = {
        authenticity_token: authenticity_token.value,
        client_id: client_id.value,
        redirect_uri: redirect_uri.value,
        state: state.value,
        response_type: response_type.value,
        scope: scope.value,
        code_challenge: code_challenge.value,
        code_challenge_method: code_challenge_method.value,
        password: password.value,
        user: {
            email: email.value
        }
    };
    
    fetch(`${BASE_URL}/oauth/authorize`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        redirect: 'follow',
        body: JSON.stringify(data)
    }).then(response => {
        window.location.href = response.url
    }).catch(err => console.log(err))
};

const authorize = async () => {
    const response = await login_check();

    if (response.status === 200) {
        console.log('200');

        authorizationGrant();
    } else {
        console.log('404');
    };
};

const init_authorize = () => {
    const authorizeBtn = document.querySelector('#authorize_btn');

    authorizeBtn.addEventListener('click', () => authorize());
};

init_authorize();
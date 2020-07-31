const BASE_URL = "https://fierce-anchorage-12434.herokuapp.com";

const renderRequestError = (errorMsg) => {
    const paragraph = document.createElement("p");
    paragraph.classList.add("error", "request_error");

    const container = document.querySelector(".actions");

    paragraph.innerHTML = errorMsg;
    container.appendChild(paragraph);
};

const removeRequestError = () => {
    const paragraph = document.querySelector(".request_error");
    if (paragraph) paragraph.remove();
};

// authorization

const login_check = async () => {
    const email = document.querySelector("#user_email");
    const password = document.querySelector("#password");

    const data = {
        password: password.value,
        user: {
            email: email.value,
        },
    };

    const response = await fetch(`${BASE_URL}/login_checks`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
    });

    return response;
};

const authorizationGrant = () => {
    const authenticity_token = Array.from(document.querySelectorAll('input[name="authenticity_token"]'))[0];
    const client_id = document.querySelector("#client_id_authorize");
    const redirect_uri = document.querySelector("#redirect_uri_authorize");
    const state = document.querySelector("#state_authorize");
    const response_type = document.querySelector("#response_type_authorize");
    const scope = document.querySelector("#scope_authorize");
    const code_challenge = document.querySelector("#code_challenge_authorize");
    const code_challenge_method = document.querySelector("#code_challenge_method_authorize");
    const email = document.querySelector("#user_email");
    const password = document.querySelector("#password");

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
            email: email.value,
        },
    };

    fetch(`${BASE_URL}/oauth/authorize`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
    })
    .then(r => r.json())
    .then(r => {
        window.location.href = r.location;
    })
    .catch((err) => console.log(err));
};

const authorize = async () => {
    removeRequestError();
    const response = await login_check();
    const bodyResponse = await response.json();
    
    if (response.status === 200) {
        authorizationGrant();
    } else {
        renderRequestError(bodyResponse.details)
    }
};

const isFormValid = () => {
    const formFields = [document.querySelector("#user_email"), document.querySelector("#password")];
    let valid = true;

    formFields.forEach((field) => {
        validate(field.value, field.type, field.id);
        if (!isValid(field.value, field.type)) valid = false;
    });

    return valid
}

const init_authorize = () => {
    const authorizeBtn = document.querySelector("#authorize_btn");

    authorizeBtn.addEventListener("click", () => {
        if(isFormValid()) authorize()
    });
};

//deny

const deny = () => {
    const authenticity_token = Array.from(document.querySelectorAll('input[name="authenticity_token"]'))[1];
    const client_id = document.querySelector("#client_id_deny");
    const redirect_uri = document.querySelector("#redirect_uri_deny");
    const state = document.querySelector("#state_deny");
    const response_type = document.querySelector("#response_type_deny");
    const scope = document.querySelector("#scope_deny");
    const code_challenge = document.querySelector("#code_challenge_deny");
    const code_challenge_method = document.querySelector("#code_challenge_method_deny");

    const data = {
        authenticity_token: authenticity_token.value,
        client_id: client_id.value,
        redirect_uri: redirect_uri.value,
        state: state.value,
        response_type: response_type.value,
        scope: scope.value,
        code_challenge: code_challenge.value,
        code_challenge_method: code_challenge_method.value,
    };

    fetch(`${BASE_URL}/oauth/authorize`, {
        method: "DELETE",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
    })
    .then(r => r.json())
    .then(r => {
        window.location.href = r.location;
    })
    .catch((err) => console.log(err));
}

const init_deny = () => {
    const denyBtn = document.querySelector("#deny_btn");

    denyBtn.addEventListener("click", () => deny())
}

//validation
const renderError = (message, id) => {
    const paragraph = document.createElement("p");
    paragraph.classList.add("error", `error_${id}`);
    const errorInput = document.querySelector(`#${id}`);
    const container = errorInput.parentNode;
    paragraph.innerHTML = message;
    container.insertBefore(paragraph, errorInput);
};

const removeError = (id) => {
    const paragraph = document.querySelector(`.error_${id}`);
    if (paragraph) paragraph.remove();
};

const validateEmail = (email) => {
    const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
};

const validate = (value, type, id) => {
    if (type === "password" && value.length < 6) {
        removeError(id);
        renderError("Password is too short", id);
    } else if (type === "email" && (value === "" || !validateEmail(value))) {
        removeError(id);
        renderError("Please enter a valid email address", id);
    } else {
        removeError(id);
    }
};

const isValid = (value, type) => {
    return !(
        (type === "text" && value === "") ||
        (type === "password" && value.length < 8) ||
        (type === "email" && (value === "" || !validateEmail(value)))
    );
};

const addFormValidation = () => {
    const inputs = document.querySelectorAll("form input");
    inputs.forEach((input) => {
        input.addEventListener("blur", () => {
            validate(input.value, input.type, input.id);
        });
        input.addEventListener("focus", () => {
            removeError(input.id);
        });
    });
};

init_authorize();
init_deny();
addFormValidation();
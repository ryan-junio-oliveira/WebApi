<?php

test('login route returns 200', function () {
    $response = $this->get('/');
    $response->assertStatus(200);
});

test('login with invalid credentials format', function() {

    $cred = [
        'email' => 'testdogmail.com',
        'password' => 'testandoPassword'
    ];

    $response = $this->postJson('/api/V1/login', $cred);

    $response->assertStatus(422);
    $response->assertJsonValidationErrors('email');
    $response->assertJsonValidationErrors('password');
});

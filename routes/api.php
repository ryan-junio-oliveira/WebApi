<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Middleware\JwtMiddleware;

Route::prefix('/v1')->group(function () {
    Route::get('/', function () { return 'teste';});

    Route::post('/login', [AuthController::class, 'login']);
    Route::post('/register', [AuthController::class, 'register']);

    Route::middleware([JwtMiddleware::class])->group(function(){
        Route::get('/user', [AuthController::class, 'getUser']);
        Route::post('/logout', [AuthController::class, 'logout']);
    });
});

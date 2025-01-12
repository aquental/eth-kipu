// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract Operadores {
    // Inicializar variables
    uint16 public first = 10;
    uint16 public second = 30;

    // Inicializar una variable con el operador de suma
    uint256 public addition = first + second;
    // Inicializar una variable con el operador de resta
    uint256 public subtraction = second - first;
    // Inicializar una variable con una multiplicación
    uint256 public multiplication = first * second;
    // Inicializar una variable con el cociente de una división
    uint256 public division = first / second;
    // Inicializando una variable con módulo
    uint256 public modulus = first % second;
    // Inicializar una variable con un valor reducido en uno
    uint256 public decrement = --second;
    // Inicializar una variable con un valor incrementado en uno
    uint256 public increment = ++first;
}

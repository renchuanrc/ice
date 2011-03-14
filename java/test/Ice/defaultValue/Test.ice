// **********************************************************************
//
// Copyright (c) 2003-2010 ZeroC, Inc. All rights reserved.
//
// This copy of Ice is licensed to you under the terms described in the
// ICE_LICENSE file included in this distribution.
//
// **********************************************************************

#ifndef TEST_ICE
#define TEST_ICE

[["java:package:test.Ice.defaultValue"]]
module Test
{

enum Color { red, green, blue };

module Nested
{

enum Color { red, green, blue };

};

struct Struct1
{
    bool boolFalse = false;
    bool boolTrue = true;
    byte b = 254;
    short s = 16000;
    int i = 3;
    long l = 4;
    float f = 5.1;
    double d = 6.2;
    string str = "foo bar";
    Color c1 = ::Test::red;
    Color c2 = Test::green;
    Color c3 = blue;
    Nested::Color nc1 = ::Test::Nested::red;
    Nested::Color nc2 = Nested::green;
    Nested::Color nc3 = Nested::blue;
    string noDefault;
};

const bool ConstBool = true;
const byte ConstByte = 254;
const short ConstShort = 16000;
const int ConstInt = 3;
const long ConstLong = 4;
const float ConstFloat = 5.1;
const double ConstDouble = 6.2;
const string ConstString = "foo bar";
const Color ConstColor1 = ::Test::red;
const Color ConstColor2 = Test::green;
const Color ConstColor3 = blue;
const Nested::Color ConstNestedColor1 = ::Test::Nested::red;
const Nested::Color ConstNestedColor2 = Test::Nested::green;
const Nested::Color ConstNestedColor3 = Nested::blue;


struct Struct2
{
    bool boolTrue = ConstBool;
    byte b = ConstByte;
    short s = ConstShort;
    int i = ConstInt;
    long l = ConstLong;
    float f = ConstFloat;
    double d = ConstDouble;
    string str = ConstString;
    Color c1 = ConstColor1;
    Color c2 = ConstColor2;
    Color c3 = ConstColor3;
    Nested::Color nc1 = ConstNestedColor1;
    Nested::Color nc2 = ConstNestedColor2;
    Nested::Color nc3 = ConstNestedColor3;
};

class Base
{
    bool boolFalse = false;
    bool boolTrue = true;
    byte b = 1;
    short s = 2;
    int i = 3;
    long l = 4;
    float f = 5.1;
    double d = 6.2;
    string str = "foo bar";
    string noDefault;
};

class Derived extends Base
{
    Color c1 = ::Test::red;
    Color c2 = Test::green;
    Color c3 = blue;
    Nested::Color nc1 = ::Test::Nested::red;
    Nested::Color nc2 = Nested::green;
    Nested::Color nc3 = Nested::blue;
};

exception BaseEx
{
    bool boolFalse = false;
    bool boolTrue = true;
    byte b = 1;
    short s = 2;
    int i = 3;
    long l = 4;
    float f = 5.1;
    double d = 6.2;
    string str = "foo bar";
    string noDefault;
};

exception DerivedEx extends BaseEx
{
    Color c1 = ConstColor1;
    Color c2 = ConstColor2;
    Color c3 = ConstColor3;
    Nested::Color nc1 = ConstNestedColor1;
    Nested::Color nc2 = ConstNestedColor2;
    Nested::Color nc3 = ConstNestedColor3;
};

};

#endif

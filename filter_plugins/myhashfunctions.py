#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from passlib.hash import bcrypt_sha256
import django
from django.contrib.auth.hashers import make_password
django.conf.settings.configure()

class FilterModule(object):
    def filters(self):
        return {
            'my_bcrypt_sha256': self.my_bcrypt_sha256,
            'my_pbkdf2_sha256': self.my_pbkdf2_sha256,
        }

    def my_bcrypt_sha256(self, password):
        return bcrypt_sha256.hash(password)

    def my_pbkdf2_sha256(self, password):
        return make_password(password)

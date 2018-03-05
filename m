Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA2F1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 14:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeCEO3U (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 09:29:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:39367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbeCEO3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 09:29:19 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfC4q-1eM1O125Rg-00okCK; Mon, 05
 Mar 2018 15:29:17 +0100
Date:   Mon, 5 Mar 2018 15:29:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Larry Hunter <larhun.it@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [Bug] git log --show-signature print extra carriage return ^M
In-Reply-To: <CAL+2DvQZ2V9c5Tmn8KCoDOuioOiBsGJspSTVin4qw1oFO2QAwA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803051457570.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAL+2DvQZ2V9c5Tmn8KCoDOuioOiBsGJspSTVin4qw1oFO2QAwA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TSf5qbP/9XNpXPvaQlPSlQzQMDJRs6NF+VrmJXtVS6SrP0zltiz
 5l5t8lADfNhssiZ1ZkMjjmmUS48VKizK2cIg84LjKLXPjETHqmbGjsGZ9j9b9S97MXzXLM4
 tpfZ/LRQdBrxOIVc/Jbjm7v2TaRazskgPB2507C6QE6q7vT/Q7iMWnaWT0uObTb7h/rRj95
 CD+Vc6l7hMxHyCs7Nsxqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NaRzXxFjZfA=:spHGV2TEWSC4opecrMtJhJ
 +EE+wfqqQf0Z7D5uH6g52zJS3xNU01fKBleIUnzoQPqaHgNH7MSVkavavdCKfDnEOD+F4VW7m
 CsSMOQTVgRu7/c/owSF8h/JM7+4F2LebnjvFHIRyLZ4mDVcZpR4+WZzvDb6xgor1BQuXpIDeL
 n/xeqRSS3MpZBO7SbyH0yHsa1OoJNGwVAQpCQfUDPEN/INLPlJkeA7Vq1ZiF9tjJIDN873v6E
 k+tih1Uva+YSVIRHJkLzrF6yPGCcer4LM0cLcXifVxruB0azozru7swleFXwgTyFqY7rAkHtE
 BfUGcIVBJ3sBf/769fIoqLUeX/HaLcIEbIwLcJieGjq8kL96oOdZOZ2sCYRbaM4rQE4m0hGNY
 lQTXlWNgDC+VY08+IJCfsSyASdA38C77vSslN5Ky7lpe4UO2T03tIlUpmWRhq7PJ4DTsKtLwU
 j/e4LXlrVyvH620p51Wft2yzQRl0PkMd2tzsCyZH8SuatyyJsOSYGg4B1ooob7GrrHagnhIoY
 ++ckNkc1tjGZ7b1UCkkrgkvnD37wvX/hocNzG25DTFk1oOmjIU6gi9z/GENgJ986cmE9j/SCf
 1XEmnowJ7+TrdYhv1SyJNLLx12Qu1iORnkDEYqGCY9OziOlHDMU1oio4arMVRR0KoXq4PeS8a
 cVwqwVZ60iTt+gQCeF3tguEfcEBOkBF5cRrfYe8sV/0nvRcckokenpOBb9XwT1w3LMdIis8IN
 4Idnjwz2miiBsoFZXxh8lcS6nGG7laF9kAy52ikYQzzOuUEPM7He3swkccyCaqTRQnPCCLsme
 aWMOOQc9h1qkLe3V5tpEx/35AyBwIyUgzgIGk3nmPjSh4aClfmskTf+EbbWWZ6+MoqphsD5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Larry,

On Sun, 4 Mar 2018, Larry Hunter wrote:

> There is bug using "git log --show-signature" in my installation
> 
>     git 2.16.2.windows.1
>     gpg (GnuPG) 2.2.4
>     libgcrypt 1.8.2

The gpg.exe shipped in Git for Windows should say something like this:

	$ gpg --version
	gpg (GnuPG) 1.4.22
	Copyright (C) 2015 Free Software Foundation, Inc.
	License GPLv3+: GNU GPL version 3 or later
	<http://gnu.org/licenses/gpl.html>
	This is free software: you are free to change and redistribute it.
	There is NO WARRANTY, to the extent permitted by law.

	Home: ~/.gnupg
	Supported algorithms:
	Pubkey: RSA, RSA-E, RSA-S, ELG-E, DSA
	Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
		CAMELLIA128, CAMELLIA192, CAMELLIA256
	Hash: MD5, SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
	Compression: Uncompressed, ZIP, ZLIB, BZIP2

Therefore, the GNU Privacy Guard version you use is not the one shipped
and supported by the Git for Windows project.

> that prints (with colors) an extra ^M (carriage return?) at the end of
> the gpg lines. As an example, the output of "git log --show-signature
> HEAD" looks like:
> 
>     $ git log --show-signature HEAD
>     commit 46c490188ebd216f20c454ee61108e51b481844e (HEAD -> master)
>     gpg: Signature made 03/04/18 16:53:06 ora solare Europa occidentale^M
>     gpg:                using RSA key ...^M
>     gpg: Good signature from "..." [ultimate]^M
>     Author: ... <...>
>     Date:   Sun Mar 4 16:53:06 2018 +0100
>     ...
> 
> To help find a fix, I tested the command "git verify-commit HEAD" that
> prints (without colors) the same lines without extra ^M characters.
> 
>     $ git verify-commit HEAD
>     gpg: Signature made 03/04/18 16:53:06 ora solare Europa occidentale
>     gpg:                using RSA key ...
>     gpg: Good signature from "..." [ultimate]

My guess is that the latter command simply does not go through the pager
while the former does.

Do you see the ^M in the output of `git -p verify-commit HEAD`?

Ciao,
Johannes

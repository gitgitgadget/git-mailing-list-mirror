Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B7D1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 12:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759818AbeD1MS5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 08:18:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:44247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759699AbeD1MS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 08:18:56 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaoMe-1eWiGM0MHo-00kLIW; Sat, 28
 Apr 2018 14:18:54 +0200
Date:   Sat, 28 Apr 2018 14:18:54 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Larry Hunter <larhun.it@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [Bug] git log --show-signature print extra carriage return ^M
In-Reply-To: <CAL+2DvR4ZBicrCYSkQ1jDaWaLJHgp8yVkKQZgxVc9txzHbNFkg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804281417410.79@tvgsbejvaqbjf.bet>
References: <CAL+2DvQZ2V9c5Tmn8KCoDOuioOiBsGJspSTVin4qw1oFO2QAwA@mail.gmail.com> <nycvar.QRO.7.76.6.1803051457570.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAL+2DvR4ZBicrCYSkQ1jDaWaLJHgp8yVkKQZgxVc9txzHbNFkg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cgYDUhsbg4NxtnOUFJmg6USrma2lv/quwYFRPifIa9l562GiDx3
 gtCsBdzOtEqUMqt1No3rufq0cWzelGSc65jYrXYKFLAzWnCorX5+AfISvD0wKiZjj+OKcm8
 QaeIJxaQ0Q3JRnkje/k5OJtH8Q6YlmI3n/kRiYFeNNP7RX9jH6FjV0sPoUwtB7lyXUD4eIW
 I8ujv3bxYPS31uaRRrj+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MM/gtmtIT4s=:iK1LwHaRbHEssJiibhPpyR
 R/chmrGQvjFIQruD3+NxAwOwCobWiQNCJRJcqiOpb0zGxhlYY350SDebq0/iKTqqMGId9wv01
 ZKBs1ZziDeKsk7M5v7jLYM7rmFSB4vMoARhHNCeiLUvqBr56a57Z9znFf+43+ffgeCo8yJXHg
 HM5q/N8XMZIcf0yEDz5Dfuj3dvumCqwbaEp+AEi4NhhkSHhd4q0HRaln/pd1fL8QM7Vq59mrc
 46jury8ECotqXtu2B8snjoyuxl/2B7JuB6iQbTfkaKD17SiiTtSlW8JkZv1kpvGX/1bDMmiNT
 cg0ettX9DqzeIHnnQ9UGUObb88W2TUCe3K6X+y5XdH8WNdz0IwG0B0Mk4nTdBDEQSkXrg0HtD
 yuyuRaicuKW4EOurwSNrcE75qMAEaCDBc6/IQ9BW/XVPy+b0f2CNoY2fPEKyVdGEonIswRlSz
 honsWumXhC1DMWl85W55COwBzuIJq6IOp3MrwU755xnRsU4TafbGqBVLxxvD6l/FeHA5HMJIy
 nAF6cq47wvvkkVDmoVTWCJP3mBcqKp0CRlFcuveSY9pnEqCnBGKgxITmMg7hZzy9zmxgBd5zs
 xq2ClJ9K0LoE8oN1Gs82h1j1MD4KrTH3/DDxBSfqgLOCg8ZYNVnSmOY0YEQEau2Y8qgOnyaYi
 S1pWamuH3N8tobslBfntZtBum771sXT68pI7rQCBcbtIUuHO22Zbi99/ltV0XQrKcaIKmm5jC
 iOe8x41me1+l4C63rjblemxHiw23oQTGIcHkbdaqWLRtmO7ApDof37uu3w/ugRNAGRNSR95ws
 210ClgP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Larry,


On Tue, 6 Mar 2018, Larry Hunter wrote:

> The same ^M is shown in the output of tutorial
> 
>     https://www.geekality.net/2017/08/23/setting-up-gpg-signing-for-gitgithub-on-windows/
> 
> at item "4. Verify commit was signed"


Please understand that it would be helpful if you could take the lead on
resolving this issue.

If you need pointers how to get started with fixing this behavior, please
just tell us where you got stuck, so we can help you get un-stuck.

Ciao,
Johannes

> I confirm the output is right (no ^M characters) with commands
> 
>     git verify-commit HEAD
>     git -p verify-commit HEAD
>     git verify-commit --v HEAD
>     git verify-commit --raw HEAD
> 
> and wrong (ending with ^M characters) with
> 
>     git  log --show-signature -1 HEAD
>     git  -p log --show-signature -1 HEAD
> 
> I need gpg version 2.1 or greater to generate a gpg key for my windows
> system, as stated by the github documentation:
> 
>     https://help.github.com/articles/generating-a-new-gpg-key/
> 
> that saves my keys in ~/AppData/Roaming/GnuPG.
> 
> 2018-03-05 15:29 GMT+01:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > Hi Larry,
> >
> > On Sun, 4 Mar 2018, Larry Hunter wrote:
> >
> >> There is bug using "git log --show-signature" in my installation
> >>
> >>     git 2.16.2.windows.1
> >>     gpg (GnuPG) 2.2.4
> >>     libgcrypt 1.8.2
> >
> > The gpg.exe shipped in Git for Windows should say something like this:
> >
> >         $ gpg --version
> >         gpg (GnuPG) 1.4.22
> >         Copyright (C) 2015 Free Software Foundation, Inc.
> >         License GPLv3+: GNU GPL version 3 or later
> >         <http://gnu.org/licenses/gpl.html>
> >         This is free software: you are free to change and redistribute it.
> >         There is NO WARRANTY, to the extent permitted by law.
> >
> >         Home: ~/.gnupg
> >         Supported algorithms:
> >         Pubkey: RSA, RSA-E, RSA-S, ELG-E, DSA
> >         Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
> >                 CAMELLIA128, CAMELLIA192, CAMELLIA256
> >         Hash: MD5, SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
> >         Compression: Uncompressed, ZIP, ZLIB, BZIP2
> >
> > Therefore, the GNU Privacy Guard version you use is not the one shipped
> > and supported by the Git for Windows project.
> >
> >> that prints (with colors) an extra ^M (carriage return?) at the end of
> >> the gpg lines. As an example, the output of "git log --show-signature
> >> HEAD" looks like:
> >>
> >>     $ git log --show-signature HEAD
> >>     commit 46c490188ebd216f20c454ee61108e51b481844e (HEAD -> master)
> >>     gpg: Signature made 03/04/18 16:53:06 ora solare Europa occidentale^M
> >>     gpg:                using RSA key ...^M
> >>     gpg: Good signature from "..." [ultimate]^M
> >>     Author: ... <...>
> >>     Date:   Sun Mar 4 16:53:06 2018 +0100
> >>     ...
> >>
> >> To help find a fix, I tested the command "git verify-commit HEAD" that
> >> prints (without colors) the same lines without extra ^M characters.
> >>
> >>     $ git verify-commit HEAD
> >>     gpg: Signature made 03/04/18 16:53:06 ora solare Europa occidentale
> >>     gpg:                using RSA key ...
> >>     gpg: Good signature from "..." [ultimate]
> >
> > My guess is that the latter command simply does not go through the pager
> > while the former does.
> >
> > Do you see the ^M in the output of `git -p verify-commit HEAD`?
> >
> > Ciao,
> > Johannes
> 

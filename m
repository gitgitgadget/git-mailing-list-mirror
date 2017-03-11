Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40CAE202F8
	for <e@80x24.org>; Sat, 11 Mar 2017 21:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934171AbdCKVSc (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 16:18:32 -0500
Received: from mout.web.de ([212.227.15.4]:56852 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932683AbdCKVRz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 16:17:55 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPY5x-1crVE62g65-004luf; Sat, 11
 Mar 2017 22:17:35 +0100
Subject: Re: fatal: Could not get current working directory: Permission denied
 | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
References: <elvahoiwfqayelbskykd@qjih>
 <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de>
Date:   Sat, 11 Mar 2017 22:17:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <hpulcgxossrwvfbbcvcl@zndn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:rXXVrxZlc9vilyTVPlSZnt+ZlwaG3g7RqnYCU8nV9IjCC1mPA4/
 TiTKMpbjvUY0KSW+6Y3RqlHK7C72B3z1RAU3esy5Q17lWDjHUwToKg9PHrdggb/Gh77mCyl
 Yo3lGfxuxEEkFBAoL1hihWEeum6KoQ9+8NpaEMl8kfuo1Nnq1ty0M+xm1/ZnFVp3do2apvN
 XrR+1Js3lbqcwcJ+1sQBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:837yDJoCQgs=:FWxj11DsXTuKbSDOW6dpzF
 fo5JUQ+r7Oy5gOKCQ6GfHlf+jmersE+VIAWq489yybYLcn6qIqqpHCdvBOT3EAnaR7h7Z6NwD
 sH0iGPyrkWdzhI9sKpfNtx0TdfpqGPiHkGg0OH3PlhrVzYxrSTZH4cXli0ENc/UKqmCZpK54V
 oGYOQKNZfkBOCewEOXPJwy+NO/8vULH/9X1DNoJuQh6W7lOSliuuxEaD/FKj8ve94novqEzP5
 6PTlOkZQyfj3BFD4bisUnKf5ZJdFkAYW2Ky/5jxWrCF0JAUA4WuAhDOo8/5rLDEDx7CxJdEq5
 mX/NjrdrK4HD9QrdL4DZJ0bLZtSBoi5LYnQb4x1nqxDm+xsPzXwlu05R6mlVl/c7n1pyotB4d
 grq1ZWxtaUaD4Mhnpa/vHpg99ZDBYbjFt38RrNjujBPTOx/xyE0Z4Mz2JY+hlqPV/OW6p1UWK
 B5Hea6ssgxtX72LVifqPCiehogJwFiZr2+zXPTSrOoZtNNN8+GEw8ZWwhsdrOL+/Fxfg+IfH2
 hKdpMqoKpsLSSpOMN562+hWjVM9xtgvdevMwSgpbUmP49FgzTkst3viiUZMhUMg9bHQJh3FlK
 13MIHgAoQd98wfQURRuY4VF9+wNqhghXkk8eBeE6s5y8+kiFrbybDyofbS6nWiaNVxpSJ/UzZ
 yh9ZAtcOVU/HMIfXCg8h+LxU75mzdvCvRtplkf2TyflL4OQdEibd4WYRsHMCwbIwMremgGNpS
 eUOB3rI5MwCARdbwi8fZjAeprovUevjd0/cW+rhY6OsaM6uCu3MaZ9j2qblxHu36zSwPJ/aIa
 sCuPA5Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.03.2017 um 12:01 schrieb Zenobiusz Kunegunda:
> OK, I printed euids inside function calling getcwd(). Every single
> EUID is the same and have expected value. The same as any other local
> application run by this user. Permissions of every directory in the
> path are OK.
>
> /bin/pwd -P inside directory returned exact path and exited with exit
> status 0.

Weird.

I tried to reproduce the behavior on FreeBSD 10.3, unsuccessfully.  I 
tried with Ruby 2.2 from the ports tree and Ruby 2.3 installed with 
rbenv, and with git 2.6.4 from the ports tree and a self-compiled 
version of the current master branch.

You could try to bisect the issue to find which commit to git caused the 
behavior change, but that will be a tedious process (compile and install 
an intermediate version, run bundle install up to the point of interest 
then hit Ctrl-C, clean up somehow, run "git bisect good" or "git bisect 
bad" in the git source tree depending on the outcome of bundle, repeat 
ca. twelve times more).

But I suspect the cause of the problem hides somewhere else.  Why would 
pwd(1) be able to call getcwd(3) just fine, while git gets an EPERM 
error for the same call?  I'm stumped.

René

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A573B202F8
	for <e@80x24.org>; Mon, 13 Mar 2017 17:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754496AbdCMRcL (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:32:11 -0400
Received: from mout.web.de ([217.72.192.78]:55310 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753728AbdCMRcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:32:09 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgfJz-1cYoSR2S87-00NvmM; Mon, 13
 Mar 2017 18:31:56 +0100
Subject: Re: fatal: Could not get current working directory: Permission denied
 | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
References: <elvahoiwfqayelbskykd@qjih>
 <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
 <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <bolnkqijewdhfhyoqodf@zfyt>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b9dc5b05-46e6-a3d7-2fb0-638bff2da676@web.de>
Date:   Mon, 13 Mar 2017 18:31:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <bolnkqijewdhfhyoqodf@zfyt>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:FL21Z4aZFGUXPQmFiWKcKiRMaQxPKCe5ZPmPKR8CAAui7XkciNV
 x3b+4z3+YpA4Kq4o1GR0WLe97I3uBwW6IK/OZJ4kV/YWroMNmAgg+tNQunvJ6zdmdrKQSJQ
 T8AJjL/cqv/BsWvlqxjh6PhZN74PsPb401DDaRdO9bckuZjQppX9cnUtzPBP4WUzhc86pOw
 /haH+FUh8uJ9Y6j5nrSFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PyTEqa8Dzi8=:jnf1bWesiXn4oIGP4TtHe8
 NK/UsJWGArECfXd5A/CAEn+mWxJf2ORY6n3Jjro5sIddH8R123vGe3favgH1B1gPlAW8p/E2N
 uJmWvzPfkUr5dAjEOAAfXuNmDZRur4qDZOHxKnSMPisZN71S1HEs8Zao1xGjHHpI0grLdb7V2
 9JS4nZTngYvYstoUC1zxPzEh8LTfdJpazyCpEuQaCQTi0B6uIRml+8kdpGm76K+nscQYab/go
 iJpd2thh4NX/UXjYE5T56HbCv8+vZAwxGrcrpkCD+2UDe1U17M32GIMLoXGG2aUcgMGfoWnwP
 yl8A+TG9sfKyXZ/HZ21QBbiY3wKUJHZIrO+oYT3CJMyhBBsNNwAqoN/Cf/nDGiIvcwsEwT4aU
 VsidbCdBdXrq57CoLzti6yYIW60ikxLrlwKX/YoPVf1B+ecKPQ7hf1/w3N3Logp7zrMwqpoBM
 dbiqMgxcAP7q040u6ZqdGQWp18AsqTtvGu0jq59yoKN6bx0/9bg6Zq/WfYuKSt1F+pUWsPYJ1
 kzEweGZ5b/TzFY2IPamJGkQobZQqx3+uCEs7fsmcwgyfQFY+0YdSV8fsfkovs0hyWAzI1vAmg
 sXSYNZ/SRRxiXRS+zPbRmKUdMmd9DlKMnwXhlxiGRJpsAE0ej63z1aYWRZuJsVED2VyZT3c5u
 74/kQAaC8m0fjGfVKWMlD373jlmqe/ezFGw7eJIB/ZpKJ+0NiR4mcb6h7oHOObO2G+TN6ZtAC
 UjN0e2OhGiQarwPeMeip5uVPnxBXPMq7hTUa/aoMGJsJ5bVgC93uxgUkzVeYr+bw4fw7xdREc
 5Qa24rQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.03.2017 um 13:23 schrieb Zenobiusz Kunegunda:
> Tested on ZFS filesystem
> 
> 
> 
>     [test0@s0]:<~>$ mkdir '232222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222'
>     [test0@s0]:<~>$ cd 232222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222/
>     [test0@s0]:<~/232222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222>$ git status
>     fatal: Unable to read current working directory: Permission denied
> 
>     [test0@s0]:<~/232222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222>$ git blahblahblah
>     fatal: Unable to read current working directory: Permission denied
> 
> 
> But when I create directory with same name (232...) as it's subdirectory everything works as expected inside that subdirectory.

Earlier I checked on UFS.  Now I tried the above commands on ZFS,
but they work as expected:

  $ git status
  fatal: Not a git repository (or any parent up to mount point /src)
  Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).

Git checks out if it's in a git repository and if the current
working directory isn't one then it goes to the parent directories
recursively until it finds the root of a repo or a file system
boundary or / (root).

You can see where your invocation goes to with:

	$ strace git status 2>&1 >/dev/null | grep chdir

René

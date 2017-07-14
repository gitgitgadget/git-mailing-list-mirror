Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF5920357
	for <e@80x24.org>; Fri, 14 Jul 2017 21:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbdGNVxB (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 17:53:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:56031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751012AbdGNVxB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 17:53:01 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LevUh-1e0BSp0ijf-00qirc; Fri, 14
 Jul 2017 23:52:56 +0200
Date:   Fri, 14 Jul 2017 23:52:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Paul Smith <paul@mad-scientist.net>
cc:     Kavita Desai <kvdesai2@illinois.edu>, git@vger.kernel.org
Subject: Re: Git Bash Bug
In-Reply-To: <1500066765.25789.111.camel@mad-scientist.net>
Message-ID: <alpine.DEB.2.21.1.1707142345050.4193@virtualbox>
References: <CAAu0pLedy5xqUgF7drMf=tQgMJD4rXq+JvKaiE54EdRFZWuTkQ@mail.gmail.com>                 <alpine.DEB.2.21.1.1707141625150.4193@virtualbox>                 <CAAu0pLdmGc_kq_w0Fm6W4XDqOe=iKSyAyLct+yH6y+7FPUHtnA@mail.gmail.com>                
 <1500043024.25789.105.camel@mad-scientist.net>         <CAAu0pLdjvcxda0rip8JOzt1q0HNuu4dBNHvEzJbeey6yRSyCCQ@mail.gmail.com>         <1500044588.25789.109.camel@mad-scientist.net>         <alpine.DEB.2.21.1.1707142227240.4193@virtualbox>
 <1500066765.25789.111.camel@mad-scientist.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hJdu4Ph+35nOp7IccIZUT7duvbGGS8EdQgSm4hEQkB34hA3vOPk
 Y1io+XkHbqHkAigFgEcc7J1PF+OgsJcYeJ7f6NsFwPUvI40WLgtrEDtIYdaVtY8EBg/DiY8
 8KyAWrfLaPFZWWvpz8r4Amu8a473jFCxD7i5OjQhBNcANOIkAnrF5mVmijqL22wnR4A1Fvb
 kJ9mNo9yoGSd0uwbyHu8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C3pWV3GA4SU=:sVGwwsFS6C+1iBQlNx9tWb
 ztWgtDk6ARG2qlknyJJOq4HzKLM+Mtzz9j1r8lHJZ0tU/Be7iOyIyl/UaZG6OxR/RwHl1e92b
 9jmX4zTTKHR36O858gieAYE2veD2HidwH03dQR7/Pb7Fl/XY5jY+AjdXFgXE7kRNKr5YzPJwc
 ggAPI0gsOyAczc6wjnNWkqu7vkBXmS/3F6xmQmW1+HjdZz4SZE0en7Q/HxnOTknRXNIPjsoss
 63ZOp2niZLhBCOGRR+gOWXz8Owm5EC9Mx7nOG1zW9rlSV+7qrdvC5PrNGjYRiHuxqPL58y4aV
 +podXF/yVNYtRUzdEQ1DCT+eXkhsGXDaM/QoBUNQx5jKV/n4YKB55DqTLAOu8QTjC+3YOJLQG
 vKUNwJAH4g3hP9lFJ8U+ZJ9+UpcXX6j1YfZNi0jjfOnM/U/XxTpoAPXk5Y9UCsjcxX8tEfMXI
 Hz061T0isWda41HwWW0Ev5DCt0k/D9KY4i2wRLmjssjRJesu0d7KjcVFyYAKL/96zYC6ooL1E
 UUIpKGLxjpjEotfTiVQh2QQ1anu72NZd+i8EH7zd8AW3kvQsacVHSaGgcn7Z4VQlfRnDPcKx7
 YiwRpAjorYixu9LPf8unHrDl/WD1oXyJng9l/SXJB0DdZ1vWAC3LVoe8FsHXfR/UNNaWrhm6T
 6gvTDMbVKHMgcnwG010ca/fSLUPMaInrqVgIZP5BlHrytFlmgUwNhLuzWaCxFFRmdKYwTZ5MK
 Pdn4jfO7Yc71lhTdFaKz7okNhVNXdWG2PV0g6PtC/26UxuKf/XYANSPhgjyEGCdPhmCq5Swg/
 FtbED51ClyoujaVs/PAwfRRg4FllT72yK9qK34qWulZ2KpxD3I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Fri, 14 Jul 2017, Paul Smith wrote:

> On Fri, 2017-07-14 at 22:33 +0200, Johannes Schindelin wrote:
> > > You absolutely have to have /bin and /usr/bin on your PATH,
> > 
> > As Kavita talks about Git Bash, it is probably Git for Windows, for
> > which /bin should not be in the PATH but /mingw64/bin or /mingw32/bin
> > (depending on the architecture).
> 
> I did check this with my Git for Windows installation before posting. 
> Mine is older (2.7.0) though so maybe things have changed:
> 
>   pds@build-win MINGW64 ~
>   $ type -a ls
>   ls is aliased to `ls -F --color=auto --show-control-chars'
>   ls is /usr/bin/ls
>   ls is /bin/ls
>   ls is /usr/bin/ls
>   ls is /usr/bin/ls

Oh wow ;-)

For the record, /bin/ is simply mapped to /usr/bin/. They are not
different directories, really.

> Clearly I have a lot of duplicates on my PATH now that I notice :)

;-)

> I have /mingw64/bin on my PATH as well but looking there it has git,
> gettext, edit, a bunch of DLL's, etc. but it doesn't contain ls or
> other coreutils programs.

Right. The difference between executables in /mingw64/bin/ and in
/usr/bin/ is that the latter executables all implicitly link to
msys-2.0.dll, i.e. the POSIX emulation layer based on Cygwin. As you
probably guessed: the coreutils are all compiled using that POSIX
emulation layer.

Ciao,
Johannes

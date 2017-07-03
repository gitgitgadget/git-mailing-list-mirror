Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3720A201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 12:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753292AbdGCMe0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 08:34:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:60515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752081AbdGCMeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 08:34:25 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lug8u-1dsZra3wKu-00znrV; Mon, 03
 Jul 2017 14:34:15 +0200
Date:   Mon, 3 Jul 2017 14:34:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Adam Dinwoodie <adam@dinwoodie.org>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Continous Integration (was: RE: Git v2.13.1 SHA1 very broken)
In-Reply-To: <20170702203548.GA26574@dinwoodie.org>
Message-ID: <alpine.DEB.2.21.1.1707031429560.84669@virtualbox>
References: <20170605203409.GB25777@dinwoodie.org> <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com> <xmqq4lvtap3m.fsf@gitster.mtv.corp.google.com> <20170606100355.GC25777@dinwoodie.org> <xmqqmv9l8h5z.fsf@gitster.mtv.corp.google.com>
 <20170606124323.GD25777@dinwoodie.org> <6D15A44412C346E2822A74A91FDF77B1@blackfat> <CF387D0C-6743-4B88-A4CC-D6310A634E03@gmail.com> <20170702203548.GA26574@dinwoodie.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0glQYbvc4qd3rbVqy/zX1c42n2eRQeiqT2D0bt+Cn7T5TxDA/9F
 rqv962yuiJ+fPO/1iUR4OZgXoMdvSCYv3uohB93ZOPkmimCgVLSgpSDq2sZ7N33VphWCevG
 BzuTkfgw/HNG7KHEwmxcQwj9d2zCFO5GwRIlYYbU5ZQy7NviXLiAux6lnnTs9HHSDejvV5O
 d710UxRHjz2PiY02wdX/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Fonns/Atek=:XCSCmwF5+7ToOfmge7ypfP
 6Q1WXNNyjD6Zygva2dQL9XgMCLNOoFA19SyXM7QfoOIo62IhaC9pEEsgXsG+Y2KoljmtK0hsy
 r1Bg+ZTfFvTtXMT/QmyTI0/tfOMP5y0pXwpahfNmfBtwdpGCmlnOKIC0nS+lMtYXwIS/utnxA
 vm4pT3Rc4B/UWCybnZgk1HFs8FB21BI1GBCMRFz5rNN4O1pRXPKX591mR9Pm2QpQfzMLUfxeu
 qY/YIz/yQ396kAgNU13dTmqYu/c902FjS+J6MqG3bq0lClEQWN3ofU616MVzWmKjfeDkwInYV
 udajqmVksRHCRqNfDTcv3HFwtOnehedS5djUuUpREwARoR/HSjGC0Pmvjh2EUMHd7YP9TuPqD
 MbR2naG08DBmLGXS5cJcj55onhiENctPapEwGWEamSlWdVlJzF0H/YpM1cnxRzcaqhRG/mHbZ
 isxCuUx2N8Ptk2+cUHC1ehcGpNHua0StL0a/5mZyydOuQyozhZvnZpyLZqNDtzUwmHaTxZa+k
 di3+RB5PjLynfqCbS0GSQ5hRUfU9KwpKVOZdEeJgy855GLoGgSqxUTzaBGqBNeyndyaHsRVow
 DOAW7HtCH+7fypcCM3CDDsV0OfSCkXvxGk+Y2jzEDglDWyiwPTB1udm8Aa/Q4ZHStCaK+wW5Z
 KIqEAZDireoiLFqXsoDU4Wyml9QUvb35tZZC96WR/Yn5RbWwcn/nErG4Pa0NeIwyKLt/WErTA
 sCRCtG3+6hhamlnep0em38l/yijfXJgZsAPhtkWYFnEMD1KNu1Di3vdJetyePTN95CIYiFR2h
 ykxZ+m9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

On Sun, 2 Jul 2017, Adam Dinwoodie wrote:

> I do the builds for the Cygwin distribution on my normal PC (so
> reasonably powerful but definitely not devoted to the purpose), and
> doing the build and running the default tests takes in the region of 8
> hours for the 64-bit build and 12 hours for the 32-bit build.

Wow. 8 hours. I take it that you are bitten by the same issue as Git for
Windows, where Git's test suite uses Unix shell scripting rather heavily,
and Unix shell simply requiring tons of expensive emulation to run
decently on Windows.

> At the moment, I'm trying to set up automated regular builds on my PC
> using BuildBot.  I think that, short of someone donating some fairly
> significant resources for Cygwin builds, that's going to be the closest
> I'll be able to find for spotting problems early.  It's a project in my
> currently limited spare time, though, and not something I've done
> before, so it's taking a little while to get going.

How automated is your process? (Including, most importantly, updating
the Cygwin build setup...)

I ask because I could possibly set up something using the existing
infrastructure for Git for Windows' testing, as long as

1) everything is scripted, and

2) you do not need interactive access to any box (I mainly use Docker
   containers to run the builds)

If you are interested, feel free to ping me via private mail.

Ciao,
Johannes

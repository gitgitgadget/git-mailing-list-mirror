Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E152020A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 13:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeLLN51 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 08:57:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:54359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeLLN50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 08:57:26 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMShK-1gWWWQ2uDe-008HjM; Wed, 12
 Dec 2018 14:57:24 +0100
Date:   Wed, 12 Dec 2018 14:57:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     svnpenn@gmail.com,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
In-Reply-To: <CABPp-BHqJ_Dqpi-N-GVu9difvh-SnD1SZ2-SqaG0ctu5fBX-Tw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812121435570.43@tvgsbejvaqbjf.bet>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181207170456.8994-1-tboegi@web.de> <CAAXzdLVTjCVDmBik-j9B_Z_2wgSj=_6baqmjmGEGBFOsjkyOsw@mail.gmail.com> <CABPp-BHqJ_Dqpi-N-GVu9difvh-SnD1SZ2-SqaG0ctu5fBX-Tw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W1niPsFyJJ+cJhnXq/Uy2dR+YjSQZ1FUD4WvTAoZVlQ/S8BBSYw
 Jp8jh4pNLD86wsAs7TBjBVdydHOYLHuxSCX2mIvp6eidQIFYQqSl8zxUzKY5AjeGEDjkSFN
 id4v367hQySAewap7xwkGiJ3p1DN30WY4cFiBO9h4WG25ueOLZbyy8P20MunkJzOm2c6oHf
 NPdH2niY8YxBPA8/JnsCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D9V3IhKKfE4=:Y3b60gItVjcyl34a5OsBmu
 1Hx2F+bKrME4PqtXNPjMdkIbpVtBe3Of8N3Gl4+doqYLqc+CEVyGmneCImXrSC3zMQN+Rjwq8
 PADs68NzTu7tHFzGnhk01MI/7qya41zWNaN8jbcO+R8crBWb7p3VhJlS8MdUtPZosYaGkamN0
 vadN6lWiMSDwSbar7nmhkvAPGKKTKQqBA97bltPd8oiE8hQ+mZaEj2th2Px3F/csn6+6Jo1mg
 YY+zyfncUYDN/7r9ZquQ9+aNpdv7D/50/cxZYSE/aSCY5wJUbBb92nig19mHzHGmy5xNN0syr
 MhbYTWKbxTr2rZ7x4yFd2+Wn1J5cn37SqC99apMZHFRTHwGn2xTtllX0QgV5XzGc6FICTBTTy
 wQsPXBPu1UfrvlvFYflsLWD4LTYtjgDPC3KIEuiUOSTnwtk9DOUUue31b3VVraqfjNq/mmNhh
 CPV6EXx6q7MXjDLuPP8g1/qx/z9JW8Y5zJDeKitT52K4Nv56K6thmDKKwR/TZlY8zyb1UWudW
 /t6iS4k3WR6lwaQDfTuI6w5JkI1gaDtlS7pXU1sTD3AhWy9PWf6zrvU3QtSDq/5UZ4GVpXIoU
 w+AJDf5SmGdifIovNKFVuHspREoxek3m6lAK5+QetSux5EHVRg5TsbsWXSmCKytPoGAMKnTzP
 tRYIU8HudNFTsMK5kDDdA5CVYvavDJK3xVusf7mHv/5tPyGYGdlOS30kfLbr4FkEBwF+VXVF9
 lAU5JRD4Sj00zZWLZSio984Q6hCfJh900Y9bQkrSJ8kUpnLnhtkv7kti9NiPcoRynratGCMt9
 owq2n+Bz9SqfJev++XSyfFxa5u7EU/aHXJrjmbR3EOmYFMqTCs9DxSupMeL9766MC2vjnK2Wo
 AY0HbMpkMT+67h4Et1330gIg2/TjghhVPlBMII5JUefwJm3Asml5g3Aw+eWwe8l1cNlt9uHQ+
 1NkFAKz6rSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 11 Dec 2018, Elijah Newren wrote:

> I'm worried based on other emails in this thread that there is a
> fundamental difference in frame of reference leading to a
> misunderstanding about rationale for naming, and worse that folks might
> not even realize where the misunderstanding is coming from, attributing
> it to different motives rather than different frames of reference.  If
> that's true, I hope this email can begin the process of clearing up the
> differences of understanding.  If I'm wrong, then I apologize for the
> noise; just ignore me.

I think you brought up quite a few good points (also in the part that I
did not quote).

The part I quoted brings up one particular aspect that I would like to
drive home a little more: the purpose of naming, and the historical
reality. ("hysterical raisins" comes to mind.)

In Git, we have an awful lot of references to MINGW, which is the name of
a project that tried to allow compiling software targeting pure Windows
(i.e. the Win32 API, without any POSIX compatibility layer) with the GNU C
compiler.

As many open source projects require more than just the GNU C compiler
(e.g. a Bash to run ./configure), there is also MSys, which is a minimal
fork of a then-current version of Cygwin, originally intended for the sole
purpose to support building MINGW software.

To make things more confusing, at some stage the mingw-w64 project was
started (not as a fork of MINGW, AFAIU), to address the notable lack of
64-bit support in MINGW, and later the MSYS2 project was started, based on
mingw-w64, to address the same issue with MSys (also not forking, but
instead starting from scratch).

Back in 2006, when I started to port Git to Windows, I made use of MINGW
and MSys (and I abused MSys by shipping their Bash with Git, which was
distinctly not intended a usage of their Bash). Hannes Sixt picked up when
I stopped having access to a fast Windows machine, and kept my naming:
compat/mingw.c.

Now, Philip Oakley, Jeff Hostetler and a few other developers spent quite
a bit of effort to make Git compile also with Visual C, and of course the
reused parts of compat/mingw.c (whose name now does not make too much
sense anymore, except in historical context).

Likewise, when I switched to MSYS2/mingw-w64 with the major version jump
to Git for Windows 2.x in 2015, I no longer use MINGW to compile
*anything*.

I hope that this illustrated a little bit how our names came about.

Of course, we could now spend some time to change the names to reflect
more the product and brand names involved. There does not seem to be any
really compelling reason to do so, though. And I'd rather spend my time
developing exciting features. But that's my preference for my time, so if
anybody comes along, making a strong case for renaming, in a well-crafted
patch series, who am I to say no to that.

Ciao,
Dscho

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DCE81FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 10:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbcLEK4k (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 05:56:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:53219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbcLEK4f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 05:56:35 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyVIk-1ciDKz2bxe-015tuZ; Mon, 05
 Dec 2016 11:56:31 +0100
Date:   Mon, 5 Dec 2016 11:56:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "P. Duijst" <p.duijst@gmail.com>
cc:     David Aguilar <davvid@gmail.com>, git@vger.kernel.org
Subject: Re: Error after calling git difftool -d with
In-Reply-To: <c0c8c333-adfa-ad58-f1ec-7239a3a16528@gmail.com>
Message-ID: <alpine.DEB.2.20.1612051142550.117539@virtualbox>
References: <5f630c90-cf54-3a23-c9a9-af035d4514e0@gmail.com> <alpine.DEB.2.20.1612021704170.117539@virtualbox> <20161205051510.itftw4hyzkv6nnxn@gmail.com> <c0c8c333-adfa-ad58-f1ec-7239a3a16528@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:x/Tevtnk5+gaaEjOseIH9EcxZ4Rk1Rwch9z11eaaSW3Dl5s2VEI
 BJ2TZCbejSY0egwQ9UJ57Zkl0z/W/M/UpYE+thf8hlEmndHv/JVV6qM3CSzDzfpkRFE2vHb
 7Zm85LUoidmfTiv27dx8cmn1Njeh/e+UeeXGWm0+qn5mxVeDEIEJuZ8hIksPCMqXpKJCK/L
 oV5lES+iMPM2XZ35a/tVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KstYtLAh7tE=:FrVBrkp94ZzPbnTJux6s8r
 qSkriIzhbx45PBd/WHY9kylaR7/gD8IOHQBNKeKHVi1Gc0vvH9IZ6EUykXoBDUUo1gbeOviFK
 UE6PEl2ojwJk6Zw6KrlrduGt3DGweCjgfJ0gJ+V+pIlxylJitvLaAvUFkKf3sm/mAwyh57j4Y
 7TXPtrZAYOA3gbeNgqo7EHsvWz24K+wjaSZEvHpiu2PHpobJGdWwHdTbUsqSqafxbktMqPNjt
 ptZKASDpcvyH+d4A/P3zf9oLUsZq5kTBrwBKZROn58BIQHOdzrv3BytNKUmzWlE3aATGu0dAA
 SvbPYCK0mlBiN7jcK78FY11Im/ljgYpF/zqzpHTC0RnpiloE3JSguEITsqGRB2VyFGrFzsksb
 W69r1CrPP8QjcNe38oYfbl5pK96I0sKfrdHhqv/rGEL21DBbYFF0Bxr+iYYTsLuHT4APZm9Gj
 QrUgZEIHKhAupFEwoZq71kcDFm0XpF0I3OmsE6EY7ALs4XK/0iqduoOwz+hNpdjb77O6/VF1Y
 XM/p08YImGEj3YjHzRNJiHW/WtM8CkBx+VS4nYgcEilR9/34E2nz0heavckJvSH0Rk49SzWyX
 lKXvcCooGbOFC7UGRjLkmWYkusS6by2Xp9HSC3xjh2a0RT1L4fHo2vAvnHGz6Va1y6z4DxQHc
 /1IKT4YJ+eMX7+1+lrN4+X+Abl0aaKO3hDd44crt8Bkd1Q4tJufTRASjpucMH92WCvXa60S2i
 qYsms5WYEFxmW+hCMVwl5S+0EFhb0cv7P/DdoiB7A7iafh2YMDnTniEUF4jVNmSV7EjV8LqK1
 NdVHxvd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,

On Mon, 5 Dec 2016, P. Duijst wrote:

> On 12/5/2016 06:15, David Aguilar wrote:
> > On Fri, Dec 02, 2016 at 05:05:06PM +0100, Johannes Schindelin wrote:
> > >
> > > On Fri, 2 Dec 2016, P. Duijst wrote:
> > >
> > > > Incase filenames are used with a quote ' or a bracket [  (and
> > > > maybe some more characters), git "diff" and "difftool -y" works
> > > > fine, but git *difftool **-d* gives the next error message:
> > > >
> > > >     peter@scm_ws_10 MINGW64 /d/Dev/test (master)
> > > >     $ git diff
> > > >     diff --git a/Test ''inch.txt b/Test ''inch.txt
> > > >     index dbff793..41f3257 100644
> > > >     --- a/Test ''inch.txt
> > > >     +++ b/Test ''inch.txt
> > > >     @@ -1 +1,3 @@
> > > >     +
> > > >     +ddd
> > > >       Test error in simple repository
> > > >     warning: LF will be replaced by CRLF in Test ''inch.txt.
> > > >     The file will have its original line endings in your working
> > > >     directory.
> > > >
> > > >     peter@scm_ws_10 MINGW64 /d/Dev/test (master)
> > > >     *$ git difftool -d*
> > > >     *fatal: Cannot open '/d/Dev/test//Test ''inch.txt': No such file or
> > > >     directory*
> > > >     *hash-object /d/Dev/test//Test ''inch.txt: command returned error:
> > > >     128*
> > > >
> > > >     peter@scm_ws_10 MINGW64 /d/Dev/test (master)
> > > >     $
> > > >
> > > >
> > > > This issue is inside V2.10.x and V2.11.0.
> > > > V2.9.0 is working correctly...
> > > You say v2.11.0, but did you also try the new, experimental builtin
> > > difftool? You can test without reinstalling:
> > >
> > >  git -c difftool.useBuiltin=true difftool -d ...
> >
> > FWIW, I verified that this problem does not manifest itself on Linux,
> > using the current scripted difftool.
> >
> > Peter, what actual diff tool are you using?
> >
> > Since these filenames work fine with "difftool -d" on Linux, it
> > suggests that this is either a tool-specific issue, or an issue
> > related to unix-to-windows path translation.
> 
> @Johannes: "git -c difftool.useBuiltin=true difftool -d" works OK :-), beyond
> compare is launching with the diff's displayed

Perfect.

In that case, I think it is not worth fixing the scripted tool but focus
on getting rid of it in favor of the builtin version.

It's not like it is the only problem with having difftool implemented
as a script...

Ciao,
Johannes

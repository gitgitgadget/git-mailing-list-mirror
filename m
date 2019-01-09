Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB5A1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 18:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfAISje (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 13:39:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:50437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfAISje (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 13:39:34 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McVKy-1gyy8V0mUy-00HjDi; Wed, 09
 Jan 2019 19:39:27 +0100
Date:   Wed, 9 Jan 2019 19:39:11 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bret Barkelew <bret@corthon.com>
cc:     Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
Subject: Re: git version 2.20.1.windows.1 throws file name too long in gitk
In-Reply-To: <CAGTkKag-fTy3iZAKJxEnWD6_b_3pfuYvQQKBkLaeSL8wKM2sfg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901091936420.41@tvgsbejvaqbjf.bet>
References: <CAGTkKag2sFy+Of=6uQeiGOQm0-NBrh9ixgzDoQXKR73+Ct3raQ@mail.gmail.com> <CAGyf7-HcncFOfmm5McEkOvCTkHNdePDSEQDZwEAK=z1bmC=QKw@mail.gmail.com> <CAGTkKag-fTy3iZAKJxEnWD6_b_3pfuYvQQKBkLaeSL8wKM2sfg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1227504823-1547059167=:41"
X-Provags-ID: V03:K1:B0yWPe7pMr3w7q3ZLgXSwm8RcCT2F3yBxBlFfiOBNcymKPA/2EE
 gVtsmjYsEepV0Q9KF+00pW4CMylAwQ7VSig98C28xHTzsGdbheplmVXwkgVR0Kt3hMEPE8E
 7Sj4Z5VQ+BE9Sw9Dyt99y2WRI+F/0OsuzdHfnDJ0R8RZHsA6JCULat2BVakSgKUuWd7fu1B
 64AUL356lzADkmYauOADA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ecufx9ODy1g=:KqOuCeF6IM5lvE5ROvrjeX
 YmDptAfPbEk0913VS6RM/nzGd1Y6860K7h2uR8F0OLsfwgqXebjfp07zV43KZDsf1IUBa18/9
 bIigvj6f5LYgyFwxN9eBB3IwJQfv+D/X5JNBzbyQwjr05uZz09l4FE/nqLcR2wcoBDY1Cs+HL
 A/hXm4T0Wsfispvpp16m3IVqnu/DxHtzkEVqG14sEMD+ZkIQtLXqUUf/3KWt9ATT75HtpExkE
 CdTZ//yca8+aQJvmJuYaLxLSTx6yxBSIGJ/5XpJL3cfIkF73kDbBdkst2iwjCtIvdlU2ikoEN
 W+AvSADQHZj9UmKNW4ruOZzln2wEZFVmFFX6wjXAU/DDgaVOlW0rLm8MQ8cHVLb5f3ps5GDgu
 iuvQbsM40vCFaAooOZytJ7Z6srxXXBp2fVoYOnOPYqHicLcP49XPaGLutFJBUNNxXqHr5qZCF
 pHJu2fSZql/lT4DG4t28olg+Pfd323DaDjLm40gdNg+hruLgq6Pz5W/mcsr0j0PAj2Uz36qCb
 CrOmdKncWEIMeY12m59iE5Aox+FOZsx4VMb4XJXmq+JXj1ORWVPgNs8XJrXdFw2wj+xqZOFwa
 EEQN1odntOuBzBPp0PK5XXDke2T/rvIbEayaHU38pwHH957nqSm+SFShGpH9+TPgz66oj+Joc
 sKK2dWHcqkRGCkmeoQh/kgFIc4g+MBKJE8+dtDhOr+y/eUwlT1k5wsZCCI2hZMPNsyZgK6MhZ
 oPd7J89WA588rBVI2m8XbGJRm3riyAYs/3SOTqlUcEvlL8NfctD0EQ1mTHEKHeVmk/7fxu6gq
 PDHN0/NwP2BWx6F604K4rW17cFsLfMz90voHE/HfptTMLAASV5kEeQtTAwNXnIDeohy1iPCqe
 +C/2qvff1C7iR2gTgPf+9PQwjzeEadUxJZvA1uKGwUkPM5NoG8Cnavzx5LNCeQMCoOZcyOelh
 KTFSWN7ouTg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1227504823-1547059167=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Bret,


On Thu, 3 Jan 2019, Bret Barkelew wrote:

> They are the exact same path (with a different drive letter).

[it's a bit hard to follow the thread if you top-post a reply to an
inline-replied answer, maybe imitate the style of other mails in the
future.]

> Another thing I've been able to confirm is I uninstalled git 2.20.1
> and installed 2.19.0 on the failing system, and the older version of
> Git works.
> I've also tried a suggested fix I saw elsewhere to enable long path
> names in the Windows registry, which did not resolve the issue with
> git 2.20.1.
> 
> Happy to collect any additional data.

Please try the latest snapshot at
https://wingit.blob.core.windows.net/files/index.html (I *think* the bug
might be fixed via
https://github.com/git-for-windows/MINGW-packages/pull/32).

Ciao,
Johannes

> - Bret
> 
> On Thu, Jan 3, 2019 at 7:10 PM Bryan Turner <bturner@atlassian.com> wrote:
> >
> > On Thu, Jan 3, 2019 at 6:21 PM Bret Barkelew <bret@corthon.com> wrote:
> >>
> >> When I open gitk in a particular repository under this version of Git
> >> for Windows, I now get a dialog box that says "Error: couldn't execute
> >> "git": file name too long". I've noticed that the most pronounced
> >> effect is that I cannot see the file diffs (or sometimes the file name
> >> list) for any of the commits. I don't know the exact repro, but I've
> >> narrowed down the following things:
> >>
> >> - This does not happen with the same repo if I use a system that has
> >> git 2.19.0.windows.1 on another machine.
> >> - This does not happen on my current machine in a freshly cloned repo.
> >
> >
> > How “deep” are the paths to the different clones on the different systems? Are all of the clones at exactly the same path on disk?
> >
> > Git on Windows is (by defaulted) limited by MAX_PATH, which is 260 characters. That length is calculated including the path to the repository itself and then to the file inside the repository. That means, for example, a given repository cloned to C:\repo may not have issues, but the same repository cloned to C:\Users\Bryan\Documents\workspaces\repo may.
> >
> >>
> >> However, as soon as the remote updates with any changes on a given
> >> fetch/pull, the repo is put in a bad state permanently.
> >>
> >> I've pasted the output from gitk below...
> >>
> >> couldn't execute "git": file name too long
> >> couldn't execute "git": file name too long
> >>     while executing
> >> "open $cmd r"
> >>     (procedure "getallcommits" line 48)
> >>     invoked from within
> >> "getallcommits"
> >>     (procedure "readcache" line 80)
> >>     invoked from within
> >> "readcache file827e200"
> >>     ("eval" body line 1)
> >>     invoked from within
> >> "eval $script"
> >>     (procedure "dorunq" line 11)
> >>     invoked from within
> >> "dorunq"
> >>     ("after" script)
> >>
> >> Happy to gather whatever data needed.
> >> Thanks!
> >> - Bret Barkelew
> 
--8323328-1227504823-1547059167=:41--

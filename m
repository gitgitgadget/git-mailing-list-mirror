Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2662207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbdEEPMq (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:12:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:50292 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752864AbdEEPMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:12:45 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQMBU-1dTreO2wpw-00TpfU; Fri, 05
 May 2017 17:12:40 +0200
Date:   Fri, 5 May 2017 17:12:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "G. Sylvie Davies" <sylvie@bit-booster.com>
cc:     Git Users <git@vger.kernel.org>
Subject: Re: not uptodate. Cannot merge
In-Reply-To: <CAAj3zPzHiwgS=2CSKP1y8zGUxHUWiq9TSeMhixeL+9ZfffY-pw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705051708311.146734@virtualbox>
References: <CAAj3zPzHiwgS=2CSKP1y8zGUxHUWiq9TSeMhixeL+9ZfffY-pw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2023613480-1493997160=:146734"
X-Provags-ID: V03:K0:Bbo1dFwM4g9F0qfe7ad2gc2Z8MpkfHb8WyXDu3tOYuzJhd3vCRE
 Jp+6957cY+3KEdYmoqy+1HBBA8TI1QUqgD5XWdqfA659z9uEocwfBHRBQJxw43f7r4dUohI
 GjgT0KP0r+9oBOJykcJoAsE2J/4eTLoumXG6IDZfOkMJuE08zMfdzG+RCm95C2/Z3myQ4Lq
 W8fiyYiYPR/HIl/HvSDhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hy6lFBZSGv4=:7W+bpSEHTxg/WeMfu09k8M
 YgyT1dzaTIsuNT+qvhMSR4jrOW7aa7YEoQRMgdDOnUtOnpeQnjs3NmVZ9a+pAVUOvi0i3O/JJ
 sVWWwlCQyPlkt7+nhVs+aBrXLv6CL1HI4Z2mj00Hq/6IQhpJlKz3LI/8vq2r6jMg1T/0QpysD
 PKogOqr/kYP9+9f2tUW7AyIWgeEvgl3Wf2bdZ7HFeBg5L4QH6qA+X3oD515vSo/LjAY3S1OAW
 zyN/czSCB6yIIEEUeb4EV3BwB9k37B2z8kt+SqYV4IIbW+PibvneYFSQkm2tYH2NESpxybMEO
 T0DLRrvRjiY+VIiFLxfSQAVQA3/cd1EJJQHJh4r08yyQa9qB47s8hPAOQMUiplvGz94VYEylG
 PR5kbzmDItPD0rlqiKtlzwOcI82W+SLT+GlBE7R9cHJxAtL9U83KA//kCqW5IJQnz0fgAxtg7
 sC4R0aWinN7Mg8lguoPRuSFKU4ir82hrVNTlu/HuAv7wK7KgDIUMPYHJqlAcoOV9/nxImR03v
 DWnZq14+Rw0Fa4n7HWNzdCWsQ4RHjK/Fj9gxhA3F6GZEmUjK+DAFO916tokkxY/UmQenSSvFz
 zx321V3H1JgtsQLrDbe2UR9ocwDcD5ZBhxKDDHZp8zUVkgqRI3mQZ1y0drkdj9KKi9fXspuk8
 DzPxN2o6Urrdu4JrvXyXV7tmk2Jxr0j288ws2E3ffK+EiAPcCZhaj1PoBVLg5b4EuzTV8IQze
 3Yro30AUENUpSL1jCOMVuUUVPhuPahX7Zt2JBhZp7lZ/dRVycCXnsIs4jVI8YWjrl/TQecUTg
 dxPb+l0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2023613480-1493997160=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Sylvie,

On Thu, 4 May 2017, G. Sylvie Davies wrote:

> My situation:  Git-2.10.2.windows.1 / Bitbucket-4.14.3 / Windows
> 10-10.0-amd64.   But I suspect even more recent Git will have the same
> problem.

In contrast, I suspect that recent Git for Windows versions have tons of
CR/LF-related fixes... ;-)

> Right after cloning I create a ".git/info/attributes" file containing
> just this one line:
>=20
> * -text
>=20
>=20
> After the clone, here's the sequence of commands leading up to the bad
> "git reset --hard".  These are all fine (well, the "--aborts" whine a
> little, but that's expected):
>=20
> git.exe branch --unset-upstream
> git.exe update-index --refresh
> git.exe rebase --abort
> git.exe cherry-pick --abort
>=20
>=20
> And here's the "git reset --hard" that fails:
>=20
> git.exe reset --hard --quiet d6edcbf924697ab811a867421dab60d954ccad99 --
>=20
> ---
> Exit=3D128
> error: Entry 'basic_branching/file.txt' not uptodate. Cannot merge.
> fatal: Could not reset index file to revision
> 'd6edcbf924697ab811a867421dab60d954ccad99'.
> ---

This smells very much like a problem I vaguely remember has been addressed
recently: Torsten B=C3=B6gershausen was working on issues where files check=
ed
out with one line ending, and then "retroactively" become dirty by
changing the line ending convention (which your -text seems to do) and Git
not really noticing this until the `reset --hard` call that simply cannot
cope with "this kind of dirty".

In essence, I am fairly certain that v2.12.2(2) should *not* display this
behavior.

If my hunch is wrong, please do fill out a full bug report at
https://github.com/git-for-windows/git/issues/new, preferably with a short
and sweet script to reproduce the problem elsewhere.

Thanks,
Johannes
--8323329-2023613480-1493997160=:146734--

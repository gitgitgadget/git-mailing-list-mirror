Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A071D20193
	for <e@80x24.org>; Wed,  2 Nov 2016 20:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756844AbcKBU6r (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 16:58:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:51546 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756229AbcKBU6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 16:58:47 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MRB8F-1cR2Z13ZKZ-00Ucib for <git@vger.kernel.org>; Wed,
 02 Nov 2016 21:58:44 +0100
Date:   Wed, 2 Nov 2016 21:58:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git for Windows 2.10.2
Message-ID: <alpine.DEB.2.20.1611022158140.3108@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-227540317-1478120324=:3108"
X-Provags-ID: V03:K0:1cgRmxHafCRSzy1GyvMyKzn5eMXGJzGTC30o6QsP2r0eB++9Sbg
 HN0/uZ3vd13lronCbUZ1TCzrpIPPSvUcqr/94HJp3vgR6waqrFXi/CWp0Xek36/MRYf5u0b
 3a/0LJpOCkY+23WK8o6KWSEmtrniiFVJL7GtRekRfwXZqQSKordOzgiudaN1Qm7JFEdpcZ0
 WsKTa3G8xYrFkCHrldzzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:80gMmOvLVk4=:nE9W2sYQi5ZvegIREHG19a
 5tklPHHs9EwwiHgEBLvfvMv+fhm6kHiBsYEApWS4TfOHog4cSNBVJ7iG/4y/dY/LBZve/jseZ
 JNJxPpayAZt0TRREM9XbIVE3IrdsuhXeikiB5OdYNYzT2vSEh6vUJutOB9pRWwcW+xIEUcRK0
 0LsuIjlUKrMPXschb53dbiql7Mq0a5q4FMaYRmT5rHKeRh35WWegUwNwB/7+q1m3Fml2YQdHw
 5bI+mB9LuBLg3DUGBTysAytGKHuuLpWUaMXTw02Nl/U20e0+kp9FXjldUJ/4Wdl3eTA524lNi
 pLLaGJAJAgKpa5/4FjwFGwlR1qkZh2N1Gg/Vh/p/YG0POSxQSw5qsq06ZubU2N3VnHDMSUCJk
 LpipSOL39vmkt8xtOCLV+NbTgQ5lFvgHzlFXtUBRFvWD2AZf6n3XR+vF6X7gYcJQ6fUW2bKoX
 jjP+dBKQhhyeTy3fYhx+3TUHwTH7t9jFtYX4Ld5POinHDBIJOMLSlhrxktxmRn9wLgjDIe/pU
 n+0qJLgMhx8OKOdMoKgePCjlnkFe2oxRnBpclCM8DYCkf+Ci5NxNQCG6qCYRfsfTkIjZVPqDR
 V4enATNfnyaeasQZZMk1yRPBI5mnj0IEkWwno8gq3FLJaxTsH5h8xD3ftQAhyomyTLU/PjjBG
 CG4PK6F1A/+w2vKHB9wpGWweM9Ap0Bi1nkBwl0WwQBXsCbcewh8P5XAAFecFxXk0mCIbOlkTB
 XmJGrwLI/0U8Wupcu8sLA7tyqsfxlgP3j1x1o3waip2i4guOs3XfunVvTAQiVLmn/tfpXFQO9
 SrGzAqe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-227540317-1478120324=:3108
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.10.2 is available from=
:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.10.1(2) (October 13th 2016)

Git for windows v2.10.1(2) was a MinGit-only release (i.e. there was no
Git for windows installer for that version).

New Features

  =E2=80=A2 Comes with Git v2.10.2.
  =E2=80=A2 Comes with Git Credential Manager v1.8.1.
  =E2=80=A2 Comes with cURL v7.51.0.
  =E2=80=A2 Git for Windows can now be built easily with Visual C++ 2015.
  =E2=80=A2 The installer now logs post-install errors more verbosely.
  =E2=80=A2 A new option asks the installer to skip installation if Git's f=
iles
    are in use.
  =E2=80=A2 A new option asks the installer to quietly skip downgrading Git=
 for
    Windows, without indicating failure.
  =E2=80=A2 There is now an explicit option for symbolic link support,
    including a link to a more verbose explanation of the issue.

Bug Fixes

  =E2=80=A2 when upgrading Git for Windows, SSH agent processes are now
    auto-terminated.
  =E2=80=A2 When trying to install/upgrade on a Windows version that is no
    longer supported, we now refuse to do so.

Filename | SHA-256
-------- | -------
Git-2.10.2-64-bit.exe | 57238ebf86f8b51e32cab44bb91c8060e04774676b77b9fb92f=
78e7bc7e9a179
Git-2.10.2-32-bit.exe | 8b15054a4ea2dd5d2be0471a430d8ae7c772b94e1a104822108=
3a0040011011c
PortableGit-2.10.2-64-bit.7z.exe | 101314826892480043d5b11989726fc8ee448991=
eb7b0a1c61aca751161bc15b
PortableGit-2.10.2-32-bit.7z.exe | edc616817e96a6f15246bb0dd93c97e53d38d3b2=
a0b7375f26bd0bd082c41a73
MinGit-2.10.2-64-bit.zip | a10de5d5a8e71e207eff20d833ca56902a0668940e3def5f=
21d089e4f533ea40
MinGit-2.10.2-32-bit.zip | 2b191598bcb37565a2b80729ef8d00c03df02b75f6b9d012=
080c458999f89cc0
Git-2.10.2-64-bit.tar.bz2 | 7df449ac1813876b5a2e9215d94bca9458c2e0870c65e5b=
78bd7fc2a448a2a90
Git-2.10.2-32-bit.tar.bz2 | 3f8d0bebc53fabad863b8fe352a317fde61833efa4750f9=
6656cf95017a621e8

Ciao,
Johannes

--=20
You received this message because you are subscribed to the Google Groups "=
git-for-windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to git-for-windows+unsubscribe@googlegroups.com.
To post to this group, send email to git-for-windows@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
git-for-windows/20161102204358.6856-1-johannes.schindelin%40gmx.de.
For more options, visit https://groups.google.com/d/optout.
--8323329-227540317-1478120324=:3108--

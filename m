Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3D320986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbcJDRKn (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:10:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:65010 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752452AbcJDRKm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:10:42 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MA9Yv-1bkZUN1vsv-00BLfY; Tue, 04 Oct 2016 19:10:38
 +0200
Date:   Tue, 4 Oct 2016 19:10:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: [ANNOUNCE] Git for Windows 2.10.1
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-926233871-1475601038=:35196"
Message-ID: <0MQRWm-1bUHYY2H52-00ThV3@mail.gmx.com>
X-Provags-ID: V03:K0:qfedBxV1pOh/1eZxpiDp6bjJ8e62QFgpdCfaixcLaYsa1bqNsB3
 hPuQ99drgRN7BQhjXZzNBqZBW/qMTeDkls0HmU+coO6w/OmDgrrfsiL2ru+bcd5yTUFNQML
 BDmzSC2ChWsLhbGC2EfnyyampukKP98V1sFqHPOWug9Sr+I4JYnGZ2xDGihZW4xn/Wt1apD
 kK799N+PG4/yxpMEQdZow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T0yrCvl/rq8=:HtXInjNmHgi6/gw+F9IDSN
 AQhnJMXoxZZ+tJQFigr69hCg1i3ws/ffDeTT0dGUZFGOZpohg4oTFantAY/PRD+jb+yOGQpDJ
 SPkr0XXfnOApTAmWbD7WRN5EzlGzWmz0qSZ2YiF8BsFuvxxQ8f8GjgtgMJQ7Nh/VV+wV9zouk
 Z1BP4L2vwdnsyo4tuL8+8hVb+4rAecfo8DEIM3UiduEsdm9qVBfXf2PW2sr/wx6AMTVHpUKnD
 DoDgc8qLj3D7GDsBjg0p9+IC+8iJD8g43AeZk24+Wk7mW6D/5NYlzFk0/kfRpk1+XBysQ71I2
 MOMqWWDJQf3YkeVKboQ2X7JdcZoanbFsbh0Jo+Uix6kkt2XES3iAx0Vf/4cXnbp224E5UOdfC
 DiME8Woz3uWGypjRGb2JSVhRdNdexwZJTBev40UrS6uNnkbA1cHuBsOhMq0Hk/cmOY+qD457u
 T4S6wF6qCs+XRDauoQXx4ygsOfzfEwSfM1eK7rN/iqy9PWujsOat9BdmOmI1ZBVMwqtSrjao3
 Nqp2WqZTu0FKPCGrgehtP04C7kBvN/HPO6WfRwUvxwA1pNsvpwSk8+R85SSeB2sfjJzNuXOE0
 DvWk8MldkL+a/YYFTatQ1+ZGIYjXd03CZYP+Qy5oyFaZAZ1Q3/RGpajxVsSpO8DY/6G+d3eEJ
 975wSvlPk4muM1jr3eNai79CvywehekNJ9685gKvqJdzPYmvfBvi4dj9RmDiqxW+vnnNtTdJx
 sCBIUNs9myg1Zr2N3Rl8qPZuC2yVvlIWJN/HorczTABnAiu/+vpU+SW8hatxeLiRgjOBbO9mM
 +7B4Cle
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-926233871-1475601038=:35196
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.10.1 is available from=
:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.10.0 (September 3rd 2016)

New Features

  =E2=80=A2 Comes with Git v2.10.1.
  =E2=80=A2 Comes with Git Credential Manager v1.7.0.
  =E2=80=A2 Comes with Git Flow v1.10.0.
  =E2=80=A2 We now produce nice diffs for .docm and .dotm files, just as we=
 did
    for .docx files already.

Bug Fixes

  =E2=80=A2 The icon in the Explorer integration ("Git Bash Here"), which w=
as
    lost by mistake in v2.10.0, is back.
  =E2=80=A2 Fixed a crash when calling git diff -G<regex> on new-born files
    without configured user diff drivers.
  =E2=80=A2 Interactive GPG signing of commits and tags was fixed.
  =E2=80=A2 Calling Git with --date=3Dformat:<invalid-format> no longer res=
ults
    in an out-of-memory but reports the problem and aborts instead.
  =E2=80=A2 Git Bash now opens properly even for Azure AD accounts.
  =E2=80=A2 Git GUI respects the commit.gpgsign setting again.
  =E2=80=A2 Upgrades the bundled OpenSSL to v1.0.2j.

Filename | SHA-256
-------- | -------
Git-2.10.1-64-bit.exe | 0fcb5a3d5795d5bfa1c0d35d1cada37f25b5e62c776a7099f27=
cfebc31362d95
Git-2.10.1-32-bit.exe | 66e0748cb0eb0b63506f38fb8bf1abb5c361ce647af86cb0f75=
4bc5b6a17775b
PortableGit-2.10.1-64-bit.7z.exe | aa0634e026c70fe8b50207b8b125a18f45e259ea=
c32cea246e068577a6546718
PortableGit-2.10.1-32-bit.7z.exe | 3ca6f426e3b2e6675a11b680f719c23affa7e4dc=
060e315375c6a262ed2658a5
MinGit-2.10.1-64-bit.zip | a7268f4ab447e62940347d52fe01321403cfa3e9e94b8e5c=
ac4d6ded28962d64
MinGit-2.10.1-32-bit.zip | bcdeb7c00771f0e8e96689f704d158e8dcf67fdb4178f1ea=
3f388e877398a2c7
Git-2.10.1-64-bit.tar.bz2 | c0a541a60be3ea6264a269b90689b15da3e27811218e8c2=
14359ec44593faa8e
Git-2.10.1-32-bit.tar.bz2 | 3c77a702911512708126e83673c5906af78807bcb9daad5=
223b0ab04ea81f4ea

Ciao,
Johannes
--8323329-926233871-1475601038=:35196--

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.7.3
Date: Tue, 15 Mar 2016 21:17:50 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603152117350.4690@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-895668171-1458073071=:4690"
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 21:18:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afvPk-0006c7-B6
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 21:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697AbcCOURz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 16:17:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:55326 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481AbcCOURy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 16:17:54 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LzGV3-1Zl3Mc1GmP-014Vmh; Tue, 15 Mar 2016 21:17:51
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:9ss7CEpAPgPOYYhsvkHj6KQ1SkLjfMKI2DffZdyfJ+PxIbCDPmO
 TmlIe5Simis4CBhaD2BZBLkk5UZSVlkN7L01u4vrgatzLyRUvyFqj9d9fw3vkAxSmWMfv0d
 YVWd3U+rs6dc3xY5k0rP8wjm5kOFfVY4BRA2CVnwgnEan3dv6JZ2SGkEEJabh5vcMHp6Gf1
 z9zysqigmtlHB0fdO0wjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7NMusskemaI=:UVRHwoz6DCXxByYZ1VHFYI
 g+aLkDrIxct1l4IWq8i7EH4/8s3iISBWHwS0pzSsWfbx3XActJc3nld9Q4o2nWHMctW8EFvVZ
 UpLCdNaJKRIB0wML8e/5C9EP2A+LUBI75ybce2boqUAtWnaVELm+mEGkYUe9+TStXA0q/xO5m
 OiCBioZTMQH/yU2py4/qqDzdJPqq7Z0JEtErC6fO7EJ/LZCSqm2ciPluMhBNbCKZJ4BfVxVoy
 wFAj5I1Xy9vicdRu44FLxQEgPqp1uhJ0ilaryEXeCCF6p/vmkfMTYqS1dkZSRM53HeRACx1kd
 eBulxnHYrOa4FHDausK+fYb0trZNdOUVJwJJrcACN9YHvtcnh5GCegAu7MN+OjvTcD0VHuBuW
 vpXTc4npiX9iSTGUC8afg0UMndNxEuxrUwEwqicmikMwXq4X6YAKMN531LeYA1RW+Wpfr0NF1
 Ae0Y3h/lb7WUKI1uDge5y5FyQ4Kx1SWpiTHcdMi8qI8/lct2gGOUHkq7FXIlZqSNQYMlN8Q6l
 FcuZ8VdtF8ZMFWT6n6EV4LMTuqVf0vxwsqypiM/QLEOqwMQkuI7cyCa3baiosjqhep+vHR/4k
 qUjucet7ncV07vLGdYPOzXvbv/ZDqNg4gZJzRbJXr/uFPXv5MM6+7QAxhNoIV3Vb5L7MOPNqJ
 sRXcaGOn2gxsXnFsORkZGT2sd7ntpk0qZjA/p4YnPaMAJFJ81FcfonbPgyVglfMoq31RspBkO
 rGYS6/eRx6DQrED/TsbrZkdsV4lOe+g5X5BtjwqHvqfNnXQ+bn1cfqOGK6rWt35t66d5xl+7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288907>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-895668171-1458073071=:4690
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.7.3 is available from:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.7.2 (February 23rd 2016)

New Features

  =E2=80=A2 Git for Windows now ships with the Git Credential Manager for
    Windows.

Bug Fixes

  =E2=80=A2 We now handle UTF-8 merge and squash messages correctly in Git =
GUI.
  =E2=80=A2 When trying to modify a repository config outside of any Git
    worktree, git config no longer creates a .git/ directory but prints
    an appropriate error message instead.
  =E2=80=A2 A new version of Git for Windows' SDK was released.
  =E2=80=A2 We no longer show asterisks when reading the username for
    credentials.

Filename | SHA-256 -------- | ------- Git-2.7.3-64-bit.exe |
382d30d38b5c88690864bb46be0a9c5f53b7046e7a6485dbcede602c41cae9a2
Git-2.7.3-32-bit.exe |
e38ddcc2c17390ffec0ca4d5c4fb948b5b4874ea0c522d5180cf2ee7e63f76bd
PortableGit-2.7.3-64-bit.7z.exe |
f5b39244869efcfac57c9a9f1d75119de0121bc8aa260d1824dfe5902f9a3f60
PortableGit-2.7.3-32-bit.7z.exe |
82df6b1e8ca8550d7267641e32c6b736f0687e35dc3b772b21914706f13cdea4
Git-2.7.3-64-bit.tar.bz2 |
dd81fe03c83e255382816a5db1427b284288fe21b4f89cbe3b1ff21af8d0ef1c
Git-2.7.3-32-bit.tar.bz2 |
3b845331cf91e2a1677ba959d07491c6b04b8bdfc7900236a201d0f8c9863197

--8323329-895668171-1458073071=:4690--

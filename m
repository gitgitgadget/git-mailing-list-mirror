From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.7.1(2)
Date: Fri, 12 Feb 2016 15:10:03 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602121509420.2964@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-75981132-1455286235=:2964"
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 15:10:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUEQk-00038Q-RU
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 15:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbcBLOKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 09:10:38 -0500
Received: from mout.gmx.net ([212.227.15.18]:53414 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbcBLOKh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 09:10:37 -0500
Received: from virtualbox ([37.24.143.97]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0McmFl-1alUAE1Vz7-00Hxal; Fri, 12 Feb 2016 15:10:35
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:c/oppeKV2uOmtdTvU+x4vTUSCliA+uJOOSJ/lLRVnhHQtL8ethf
 dvhtH765W9uTJ+U+Ivmzi08gItTPSnyzX5i44lSCZMlzSVGhlMrlUswC2jIHLJM1EIyhQfW
 d44oKphqSXoLWN9fbMMxl3Z41EyOC+EgN2EfWovrbSSFWxC1UBcWjNa4JccmBTEiDdT6rvZ
 32kVjQvuwzq0NggB7sFGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lkC+OnGQnHg=:kPPVIfYT7YHN97qmeSXGvk
 l1jbI/EMo9qP7O8sATHuJAaLeaT0AjV4zX94RMVQHS4RjYxNLlpTKNaXeH/89ykr1Dwbp/j8k
 Imcc3Ru00FC0BBj3W81g5teRmNinOQHACXX8htedo/FPvXTefmdzY/LQFQtU456UXBg1o4yj0
 uiDWrsmQMPqO4ISyZsipELlqV+5pOQf6SdYmLmiiJ+OfMVo5MBh3CjypDViJLRx5qX9bb6rjl
 SdhukU6I/RH0LyG//yRoxHH52c+vVHO+nZmOIq/WSBlXeDetPEl+X/+IB+X4Dy+sbo5b8qqfo
 5NLyY3tVa0n4w9wUr4PKfhcQTxskSKOY7fvJ+CJIzhAKhOeswnsQNh5gcW8hEwFRB4koUNrnQ
 Y/vwq3GyevmmmLfcUPyJ22Q04W5VHmJD7CRflszvWEVx5CDt1uW8Jkiox7jz5Ya/cJIVBUGd2
 DP7oWie8VCswltCHRcrUAn/XiM0OcPFV0+UkTyIB7mZFc3BaMpVB38glwz66qkggpnOV6/Kvl
 FhLrAx9yaoQZhxG3CzWK5RjNkCwpR6BK6qklBwEv25oRipAvkt3ILiWRG2RvyqA6CMoxGWUOt
 UlpMDlTjULvGE4I5AotnMOtVD40Azhk8to+iTVIm+di1lVYc3t5lpwbeGvdxswiQsgmB2WQYo
 /Ct40J+S6BUTmWl63xkgDfGzRF5AsMVQjHpRMugTssSZrVKXiWfb30yKiaq+lz5HukSLMY7Vo
 5inFEiJACRa5wukEREvFi6uXJMQoSdse7a6X6b9fixD4MdCPtk6B574hyFFsVhOPiiIbnAOi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286049>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-75981132-1455286235=:2964
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.7.1(2) is available fr=
om:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.7.1 (February 6th 2016)

New Features

  =E2=80=A2 The context menu items in the explorer now show icons.

Bug Fixes

  =E2=80=A2 A bug was fixed where worktrees would forget their location e.g=
=2E
    after an interactive rebase.
  =E2=80=A2 Thanks to Eric Lawrence and Martijn Laan, our installer sports =
a
    better way to look for system files now.

Filename | SHA-256
-------- | -------
Git-2.7.1.2-64-bit.exe | 956417448441e267a0ca601f47a2cd346e2d09589673060ae2=
5d66628b2abc82
Git-2.7.1.2-32-bit.exe | be10e98b8c53f92648f8d1c85c7bad4c433aeedcb9d4719588=
b75030983cd76d
PortableGit-2.7.1.2-64-bit.7z.exe | 92310dec60b0210acbfb31a0165f2628757b841=
3efcbcea1cfc95b2984a974dd
PortableGit-2.7.1.2-32-bit.7z.exe | 7bf8da2b46f40c98d18a5f9c36e5b90df258936=
f43a0d230d0f29e0d729e3283
Git-2.7.1.2-64-bit.tar.bz2 | b3170fc127889f8fa603bc8546c61528869a0a6d2c19bc=
03de9d96dca2443881
Git-2.7.1.2-32-bit.tar.bz2 | 4c897917682685194ed9d71fdfafbed721488fe22ecd8f=
11bfefffe3fec9169a

Ciao,
Johannes
--8323329-75981132-1455286235=:2964--

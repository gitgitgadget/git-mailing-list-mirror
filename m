From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.8.4
Date: Tue, 7 Jun 2016 11:37:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606071136330.28610@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1737779600-1465292250=:28610"
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 11:37:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bADS8-0003xe-OE
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 11:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbcFGJhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 05:37:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:64949 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbcFGJhd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 05:37:33 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Mgc0l-1amtGn0yE3-00O2tN; Tue, 07 Jun 2016 11:37:30
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:la0r9i2eHlryzbY+s6B5RUvxP0MG+KmIUYS2NHJyrKxDiTRkl9U
 wtQRtFiHql4HcJRT9Z8Fum6lIttabJAEPoZ+rESFqm/FsuhKWfPkjtdJQc7lUdWFepBpsqD
 ZM4lMxieZeFOymgdS6bBVYJKM+Ulp64lNXivxjGVybKPHN6ygzQlpba+231DuJqrEVwTQzm
 jyaiNmOAoaxTJ1dgAX6Ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nDUHXZvViD8=:eJdRq0pfgTcJDBH6Fg5f/C
 EZ5Sw9gHEf4HGVEE7VJsxbW4QoxkbxpLr5wIqXM5utsxV2FrdGhwYfU8Nj8MUWtL1BCVR4hjE
 HPf0++53eakZhIpbyAr7EmLitjndL09o2iciCKhCX5iDuawqnzxePmIvEMfc//8vS2bTsDC+X
 AJmLI2AUcD5wBaV5PyuLdP59VTf8H02VmNtgsmOkuBCkmaXi1qNX3h/XrMjkWZfsAPDqZcw7W
 m+VP3Y/froW0DakvFa2erJQm3SFIWWB7m2be7gxdIMwCkzsuhr/sV4FP451G+Ktj1pTa1WvTH
 t4H9aJb+hhgQXzNtoGJZEF3PtsQlb/z/kBNMAiGutUFvxHrVPTKOslKYf0Xm3ipsQlluemR0k
 p6cPiZyEWQFUpiasMlFlc7s+v75ZPL2fI8HUE3nSjtpgPVh0c0WQbdSFL0yyoxZDltpUW1a+i
 zIq5z9lgtSEqDvNTSqGEHhW2BoTevNFEtT384l0EmFbkuZn1m9lKsjIdz5I+Mq1xhq8LeGplD
 VGOyEzZiowaXzY6Sc7ORHFPJl4K4Bwkt+1tjYXMs3oBaQQ4jCBzTtX7AQvz+FjQwbOIL9C6UE
 9NE0YDE+ArlUg9Za9keZUfWpu4OyJ9CAQhzHinn4zJYysMxGir7PpZ/V1Gq9uPcmqZXVR5O4s
 TSlhqyidwukbi1gY45d4Zi11qnLF/EgtNAqccaSkAQsLMIKYEkgxQmraaXRjw+g8XtAbZzjym
 t5Z6C6Z1nCKdJRayXfYYYez23ebT6dQjP5zIrdAkONsmD/BqvOZoZ2zOeP8u9X+Ie8n9sI1m 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296622>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1737779600-1465292250=:28610
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.8.4 is available from:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.8.3 (May 20th 2016)

New Features

  =E2=80=A2 Comes with Git 2.8.4.

Bug Fixes

  =E2=80=A2 Child processes no longer inherit handles to temporary files, w=
hich
    previously could prevent index.lock from being deleted.
  =E2=80=A2 When configuring Git Bash with Windows' default console, it no
    longer loses its icon.

Filename | SHA-256
-------- | -------
Git-2.8.4-64-bit.exe | 1c4f50e11a8138944c21aaf5837606778cf1835c2bcce6936b40=
ce48c9fbdb49
Git-2.8.4-32-bit.exe | 502dadd830560088dfd7f8f9582d028dffa10cfd20b4616f0592=
a8098f8f5a7a
PortableGit-2.8.4-64-bit.7z.exe | 69018cf6c8af2b24cdfb64d469e0515d5c81471e8=
4845d6012677ea3272bd4c0
PortableGit-2.8.4-32-bit.7z.exe | 488dab9c25465df6c9452654623f5057340216708=
2703f7af270d2d173eecce0
Git-2.8.4-64-bit.tar.bz2 | 41ae6d6bcf906c8bf98092ae8577212d21d20b8d4f7784f2=
690ed132116aec63
Git-2.8.4-32-bit.tar.bz2 | 2cffb6f899377c9241322e215f5e32963992f1a3cb607e80=
3a6427a02b2f0a94

Ciao,
Johannes
--8323329-1737779600-1465292250=:28610--

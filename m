From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.7.1
Date: Sat, 6 Feb 2016 18:20:55 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602061820490.2964@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1316821613-1454779257=:2964"
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 18:21:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS6Xj-0004es-0B
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 18:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbcBFRVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 12:21:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:60585 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbcBFRVA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 12:21:00 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MZkic-1akJc70B4g-00LY32; Sat, 06 Feb 2016 18:20:57
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:W2u/fL2yjzqRP5z2gW0ku862dcR86UzBuy06gR3GFAzpDC/4iRK
 Wgx2hyLd7Riietcd0buI0fE+xhTPQABX68I5V5AqEUJ3/kUfsZtesFaZtO5InFuAsjimaQ2
 iXHc1fOEAVw2U9+TFyB+8Y+QNHYKoRAwEoeUnjimu6XiT/Sqx0H5JQ6iIp9810y1RmOe5u3
 IMEYNBooDTLMlpgHITPdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lMcHCWAvw2I=:KCStRd/VYTXtceDMUsI0tL
 /OPG1PFtLFWXBMphS+jndfU+29pxyQkVGd+MDMuPVqZaKgHZp9+SK5efrjB33pLvg2O7DmGS9
 LX1l0FuY3uMEx/39dMISi9i6aGK0SMHU9Z2NBcPFbJvSW8amSEQvaGt1hR1W//mc57tM2oeQ0
 r1HtY4+WYQNJR/sO7PbWcR+D12SbmnL6R19hz4dO5Ib6T0pl9u++ZUgXgNuoBK6bwKNeQL/zk
 QXhpmOVndg7PelMEOq6abrxtBb+LzvekQij97PcYSgMY2xSQz7vv/u5MEARw9BXKRMIkdyQdn
 GuuOpzZvSy19N9Ua2M917ebRWjCf6mpsXv6qE67q39MdSlNSKEZs7vrjAwiaue4JN0VG/jmoC
 a411P+p1HQPiH+UEc0yVLqQJU+oOCua4TVLYCSF9qA/vp1E7ix2G6PuZctWZiSnOb99dRiUIv
 Ku8Ev3SzHgOPtG5bh9yzUliKDClJViBHvNRN6LUSVODJzXL0O4pdwTsAhxBe/X1OqTR03MArO
 fYFXikBhJ2edrgnosj0KaZLa31d77rFY2Pv2awSHR+pwOG8VkPrTK75ZD4PmwaZBcygXyMagd
 MWfyV6ZuwulwhffiyGreBjj0AIiE0XtHD8tmWfTd912uRaYWFePFc+hSTvNgc8IEXOnj0m5v2
 tjdG+1fCgU3IkH32dYDN4XskmaRB/6cQtMFZGNVGGyG6WkOw5JY4QTIz6x9bknGjn5rpb4IR3
 cYbVY4lgaQx6RjZJAmD076E0DapBOhL6lyHMMQRrHD99KKQk+sfO2bxJ/yrTZN+hMBngs2Fz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285699>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1316821613-1454779257=:2964
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.7.1 is available from:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.7.0(2) (February 2nd 2016)

New Features

  =E2=80=A2 Comes with Git 2.7.1.

Bug Fixes

  =E2=80=A2 Git GUI now starts properly even when the working directory
    contains non-ASCII characters.
  =E2=80=A2 We forgot to enable Address Space Layout Randomization and Data
    Execution Prevention on our Git wrapper, and this is now fixed.
  =E2=80=A2 A bug in one of the DLLs used by Git for Windows was fixed that
    prevented Git from working properly in 64-bit setups where the
    FLG_LDR_TOP_DOWN global flag is set.

Filename | SHA-256
-------- | -------
Git-2.7.1-64-bit.exe | ab3eee9558f5bedffbe5518edcd84dbade813a013470d7640285=
a9c9c263be5a
Git-2.7.1-32-bit.exe | 687e58df471bf88996a3ba619d25ccaaecd7243cbdb291f028ab=
ce68e8620569
PortableGit-2.7.1-64-bit.7z.exe | 93b56b61973dce5b56127796b714cd29bd4777cce=
54e09e497dc1d0b2bb6057e
PortableGit-2.7.1-32-bit.7z.exe | f65ac7104a5b5c9d9bfa5b86df90acfe140ef5415=
ee8126daab050a157264cc7
Git-2.7.1-64-bit.tar.bz2 | 2ab050864eaf60b158868a5a96ec5a2f2072a446a04dae9d=
290c4377871bb75f
Git-2.7.1-32-bit.tar.bz2 | a7b5d4d94b89e5eac5603c45ebbc28cb377f5835f6b3416f=
255972c77bd5226b

Ciao,
Johannes
--8323329-1316821613-1454779257=:2964--

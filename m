From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.8.2
Date: Tue, 3 May 2016 20:29:20 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605032028450.9313@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-527511090-1462300161=:9313"
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 20:29:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axf4c-0008QN-Fo
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 20:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933873AbcECS30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 14:29:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:61826 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932756AbcECS3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 14:29:25 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lh7M3-1bUE102qWt-00oV4s; Tue, 03 May 2016 20:29:21
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:CodODmdEj720b9TOpqDkY53TECKusck8djAPIJ+i4Rj24aXiDzo
 inuyQQKHrmy9LfFocJIQi+TJNLSvFFj5xtnQrNWiZzlbu/zus6KXLixTPffZmVPYzraHXq1
 iOf/eDWaQ0NzDZm614LJgiD2WQ1fNHAPKPijlJabw1zZQkJudu1l9X4R7WVYoya1PWBedyY
 jczTN0tLxfEhgbMxfCwFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RMpgrTdHPu4=:GHPBL3scBuT8zWVFoQadyt
 xssVV1TEB9vpKPodL+blRyZp6iTcNc6RCRUvHQYRobRS7JtYzmRK6mOx5FOLs2uG4CTdI2NPd
 87yDtA4JjXDRoVE7phV7WftuNLQGrdQjCzbfQEd1zm0CvOLjem5Pl8n4vXXG0uXsaVFheaemR
 sQ2rGhRVr/Mym6U5toOnMN4MtBRRgfouWBA6Lr/SAS+rRZ5sXH8AMfTRotL+DdATxUvXLE8+q
 M12vsPIltfDLVUY+FkAxx/yH9eCguQ2g1FZVtDEFJfnJ1Jq6THss+n2lmzf0hBpeWPtgXrqwh
 FnMQGZsRE3xdCT337P1B46o3MAsWACr/AK2k181SK3pZD6Q0ElORf+mTAHa87Mt4HKaViN7Mc
 eAOylyZEwvzt2s/h5VEIfVi2P/5+X9xA9uR7KNbcK1gOKvfRqhg61j2oE1qhOkMEq0ZFZd4b5
 nyrCvSualDKWJ48BaSefUWJxBN6FCCwEd+LZAgkg9LqJNV9XjivILIHNzMoEBwvXHWUNib0VJ
 19SjELxR5hWm0QvGwL4GdFxOVLY6JRT2z+vFj7xwL8vif466xo8Cgn9Wds4yGRiLn7tSVf1tw
 holemBGm7EBWj5/1x7p0M6NCo3h25w1ETB6QuIZQayd++egtFAqNSjav69uaRpQIJdRsvEb/I
 U5Ez0plFdxrUprt5UW3IfisXOLNVtRr8dmy8W8XW+kUwjUk52D4BMJvgetqNnQBfge/RGxLkQ
 paAgMnwsABeHzcus9jkezjXCgOz4mQ9ZJDLRG0k/l6JZGH9fB99CwjLiby4rOgbMWs7oULLc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293430>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-527511090-1462300161=:9313
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.8.2 is available from:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.8.1 (April 4th 2016)

New Features

  =E2=80=A2 Comes with Git v2.8.2.
  =E2=80=A2 Starting with version 2.8.2, Git for Windows is also published =
as a
    NuGet package.
  =E2=80=A2 Comes with Git Credential Manager v1.3.0.

Bug Fixes

  =E2=80=A2 FSCache is now enabled by default even when upgrading from prev=
ious
    Git for Windows versions.
  =E2=80=A2 We now add git.exe to the PATH by default even when upgrading f=
rom
    previous Git for Windows versions.
  =E2=80=A2 Git GUI now sets author information correctly when amending.
  =E2=80=A2 OpenSSL received a critical update to version 1.0.2h.

Filename | SHA-256
-------- | -------
Git-2.8.2-64-bit.exe | c2ce14a52dfd6d5c1bbfcc291f219962cc93c2945a1a8faa6e3d=
0ccd63bdbc1d
Git-2.8.2-32-bit.exe | 512ad6c406d448610a5745dab94dad2a34d964d33f79dbd2c480=
247462ea328a
PortableGit-2.8.2-64-bit.7z.exe | 553acbf46bacc67c73b954689ad3d9ac294bf9cbe=
249a5b78159a1f92f37105b
PortableGit-2.8.2-32-bit.7z.exe | da25bc12efa864cda53dc6485c84dd8b0d41883dd=
360db505c026c284ef58d8e
Git-2.8.2-64-bit.tar.bz2 | 7bc4202a419c6405db8587eccf04a120fab25ebb95cc3cb6=
a2312fd1ae3e2576
Git-2.8.2-32-bit.tar.bz2 | 458321df021f3a26f2a92e21cb21c9cb3173c7733af349fa=
2c099261099d69b2

Ciao,
Johannes
--8323329-527511090-1462300161=:9313--

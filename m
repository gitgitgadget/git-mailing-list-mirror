From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.8.1
Date: Mon, 4 Apr 2016 10:27:55 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604041027520.3371@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-268140394-1459758475=:3371"
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 10:28:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amzrg-0000Vt-Et
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 10:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbcDDI17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 04:27:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:57484 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbcDDI16 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 04:27:58 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LaGJa-1bXqwX2i4M-00m3Bk; Mon, 04 Apr 2016 10:27:55
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:BIELoBsxQ9BeJ2BuIZu/rt0JhyveQTAW+Xs5mVFXVjf+a/WVulZ
 oXQDGYwxrQTQudslTBQV9ujKLjrti/O27N4bRJgK5Vmz1NXrB1Nfj4bi2NViL5DrMRK6JrJ
 yi+jTc6mok+XrXAHjfmPffn5x1/8sG3u8BcS1k/1sSBaSdBTSBY0XCFPYEvCLBNXGJqGFnu
 71jiI74nxi2TEDlUfkXPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UULVpaY2lq4=:efVx0/wQPJCdiwS0BpD+nW
 xbUL7fhWycDkMApE5Uc1ykK9gDhZ7a/UiVxG2qXIhWk4rg0buDqfn7NW6NA93ohw2jnDElAyj
 fnl056P/+bY//TCPiWYo3TbnstDzt5YbmaowkZSmdsKxW3yAsHyppNEA/aWAvfVmN+Fl2eJCX
 /ht/5puFzoJRCARqzlPQeQcS8CIQYu3DcTu3rTyO3q8qMghEKgKSwXAuhn0u5gvyAEUBXTjOy
 iPefHFdK3zLDcr5SsxqvrDSJkQ0Bn0vUEEfcqKw5AYuMnxakDIRoLkvTD/TlCM2VDjcZy1WNU
 tBriBffcz5j9N0wLjzsxHuNwupNIxEkwLHErDBvl/XSH9MGRS0W0ZthZ5JEpud7v42lomih27
 8EsJmkzugeir4UUOQtKB08iLLYc2FtY1JXKR+boDCcwA8KK5McOfpDvSw17XymBq4fZMvTAFK
 Gyli4GEWZGwqqgj9SzzW1+DcCkyZIn+BwnYKrnQVuGwdFmK4FiHvpLf2LXg36566iNlp8fBGD
 kHG7Ez/ytIUQWB95DE0Hd2qLL1QHyD3rfgCZEp8uF/8Zlr8h8aK9hPGtkgicWesccQDqED4MV
 BTgdjVNWvLAZFXowvDwVOLqScL938TkgwEhDr1T41XLRKdMReN8/E9GX7kfw0yK2Y5UP7lBf3
 V696DOIClSMCwzto4De4ajs7Pm4CPAFe6+IiBW+xnJRvcOaulF7GwajBpa1f7q7TRyPMKtcx/
 ufA2N1fqTsmBAVML9e59jlO6y5so2TM0ua1slp0O/Hhgnk8G+NcmQMs4hmps4vl/Wyq4JsPP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290684>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-268140394-1459758475=:3371
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.8.1 is available from:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.8.0 (March 29th 2016)

New Features

  =E2=80=A2 Comes with Git v2.8.1.
  =E2=80=A2 The Git for Windows project updated its contributor guidelines =
to
    the Contributor Covenant 1.4.

Bug Fixes

  =E2=80=A2 Git's default editor (vim) is no longer freezing in CMD windows=
=2E
  =E2=80=A2 GIT_SSH (and other executable paths that Git wants to spawn) ca=
n
    now contain spaces.

Filename | SHA-256
-------- | -------
Git-2.8.1-64-bit.exe | 5e5283990cc91d1e9bd0858f8411e7d0afb70ce26e23680252fb=
4869288c7cfb
Git-2.8.1-32-bit.exe | 17418c2e507243b9c98db161e9e5e8041d958b93ce6078530569=
b8edaec6b8a4
PortableGit-2.8.1-64-bit.7z.exe | dc9d971156cf3b6853bc0c1ad0ca76f1d2c24478c=
ca80036919f12fe46acd64e
PortableGit-2.8.1-32-bit.7z.exe | 0b6efaaeb4b127edb3a534261b2c9175bd86ee868=
3dff6e12ccb194e6abb990e
Git-2.8.1-64-bit.tar.bz2 | 3ebc00b96607174fffb35cf6d96b3b3246aefa504a4bd303=
75182fea6ab64bde
Git-2.8.1-32-bit.tar.bz2 | 9e754d83190ba154f012d8eaa7433d29517f7c85fff229d4=
fb62e6418acf8d41

Ciao,
Johannes
--8323329-268140394-1459758475=:3371--

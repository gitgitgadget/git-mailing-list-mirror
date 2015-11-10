From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Announcing Git for Windows 2.6.3
Date: Tue, 10 Nov 2015 21:13:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511102106360.1686@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-1791740501-1447186395=:1686"
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 21:13:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwFIB-0005Zi-2S
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 21:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbbKJUNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 15:13:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:53272 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbbKJUNS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 15:13:18 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0Llmcq-1aVa2d1suW-00ZL8t;
 Tue, 10 Nov 2015 21:13:15 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:BTytewWsSIEV2XuFuhFrDhScgA60vukn/AC9SUAnURb/EZ5/8KT
 KeK8M/zLjEX0MS/iYeWXo1n76wAwmMFHobi/t50Anp4SMNE4bpgHGXRQa74RTfgFAGHG1n4
 mT18XZ4Cc+FKUPOZNiNCCWeIeRxR6KxP+z+x+BEcvLMycs1ANRQL2S4CsDl3NkcGF0Pf0pl
 e2U68Rvw38Aqzykt+4V1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fakriSXjXS4=:kiVUkcQv0p5i9LM/6wSIkW
 XiCUBoBGOiWd5N23czJVojlHA230ec1SI+R36nHdeS4JSJIL6Eu228jnmT3pBXO7JD08/rja+
 WWCzXXJuOG81eNjqwrJlaFMBzqYpAkP1E9DKom9olA44mMOmapSKNoDXjFY8VGWFIOVboZhYg
 QpCmBKV527/DFICyxYWKbCKKXWbXee50UdyFGEtdfm2SxSboPLmOZ+3v90mFRmiCuI12PIo8k
 SJLc7mEOt2W6WifG/q3IMYYgowq1X66FAfLb95wX8jNmRGIFFNWElZS7ODyFmPO2NwVaGfwG4
 vpkWDf39ilu6bQZmDVYRPMbOZa4u3rdQu/UxSWT/pmsXSvJXu7Y7JlHiKnfqVB3FviiEiw0I2
 /OMpvl3zDnYMbNSK4wwKqmGs5Dkp4O5kfzboeiZ1Me8xfQ+jzWa2rxGEBeruSqK1LBTUrUfO4
 amKn+jdOgDC/tWfeOwf7JQdRBTouNajA4YgikPql8bnTbstS6WIfhKT4LV2hXtlb27dXj6bsh
 94j8X18lMzhXd+V+FDVdKlaIggguU+mBjHDGnIrgreZVwDPWK8n4YCnRyV6qUv1gmg36ry7Y9
 deKiSDKbUS+2a4Am9AerHBbaP05iMzLP+Gn7VX0koEcbW6wXqv03vTvHZ5ZtYNfm3RlC6lCAW
 ao3zi/J2Cq9qlihsQWU2ax7dLUK083doGhzZgH9wxFIHIcxDdMmsSqoNsMDQnFYsszaT0LBbD
 7TYuEJzON4FuLdyPu0b/nWUPbimkTrDxbvNP5TR2AFHSv1H3X6AHC5f6JhBh3FcpA4zvnbJl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281130>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-1791740501-1447186395=:1686
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

it is my pleasure to announce that Git for Windows 2.6.3 is available from
https://git-for-windows.github.io/

Changes since Git for Windows v2.6.2 (October 19th 2015)

New Features

  =E2=80=A2 Comes with Git v2.6.3.
  =E2=80=A2 Enables the stack smasher to protect against buffer overflows.

Bug Fixes

  =E2=80=A2 Git Bash works now even when choosing Windows' default console =
and
    installing into a short path (e.g. C:\Git).
  =E2=80=A2 Notepad can now really be used to edit commit messages.
  =E2=80=A2 Git's garbage collector now handles stale refs/remotes/origin/H=
EAD
    gracefully.
  =E2=80=A2 The regression in Git for Windows 2.6.2 that it required admini=
strator
    privileges to be installed is now fixed.
  =E2=80=A2 When notepad is configured as default editor, we no longer do a=
nything
    specially unless editing files inside .git/.

Ciao,
Johannes
--1784107012-1791740501-1447186395=:1686--

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Announcing Git for Windows 2.6.2
Date: Mon, 19 Oct 2015 23:08:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1510192306541.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-455497025-1445288899=:31610"
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 23:08:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoHfP-00010r-Al
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 23:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbbJSVIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 17:08:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:57681 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbbJSVIW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 17:08:22 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MfzEP-1a8pC22T81-00NRsd;
 Mon, 19 Oct 2015 23:08:19 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:HG8JbZ+6ItaBwM0ZLxMVDmFilXCYdRkx2OLaWS6DqAlpqQHfxMq
 ++H4Zhg6yK2peByHEIHaDBRYwtIEViMkE6NgRBg9IT4k1LnoaCctaz8+IFGE70W5KUGt1js
 LRz7TD7Wq5JOSXaWG//R7K2jMi0egoxIjgKYFAXnz07+WWVpvyLGvXrESK2q9XC3vRQRslX
 +HczjCE6rOVcKGo9oOm3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S/ytCEjn34g=:tiMQPeIXN7ZU2ebJJd/27x
 v/bHRQ2fGu+tF61dfUaKOiCNG3X5ME+QyONb57drnqiXNa7pZGAYzb2dD/xJ8J6qvbpi2Avgq
 iDwXIOKKvYtT3dN3ptKgbg/OC9mCYyvV8+CDTIJnT98nbFeMaJyOHMOmj2uQj6Lwf6CHxwL0e
 eI7dUVS3+T7kFyeRSlK8JWmLNfHDNz+Ck0wNn7RPJv83OtKMZE6dRhHThLQTlPjXse0SQwT1f
 tAq/udk8jdhZ/fY3THIf2Sit9Jg8j8Rp6o4n4L7R1HUgclhEsuZX+vRthnT8GSVwf5Rm45eQ5
 DWUAsjpifeNZ8uHoAd++dSavB30e10Cv3fgStGdDcfClBoduTTBApP+R/TIANx8ur72HuhPFu
 vYS48TzdGJUXEjw7wsh5R/756gDEbG8rPW0QGOL1vt1+ZYkU13QnXDGhxQ56bGyFt0Ofz/IVf
 41c9jfHYvGtdzRBOMgjrHvSPhNVA0+KpV+1M4tH7z6Un+6WE6CoJwod4HsQONju3ZmgkDMfKT
 KbDyvuFJf7xy98upurt7kwFqeTMi1bjNVUWvZANl5dY8Jif8TEjz+aFeRh5NiorbILfVKdGBb
 LOFLNvdJlYwyK86EUcD32POEp2Ve+OO0IjWPigvH071Fqx1wjhpBXv8YVOfgSsaAh+M6h+j29
 jvwBCyYTMYl552MVZo/zFk/JUEfZ0KVLJuwV9blDpzs368xHlEfoKGRcZh0MnVtUEXGzar81I
 +Rou9x3ZBWauXqVKPqNK02UWiC01Ak+6nXjs1cvxm/9ea/wWF0bcfNK0I4tXCEEbNAJVtbo+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279891>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-455497025-1445288899=:31610
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi all,

it is my pleasure to announce that Git for Windows 2.6.2 is available.
Please find it at https://git-for-windows.github.io/

Changes since Git for Windows v2.6.1 (October 5th 2015)

New Features

  =E2=80=A2 Comes with Git v2.6.2
  =E2=80=A2 Users who are part of a Windows domain now have sensible defaul=
t
    values for user.name and user.email.

Bug Fixes

  =E2=80=A2 We no longer run out of page file space when git fetching large
    repositories.
  =E2=80=A2 The description of Windows' default console is accurate now (th=
e
    console became more powerful in Windows 10).
  =E2=80=A2 Git GUI now respects the terminal emulation chosen at install t=
ime
    when running the Git Bash.

Ciao,
Johannes
--1784107012-455497025-1445288899=:31610--

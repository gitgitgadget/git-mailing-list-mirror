From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.8.0
Date: Tue, 29 Mar 2016 15:00:30 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1603291500140.4690@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-484099843-1459256437=:4690"
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:00:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktGI-0008NE-Rd
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbcC2NAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 09:00:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:61213 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbcC2NAl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 09:00:41 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MgHHO-1aPLxi3uha-00NkBh; Tue, 29 Mar 2016 15:00:37
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:50CCkKu9/6xsV/n8GIdHubNIfs8q06pBfziqzIpWuyg3yk+rXot
 6vPoA2o1sZ2JzDoUwh8o7k/V81C2nVQnopm5+iJ9sVIltLS/KhTCysxf4etLgoGURz+JHui
 M9UGJbtaYb8sLOTbyqdlTf6tgyzRV8cQMpz1FWDZo98YkWU15YoGrKHfKJAsvJBx7m/j3xE
 bvnJQzmQTDnMB0UQRKANA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GWX2vkt2oQg=:DvCTR+gsR6FWrrWuFJjNDg
 3FS/4/w9bS9GcBOH3JfY3DLwKiHWCzgqtNFhQgj3yB0xpnQbtoXksMpzBtM3HEDqRjzgog8Wo
 f1Umrbpfim9ybwslTbaJchf1lXh5h7C+IGSXxo6arThyXc4R4Db9a1MPwCcxJxYmrB5Gz0k9r
 scjILV8Qp98Y1qBgdRzROPQJ+bsRvqTk2p/03+8x64IhJK/vy2bAMvKcPsHPum1VYcYXt6y9Y
 WC16cvRedZinvUtVfo8oNjo1MRruzZZ910zd/X2skP+opJYROgFO35Iv/tZ+uKDCaAyc7+LzB
 XViVwN2X2zjD9wH6dLy7W3GLieXhMPzA0fvyYTxJqt1mIT8zAa0H7K6HjpFURGfUzkkBMo8X1
 wkqGUyIWx0yoei7yEu2y5FbiRg4qGVAHQ/QXNo1u6lSaUAinkdrnUmq5kgBOfS90SUViwDPqi
 NQuW+0ei6XphlimzBlCDhIgGRalLkQCFc5M8uT6qJn3hrbl4aGFy/g0VcUZyL1YdAAycrt14a
 sETcxZaKLGDXxpved1/NVB9PBRU4kfdklHLzxGZPd48IU/GFe4cTnk1L3/oy61VLjCSJicF/I
 JvHtSGU2h5TR8Q4e4ICRxYhPxwRIjVyRKkxKziwYPcwxDV5e613b/bycHdyqkxu/8dnofjLyr
 BDBLrhxxWsvdkWoaJmSkIAmhUNADdMxGJ2vHGkDctHZH1YSIU3iipN2I2KnZSFbGdfP/4iWlO
 H78fELwXR9vLvjWndcGNdO1dG7oz5g/uDfZ/XSwPOsQoV7X1TLwbnrQWMmBb7hy4htg6wdoI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290124>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-484099843-1459256437=:4690
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.8.0 is available from:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.7.4 (March 18th 2016)

New Features

  =E2=80=A2 Comes with Git v2.8.0.
  =E2=80=A2 Comes with the Git Credential Manager v1.2.2.
  =E2=80=A2 The FSCache feature (which was labeled experimental for quite s=
ome
    time) is now enabled by default.
  =E2=80=A2 Git is now added to the PATH by default (previously, the defaul=
t
    was for Git to be available only from Git Bash/CMD).
  =E2=80=A2 The installer now offers to launch the Git Bash right away.

Bug Fixes

  =E2=80=A2 The previous workaround for the blurred link to the Git Credent=
ial
    Manager was fixed so that the link is neither blurry nor
    overlapping.
  =E2=80=A2 The installer now changes the label of the Next button to Insta=
ll
    on the last wizard page before installing.

Filename | SHA-256
-------- | -------
Git-2.8.0-64-bit.exe | 7c431f31fdb9bb6a8575aec3099d6d4498145fe164f11cc9047c=
9ad4f885b1db
Git-2.8.0-32-bit.exe | dc27231c05523f76201a5f1c3f826a63872c4e09508b2fe1f84c=
8d675b986257
PortableGit-2.8.0-64-bit.7z.exe | a4b199e9ec7b2660b5708a92959ff0eb748bf9bec=
29f3a05d0bd015f20c06da4
PortableGit-2.8.0-32-bit.7z.exe | 6ab6e75281dc61a64ea82a79305073ccfe8ee0ba5=
72a2f1ee69e31b2ce94b66c
Git-2.8.0-64-bit.tar.bz2 | b3014123ef9d269e2db811d2e5f116167e6e73fd0c02f648=
25ea37076d3a136f
Git-2.8.0-32-bit.tar.bz2 | 01b797cb633ad4882136587067f451a50b305ca903826f43=
94ad092a7f334f2c

Ciao,
Johannes
--8323329-484099843-1459256437=:4690--

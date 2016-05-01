From: Tim Blechmann <tim@klingt.org>
Subject: [ubuntu] gitk/git gui fail after upgrade
Date: Sun, 1 May 2016 12:13:54 +0200
Message-ID: <ng4kt3$n0m$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 12:14:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awoOC-00033Z-RA
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 12:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbcEAKOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 06:14:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:44573 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbcEAKOF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 06:14:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1awoO1-0002yH-OX
	for git@vger.kernel.org; Sun, 01 May 2016 12:14:01 +0200
Received: from 84-113-185-247.dynamic.surfer.at ([84.113.185.247])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 May 2016 12:14:01 +0200
Received: from tim by 84-113-185-247.dynamic.surfer.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 May 2016 12:14:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 84-113-185-247.dynamic.surfer.at
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293148>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

hi all,

asking the experts: after upgrading one of my machines to git, gitk
and git gui fail to start ...

* git gui fails with "cannot determine git version"
* gitk fails with "cannot find a git repository here"

other git commands work fine. issue happens with git-2.7.4 and 2.8.2.
though it only happens on one of my linux machines, while the other
works like charm.

any idea what could cause this? apparently i'm not alone with this
issue [1]

tia,
tim


[1] https://bugs.launchpad.net/ubuntu/+source/git/+bug/1574213
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXJdbiAAoJEAIkvWiom07D8/QP/iy9/IZaBRorwkO85bIOsrYx
p2e5t0eTUJiAt3j2DLufviZnphlIFDqVQMqEM9V5lnif0/gGEjGC1cGeUNeXb0x8
vg6PP0THgZfg5ptCt9mPwrae16W3yaAR1rOjgLv8YBmtmN8M3eslTcGC0/TEH0qN
gsIyREcK2FhV/KhQvPIIIfTjXlrLgBs4Xwc9AJ8nTfCX5T5tWBmnSO+hfTcEtFve
pFdZPcLqNuVDlovs/EbOQo+ylkXqrMrnYLEUd79QcaDgXF99Wh0say+sVYC0+lXA
OM+uIpmV5D7X/s6rxLARli3Qj30LRDe51ERmAUWrQkOztgliRX/g4cATtl/PxXtI
oCQR2QE+lzdwW8wRl6RUhLMdbuw00/Os8hvJmHtqcF7YJuNRCfnhDLPy7C2tmkGT
L9oHjolCNr8VXp+Uo/wcB7OWYmECwoMaM8Vd022KIJYZe4hvO4PvWXztJarTWMpu
Qxjn9rK2x5hKHijJvXsbmIob69jUHptCwmZPoTktfTCTvWSk3M7BuagxT2OdzvPq
LTMKak7WnUm+Gi1v7tN0hLn49algds43JHzWhUWwrlIbP4/GUHcNKZ1bBWTiapTI
fSrzvs48vWQ7uI43eZv/vAIj7EmRprnJbsWLdaKWKPELjGMbSoGWTY+VStAZm3Vz
ZU3jXMTZMCF1sJUnzjAT
=5Oo6
-----END PGP SIGNATURE-----

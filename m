From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH] tests: make all test files executable
Date: Mon, 05 Oct 2009 21:46:06 -0400
Message-ID: <4ACAA15E.6090403@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 06 03:48:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuzAR-00063M-Ca
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 03:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbZJFBqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 21:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754941AbZJFBqy
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 21:46:54 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:60423 "EHLO
	mailchk-m02.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754702AbZJFBqy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 21:46:54 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m02.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n961k62Q006623
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Oct 2009 21:46:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
X-UUID: c825cc48-307a-462f-8f4a-de3811097504
X-Miltered: at mailchk-m02 with ID 4ACAA15E.006 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m02
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m02.uwaterloo.ca [129.97.128.141]); Mon, 05 Oct 2009 21:46:11 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129603>

=46or consistency with the rest of the test files.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---

	No changes, just a resend. This should work; I assume
	the problem last time was a human error (me :(), or
	something weird that happens with saving e-mail drafts
	between	Apple Mail and Thunderbird (they share).

	If this version is also messed up, then I give up.

	Jeff, please explain what you meant by `inscrutable
	binary'? It is an ASCII text file according to file.
	=AF\(=B0_o)/=AF

 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 =3D> 100755 t/t5531-deep-submodule-push.sh
 mode change 100644 =3D> 100755 t/t9501-gitweb-standalone-http-status.s=
h

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-pu=
sh.sh
old mode 100644
new mode 100755
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-=
standalone-http-status.sh
old mode 100644
new mode 100755
--
1.6.5.rc2

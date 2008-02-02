From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH] Fix spelling mistake; flagg -> flag
Date: Sun,  3 Feb 2008 00:58:06 +0100
Message-ID: <1201996688-5559-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 11:34:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLcBd-0000IH-A5
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 11:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbYBCKeY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 05:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbYBCKeX
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 05:34:23 -0500
Received: from banki.eumelnet.de ([83.246.114.63]:2815 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbYBCKeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 05:34:19 -0500
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 86188488042; Sun,  3 Feb 2008 11:00:17 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JLbX5-0001St-BI
	for git@vger.kernel.org; Sun, 03 Feb 2008 10:53:04 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JLSFM-0001oI-CU; Sun, 03 Feb 2008 00:58:08 +0100
X-Mailer: git-send-email 1.5.4.rc5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72346>

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 5f0f241..2ecebc4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -14,7 +14,7 @@ b,binary        pass --allo-binary-replacement to git=
-apply
 3,3way          allow fall back on 3way merging if needed
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
-k,keep          pass -k flagg to git-mailinfo
+k,keep          pass -k flag to git-mailinfo
 whitespace=3D     pass it through git-apply
 C=3D              pass it through git-apply
 p=3D              pass it through git-apply
--=20
1.5.4.rc5

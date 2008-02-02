From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH] Unify the name of the second option in the text
Date: Sun,  3 Feb 2008 00:58:08 +0100
Message-ID: <1201996688-5559-3-git-send-email-joerg@alea.gnuu.de>
References: <1201996688-5559-1-git-send-email-joerg@alea.gnuu.de>
 <1201996688-5559-2-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 11:34:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLcBc-0000IH-14
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 11:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbYBCKeU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 05:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbYBCKeU
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 05:34:20 -0500
Received: from banki.eumelnet.de ([83.246.114.63]:2810 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbYBCKeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 05:34:19 -0500
X-Greylist: delayed 2040 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Feb 2008 05:34:18 EST
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 6DFAC488041; Sun,  3 Feb 2008 11:00:12 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JLbX3-0001St-Ne
	for git@vger.kernel.org; Sun, 03 Feb 2008 10:53:01 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JLSFN-0001oX-7T; Sun, 03 Feb 2008 00:58:09 +0100
X-Mailer: git-send-email 1.5.4.rc5
In-Reply-To: <1201996688-5559-2-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72345>

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 Documentation/git-push.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 5f24944..18e0c06 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -53,7 +53,7 @@ side are updated.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
-A parameter <ref> without a colon pushes the <ref> from the source
+A parameter <refspec> without a colon pushes the <refspec> from the so=
urce
 repository to the destination repository under the same name.
 +
 Pushing an empty <src> allows you to delete the <dst> ref from
--=20
1.5.4.rc5

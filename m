From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 2/3] gitk: Add emacs editor variable block.
Date: Fri, 12 Mar 2010 18:31:48 +0000
Message-ID: <1268418709-4998-2-git-send-email-patthoyts@users.sourceforge.net>
References: <1268418709-4998-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 19:32:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq9er-00044k-FH
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 19:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934433Ab0CLScQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 13:32:16 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:58637 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934085Ab0CLScP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Mar 2010 13:32:15 -0500
Received: from [172.23.170.144] (helo=anti-virus03-07)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Nq9ea-0004Ma-DG; Fri, 12 Mar 2010 18:32:08 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1Nq9eZ-0000GK-U3; Fri, 12 Mar 2010 18:32:07 +0000
Received: from frog (pc014.patthoyts.tk [192.168.0.14])
	by fox.patthoyts.tk (Postfix) with ESMTP id 8A54B21945;
	Fri, 12 Mar 2010 18:32:07 +0000 (GMT)
Received: by frog (Postfix, from userid 1000)
	id 7B32B6D6A1D; Fri, 12 Mar 2010 18:32:28 +0000 (GMT)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1268418709-4998-1-git-send-email-patthoyts@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142060>

Help contributors use the correct indentation style.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index dc9b8a8..ed5f6ab 100755
--- a/gitk
+++ b/gitk
@@ -11614,3 +11614,9 @@ if {[tk windowingsystem] eq "win32"} {
 }
 
 getcommits {}
+
+# Local variables:
+# mode: tcl
+# indent-tabs-mode: t
+# tab-width: 8
+# End:
-- 
1.6.6

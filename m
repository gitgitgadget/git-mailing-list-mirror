From: Jon Loeliger <jdl@freescale.com>
Subject: [PATCH] Fix git-symbolic-ref typo in git.txt.
Date: Tue, 03 Jan 2006 08:38:15 -0600
Message-ID: <E1EtnIl-000879-Vb@jdl.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 15:39:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtnIz-0001vq-Sm
	for gcvg-git@gmane.org; Tue, 03 Jan 2006 15:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWACOi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 09:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWACOi1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 09:38:27 -0500
Received: from mail.jdl.com ([66.118.10.122]:7586 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932356AbWACOi0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2006 09:38:26 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EtnIl-000879-Vb
	for git@vger.kernel.org; Tue, 03 Jan 2006 08:38:16 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14148>

---

 Documentation/git.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e2d03bbe141efb2f630214e6e5123e4addf5475d
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 90c5bfa..92cfe0e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -425,7 +425,7 @@ gitlink:git-rev-parse[1]::
 gitlink:git-send-email[1]::
	Send patch e-mails out of "format-patch --mbox" output.

-gitlink:git-symbolic-refs[1]::
+gitlink:git-symbolic-ref[1]::
	Read and modify symbolic refs.

 gitlink:git-stripspace[1]::
--

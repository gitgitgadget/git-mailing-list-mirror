From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] git-subtree: fix typo in manpage
Date: Sat, 22 Dec 2012 15:46:02 +0100
Message-ID: <50D5C7AA.8020506@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 22 16:02:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmQaR-0003H0-EQ
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 16:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab2LVPBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 10:01:46 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:56873 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144Ab2LVPBp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 10:01:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id AB513DE063
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 15:50:52 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Chkxd8Ymvs-N for <git@vger.kernel.org>;
	Sat, 22 Dec 2012 15:50:52 +0100 (CET)
Received: from [192.168.1.3] (p5DD1564E.dip.t-dialin.net [93.209.86.78])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 91756DE05B
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 15:50:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212054>

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 contrib/subtree/git-subtree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 0c44fda..c5bce41 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -93,7 +93,7 @@ pull::
 	repository.
 	
 push::
-	Does a 'split' (see above) using the <prefix> supplied
+	Does a 'split' (see below) using the <prefix> supplied
 	and then does a 'git push' to push the result to the 
 	repository and refspec. This can be used to push your
 	subtree to different branches of the remote repository.
-- 
1.8.1.rc2.333.g912e06f.dirty

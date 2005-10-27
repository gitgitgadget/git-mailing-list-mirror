From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add more generated files to .gitignore
Date: Thu, 27 Oct 2005 12:03:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510271203210.16500@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 27 12:05:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV4br-0007jX-Tg
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 12:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbVJ0KDp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 06:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVJ0KDp
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 06:03:45 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:7137 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932631AbVJ0KDo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 06:03:44 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 92FA313F559; Thu, 27 Oct 2005 12:03:43 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 77C429EFB3; Thu, 27 Oct 2005 12:03:43 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 63E989EFAB; Thu, 27 Oct 2005 12:03:43 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 487FE13F559; Thu, 27 Oct 2005 12:03:43 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10709>

git-name-rev, git-mv and git-shell are recent additions to git.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 .gitignore |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
diff --git a/.gitignore b/.gitignore
index 52cb9e2..927c89c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -54,6 +54,8 @@ git-merge-recursive
 git-merge-resolve
 git-merge-stupid
 git-mktag
+git-name-rev
+git-mv
 git-octopus
 git-pack-objects
 git-parse-remote
@@ -78,6 +80,7 @@ git-revert
 git-send-email
 git-send-pack
 git-sh-setup
+git-shell
 git-shortlog
 git-show-branch
 git-show-index

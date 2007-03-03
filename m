From: Xavier Maillard <zedek@gnu.org>
Subject: [PATCH 3/7] Updated TODO list (vc-git.el)
Date: Sat, 03 Mar 2007 11:19:02 +0100
Message-ID: <15287.1172917142@localhost>
Cc: julliard@winehq.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 11:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNRNl-0004oC-Ta
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 11:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbXCCKVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 05:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbXCCKVy
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 05:21:54 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:47611 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbXCCKVx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 05:21:53 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 8AB847CD8;
	Sat,  3 Mar 2007 11:21:52 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l23AJ2Tg015288;
	Sat, 3 Mar 2007 11:19:02 +0100
X-Mailer: MH-E 8.0.3; nmh 1.2; GNU Emacs 23.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41281>



Signed-off-by: Xavier Maillard <zedek@gnu.org>
---
 contrib/emacs/vc-git.el |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 8ec470c..4cab845 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -27,7 +27,9 @@
 ;; TODO
 ;;  - changelog generation
 ;;  - working with revisions other than HEAD
-;;
+;;  - code (re)factoring
+;;  - docstrings
+;;  - more customisable variables
 
 (eval-when-compile 
   (require 'cl)
-- 
1.5.0

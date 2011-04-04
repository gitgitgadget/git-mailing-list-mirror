From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] Documentation: trivial grammar fix in core.worktree
	description
Date: Mon, 4 Apr 2011 16:59:25 +0200
Message-ID: <1301929165-4078-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 04 16:59:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6lFk-0003xq-9d
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 16:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701Ab1DDO7e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 10:59:34 -0400
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:28607 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab1DDO7d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 10:59:33 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.270.1; Mon, 4 Apr
 2011 16:59:28 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Mon, 4 Apr
 2011 16:59:30 +0200
X-Mailer: git-send-email 1.7.5.rc0.154.ge1c33
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170815>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1d0d1b7..e14e9d0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -320,7 +320,7 @@ core.worktree::
 	Set the path to the root of the working tree.
 	This can be overridden by the GIT_WORK_TREE environment
 	variable and the '--work-tree' command line option.
-	The value can an absolute path or relative to the path to
+	The value can be an absolute path or relative to the path to
 	the .git directory, which is either specified by --git-dir
 	or GIT_DIR, or automatically discovered.
 	If --git-dir or GIT_DIR is specified but none of
--=20
1.7.5.rc0.154.ge1c33

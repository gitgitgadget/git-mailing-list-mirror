From: Bill Lear <rael@zopyra.com>
Subject: [PATCH] Correct spelling in diff.c comment
Date: Wed, 16 Jan 2008 06:46:53 -0600
Message-ID: <1200487613-29766-1-git-send-email-rael@zopyra.com>
Cc: Bill Lear <rael@zopyra.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 13:47:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF7fv-00085w-5R
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 13:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbYAPMqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 07:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbYAPMqz
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 07:46:55 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60107 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbYAPMqy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 07:46:54 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m0GCkr729785;
	Wed, 16 Jan 2008 06:46:53 -0600
X-Mailer: git-send-email gitgui.0.8.4.g9c514
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70662>

Correct a spelling mistake in a comment.

Signed-off-by: Bill Lear <rael@zopyra.com>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index b18c140..9ee0c41 100644
--- a/diff.c
+++ b/diff.c
@@ -1224,7 +1224,7 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
 
 	/*
 	 * And define built-in fallback patterns here.  Note that
-	 * these can be overriden by the user's config settings.
+	 * these can be overridden by the user's config settings.
 	 */
 	for (i = 0; i < ARRAY_SIZE(builtin_funcname_pattern); i++)
 		if (!strcmp(ident, builtin_funcname_pattern[i].name))
-- 
gitgui.0.8.4.g9c514

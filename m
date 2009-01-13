From: jidanni@jidanni.org
Subject: [PATCH/RFC] Documentation/SubmittingPatches: emacs whitespace tip
Date: Tue, 13 Jan 2009 11:27:38 +0800
Message-ID: <87k58zopg5.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 04:29:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMZxh-0000iV-5n
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 04:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbZAMD1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 22:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbZAMD1l
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 22:27:41 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:36320 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751932AbZAMD1k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 22:27:40 -0500
Received: from jidanni.org (122-127-34-152.dynamic.hinet.net [122.127.34.152])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 16885408FF
	for <git@vger.kernel.org>; Mon, 12 Jan 2009 19:27:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105448>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/SubmittingPatches |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ba07c8c..7b64343 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -442,6 +442,8 @@ whitespaces (fatal in patches).  Running 'C-u g' to display the
 message in raw form before using '|' to run the pipe can work
 this problem around.
 
+Inside gnus or not, a (setq-default show-trailing-whitespace t) in
+one's ~/.emacs file will reduce whitespace embarrassment incidents.
 
 KMail
 -----
-- 
1.6.0.6

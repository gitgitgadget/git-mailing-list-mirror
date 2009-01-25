From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] diff-options.txt: Fix asciidoc markup issue
Date: Sun, 25 Jan 2009 07:18:41 +0200
Message-ID: <1232860721-6174-1-git-send-email-tlikonen@iki.fi>
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 25 06:22:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQxS6-0007jt-O9
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 06:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbZAYFSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 00:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbZAYFSy
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 00:18:54 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:47022 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbZAYFSy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 00:18:54 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A88042E3479; Sun, 25 Jan 2009 07:18:51 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LQxOL-0001c1-Dt; Sun, 25 Jan 2009 07:18:41 +0200
X-Mailer: git-send-email 1.6.1.295.g75c4eae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107042>

Must be "--patience::", not "--patience:".
---
 Documentation/diff-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 3816a83..813a7b1 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -36,7 +36,7 @@ endif::git-format-patch[]
 --patch-with-raw::
 	Synonym for "-p --raw".
 
---patience:
+--patience::
 	Generate a diff using the "patience diff" algorithm.
 
 --stat[=width[,name-width]]::
-- 
1.6.1.295.g75c4eae

From: Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH 1/2] Add transport native helper executables to .gitignore
Date: Thu,  6 Aug 2009 14:14:44 +0100
Message-ID: <f4271a23eed2a6bc3774fb8e21563e74f9b1fb19.1249563483.git.mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 15:13:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ2m3-0004zb-8n
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 15:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668AbZHFNLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 09:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755833AbZHFNLC
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 09:11:02 -0400
Received: from [82.109.193.99] ([82.109.193.99]:45473 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755825AbZHFNLA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 09:11:00 -0400
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id E4E721D53F9; Thu,  6 Aug 2009 14:14:45 +0100 (BST)
X-Mailer: git-send-email 1.6.3.1.54.g99dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125068>

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 .gitignore |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 10808e3..c446290 100644
--- a/.gitignore
+++ b/.gitignore
@@ -104,6 +104,9 @@ git-receive-pack
 git-reflog
 git-relink
 git-remote
+git-remote-ftp
+git-remote-http
+git-remote-https
 git-repack
 git-replace
 git-repo-config
-- 
1.6.4.115.g33d49.dirty

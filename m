From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/19] doc: Add a link from gitattributes(5) to git-check-attr(1)
Date: Thu, 28 Jul 2011 06:46:40 +0200
Message-ID: <1311828418-2676-2-git-send-email-mhagger@alum.mit.edu>
References: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 28 06:47:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIVY-0005eI-Mb
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab1G1ErZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:47:25 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57249 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab1G1ErV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:47:21 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmITD-000889-6V; Thu, 28 Jul 2011 06:45:15 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178016>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/gitattributes.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 412c55b..3d86434 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -952,6 +952,9 @@ frotz	unspecified
 ----------------------------------------------------------------
 
 
+SEE ALSO
+--------
+linkgit:git-check-attr[1].
 
 GIT
 ---
-- 
1.7.6.8.gd2879

From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/23] doc: Add a link from gitattributes(5) to git-check-attr(1)
Date: Thu,  4 Aug 2011 06:36:11 +0200
Message-ID: <1312432593-9841-2-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QopgU-0005Mu-IN
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab1HDEhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:19 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39639 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab1HDEg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:36:59 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHf029203;
	Thu, 4 Aug 2011 06:36:51 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178677>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/gitattributes.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 2bbe76b..25e46ae 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -955,6 +955,9 @@ frotz	unspecified
 ----------------------------------------------------------------
 
 
+SEE ALSO
+--------
+linkgit:git-check-attr[1].
 
 GIT
 ---
-- 
1.7.6.8.gd2879

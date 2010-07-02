From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] Documentation/RelNotes-1.7.2.txt: Fix typo
Date: Thu,  1 Jul 2010 20:52:44 -0400
Message-ID: <1278031964-12188-2-git-send-email-vonbrand@inf.utfsm.cl>
References: <1278031964-12188-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 02 03:25:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUV0A-0005Rf-Px
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 03:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab0GBBY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 21:24:59 -0400
Received: from inti.inf.utfsm.cl ([200.1.19.1]:34678 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754692Ab0GBBY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 21:24:58 -0400
X-Greylist: delayed 1914 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2010 21:24:57 EDT
Received: from quelen.inf.utfsm.cl (quelen.inf.utfsm.cl [200.1.19.54])
	by inti.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id o620qw6l023175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Jul 2010 20:52:58 -0400
Received: from laptop14.inf.utfsm.cl (pc-194-64-214-201.cm.vtr.net [201.214.64.194])
	by quelen.inf.utfsm.cl (8.14.4/8.14.4) with ESMTP id o620gv1F022151;
	Thu, 1 Jul 2010 20:42:57 -0400
Received: from laptop14.inf.utfsm.cl (laptop14.inf.utfsm.cl [127.0.0.1])
	by laptop14.inf.utfsm.cl (8.14.4/8.14.3) with ESMTP id o620qule012229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Jul 2010 20:52:57 -0400
Received: (from vonbrand@localhost)
	by laptop14.inf.utfsm.cl (8.14.4/8.14.4/Submit) id o620qu9b012228;
	Thu, 1 Jul 2010 20:52:56 -0400
X-Mailer: git-send-email 1.7.2.rc1
In-Reply-To: <1278031964-12188-1-git-send-email-vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (inti.inf.utfsm.cl [0.0.0.0]); Thu, 01 Jul 2010 20:52:58 -0400 (CLT)
X-Spam-Status: No, score=-97.6 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,TO_NO_BRKTS_DYNIP,UNPARSEABLE_RELAY,
	USER_IN_WHITELIST autolearn=no version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150096>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/RelNotes-1.7.2.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/RelNotes-1.7.2.txt b/Documentation/RelNotes-1.7.2.txt
index aa79f06..d14f06b 100644
--- a/Documentation/RelNotes-1.7.2.txt
+++ b/Documentation/RelNotes-1.7.2.txt
@@ -74,7 +74,7 @@ Updates since v1.7.1
  * Various options to "git grep" (e.g. --count, --name-only) work better
    with binary files.
 
- * "git grep" learned "-Ovi" to open the files with hits in yoru editor.
+ * "git grep" learned "-Ovi" to open the files with hits in your editor.
 
  * "git help -w" learned "chrome" and "chromium" browsers.
 
-- 
1.7.2.rc1

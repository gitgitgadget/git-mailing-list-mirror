From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH 1/1] Typo in contrib/examples/git-svnimport.txt
Date: Wed, 25 Feb 2009 10:04:25 -0300
Message-ID: <1235567065-7639-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 14:56:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcKFD-0004Q7-La
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 14:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbZBYNys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 08:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752835AbZBYNyr
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 08:54:47 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55724 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbZBYNyr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 08:54:47 -0500
X-Greylist: delayed 3015 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Feb 2009 08:54:46 EST
Received: from quelen.inf.utfsm.cl (quelen.inf.utfsm.cl [200.1.19.54])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id n1PD4QqV019616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Feb 2009 10:04:26 -0300
Received: from laptop14.inf.utfsm.cl (cautin.dcsc.utfsm.cl [200.1.21.41])
	by quelen.inf.utfsm.cl (8.14.3/8.14.3) with ESMTP id n1PD4Plb017720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Feb 2009 10:04:26 -0300
Received: from laptop14.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop14.inf.utfsm.cl (8.14.3/8.14.2) with ESMTP id n1PD4PT1007672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Feb 2009 10:04:25 -0300
Received: (from vonbrand@localhost)
	by laptop14.inf.utfsm.cl (8.14.3/8.14.3/Submit) id n1PD4PWU007671;
	Wed, 25 Feb 2009 10:04:25 -0300
X-Mailer: git-send-email 1.6.2.rc1.41.g3f74c
X-Greylist: Sender e-mail whitelisted, not delayed by milter-greylist-3.0rc6 (inti.inf.utfsm.cl [0.0.0.0]); Wed, 25 Feb 2009 10:04:26 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.94/9047/Wed Feb 25 07:59:41 2009 on inti.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-102.6 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY,USER_IN_WHITELIST autolearn=ham version=3.2.4
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111457>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 contrib/examples/git-svnimport.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/examples/git-svnimport.txt b/contrib/examples/git-svnimport.txt
index 71aad8b..450a4a3 100644
--- a/contrib/examples/git-svnimport.txt
+++ b/contrib/examples/git-svnimport.txt
@@ -116,7 +116,7 @@ due to SVN memory leaks. (These have been worked around.)
 +
 The default value is 1000. git-svnimport will do import in chunks of 1000
 revisions, after each chunk git repository will be repacked. To disable
-this behavior specify some big value here which is mote than number of
+this behavior specify some big value here which is more than number of
 revisions to import.
 
 -P <path_from_trunk>::
-- 
1.6.2.rc1.41.g3f74c

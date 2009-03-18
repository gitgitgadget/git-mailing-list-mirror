From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/12] Fix copyright year in revwalk test file headers
Date: Tue, 17 Mar 2009 18:40:40 -0700
Message-ID: <1237340451-31562-2-git-send-email-spearce@spearce.org>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:44:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkpL-00052N-Ua
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756449AbZCRBlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756162AbZCRBlA
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:41:00 -0400
Received: from george.spearce.org ([209.20.77.23]:56648 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922AbZCRBk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:40:59 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 83B5D38260; Wed, 18 Mar 2009 01:40:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DE07C38221;
	Wed, 18 Mar 2009 01:40:51 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237340451-31562-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113554>

These were all created in 2009, not 2008.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/revwalk/RevFlagSetTest.java   |    2 +-
 .../org/spearce/jgit/revwalk/RevWalkCullTest.java  |    2 +-
 .../spearce/jgit/revwalk/RevWalkFilterTest.java    |    2 +-
 .../spearce/jgit/revwalk/RevWalkMergeBaseTest.java |    2 +-
 .../org/spearce/jgit/revwalk/RevWalkSortTest.java  |    2 +-
 .../org/spearce/jgit/revwalk/RevWalkTestCase.java  |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevFlagSetTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevFlagSetTest.java
index 76f3cbb..ff02d64 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevFlagSetTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevFlagSetTest.java
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008, Google Inc.
+ * Copyright (C) 2009, Google Inc.
  *
  * All rights reserved.
  *
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkCullTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkCullTest.java
index 93bd645..e734273 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkCullTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkCullTest.java
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008, Google Inc.
+ * Copyright (C) 2009, Google Inc.
  *
  * All rights reserved.
  *
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
index cf2975d..d079bdc 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008, Google Inc.
+ * Copyright (C) 2009, Google Inc.
  *
  * All rights reserved.
  *
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java
index b05e774..cec4e3f 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008, Google Inc.
+ * Copyright (C) 2009, Google Inc.
  *
  * All rights reserved.
  *
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkSortTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkSortTest.java
index 6f2eedc..3ed1565 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkSortTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkSortTest.java
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008, Google Inc.
+ * Copyright (C) 2009, Google Inc.
  *
  * All rights reserved.
  *
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
index bd696dd..a477be9 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008, Google Inc.
+ * Copyright (C) 2009, Google Inc.
  *
  * All rights reserved.
  *
-- 
1.6.2.1.286.g8173

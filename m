From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [QGIT4 PATCH 5/6] remove empty space below "diff to" header in patch view
Date: Fri, 20 Jul 2007 23:53:15 +0200
Message-ID: <20070723204323.5DC9C28ABA1@mail-in-07.arcor-online.net>
References: <200707232232.39546.kumbayo84@arcor.de>
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 22:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4lB-0008Sg-Om
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934619AbXGWUn1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934726AbXGWUn0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:43:26 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:52995 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934394AbXGWUnY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 16:43:24 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 9C9A119B3D3;
	Mon, 23 Jul 2007 22:43:23 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 902CB212FAF;
	Mon, 23 Jul 2007 22:43:23 +0200 (CEST)
Received: from fnoheim223.netpark.at (fnoheim223.netpark.at [83.68.151.223])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 5DC9C28ABA1;
	Mon, 23 Jul 2007 22:43:23 +0200 (CEST)
X-Mailbox-Line: From 8841648e530f6302f71b1cbc1abdcc48a4eb3181 Mon Sep 17 00:00:00 2001
In-Reply-To: <200707232232.39546.kumbayo84@arcor.de>
Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
X-Virus-Scanned: ClamAV 0.91.1/3744/Mon Jul 23 21:05:34 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53477>

---
 src/patchview.ui |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/patchview.ui b/src/patchview.ui
index 6dbf53c..b4d3081 100644
--- a/src/patchview.ui
+++ b/src/patchview.ui
@@ -31,7 +31,7 @@
    <item>
     <layout class="QVBoxLayout" >
      <property name="spacing" >
-      <number>6</number>
+      <number>0</number>
      </property>
      <property name="leftMargin" >
       <number>0</number>
@@ -131,7 +131,7 @@
          <property name="sizeHint" >
           <size>
            <width>20</width>
-           <height>40</height>
+           <height>0</height>
           </size>
          </property>
         </spacer>
-- 
1.5.3.rc2.30.g1fe72

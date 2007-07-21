From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [QGIT4 PATCH 6/6] remove empty space below button bar in file view
Date: Sat, 21 Jul 2007 15:22:42 +0200
Message-ID: <20070723204323.A8F4828ABA1@mail-in-07.arcor-online.net>
References: <200707232232.39546.kumbayo84@arcor.de>
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 22:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4lD-0008Sg-DA
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934726AbXGWUnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934394AbXGWUna
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:43:30 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:60668 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934362AbXGWUnZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 16:43:25 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id DC87027F0F;
	Mon, 23 Jul 2007 22:43:23 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id CB9BD12D75F;
	Mon, 23 Jul 2007 22:43:23 +0200 (CEST)
Received: from fnoheim223.netpark.at (fnoheim223.netpark.at [83.68.151.223])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id A8F4828ABA1;
	Mon, 23 Jul 2007 22:43:23 +0200 (CEST)
X-Mailbox-Line: From 48b7bd0585330bf78ec47f7c70a6ccc2a6194d12 Mon Sep 17 00:00:00 2001
In-Reply-To: <200707232232.39546.kumbayo84@arcor.de>
Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
X-Virus-Scanned: ClamAV 0.91.1/3744/Mon Jul 23 21:05:34 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53480>

---
 src/fileview.ui |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/fileview.ui b/src/fileview.ui
index 190ed5e..97fa000 100644
--- a/src/fileview.ui
+++ b/src/fileview.ui
@@ -31,7 +31,7 @@
    <item>
     <layout class="QVBoxLayout" >
      <property name="spacing" >
-      <number>6</number>
+      <number>0</number>
      </property>
      <property name="leftMargin" >
       <number>0</number>
-- 
1.5.3.rc2.30.g1fe72

From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] git-config.txt: fix a typo
Date: Fri, 12 Dec 2008 10:00:41 +0100
Message-ID: <87hc59ix8m.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 10:02:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LB3uV-0001Un-39
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 10:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248AbYLLJAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 04:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757137AbYLLJAo
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 04:00:44 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:58964 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756959AbYLLJAo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 04:00:44 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 6BEC017B54F
	for <git@vger.kernel.org>; Fri, 12 Dec 2008 10:00:42 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5869017B54E
	for <git@vger.kernel.org>; Fri, 12 Dec 2008 10:00:42 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 1049F50033; Fri, 12 Dec 2008 10:00:42 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102890>


---
 Documentation/git-config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 28e1861..19a8917 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -279,7 +279,7 @@ If you want to know all the values for a multivar, do:
 % git config --get-all core.gitproxy
 ------------

-If you like to live dangerous, you can replace *all* core.gitproxy by a
+If you like to live dangerously, you can replace *all* core.gitproxy by a
 new one with

 ------------
--
1.6.1.rc2.299.gead4c

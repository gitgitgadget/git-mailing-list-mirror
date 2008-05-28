From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Revision waling documentation: fix a typo
Date: Thu, 29 May 2008 00:08:15 +0200
Message-ID: <1212012495-5782-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 00:09:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1TpU-0005dQ-Hj
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 00:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbYE1WIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 18:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753400AbYE1WIP
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 18:08:15 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:55407 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbYE1WIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 18:08:14 -0400
Received: from vmobile.example.net (dsl5401C7B3.pool.t-online.hu [84.1.199.179])
	by yugo.frugalware.org (Postfix) with ESMTP id 2D8011DDC5B;
	Thu, 29 May 2008 00:08:12 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7C7D318E2A7; Thu, 29 May 2008 00:08:15 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83140>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/technical/api-revision-walking.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/api-revision-walking.txt b/Documentation/technical/api-revision-walking.txt
index 01a2455..c0797d3 100644
--- a/Documentation/technical/api-revision-walking.txt
+++ b/Documentation/technical/api-revision-walking.txt
@@ -4,6 +4,6 @@ revision walking API
 Talk about <revision.h>, things like:
 
 * two diff_options, one for path limiting, another for output;
-* calling sequence: init_revisions(), setup_revsions(), get_revision();
+* calling sequence: init_revisions(), setup_revisions(), get_revision();
 
 (Linus, JC, Dscho)
-- 
1.5.6.rc0.dirty

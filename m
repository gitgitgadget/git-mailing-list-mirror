From: Jeff King <peff@peff.net>
Subject: [PATCH] Add git-browse-help to gitignore
Date: Mon, 10 Dec 2007 05:29:18 -0500
Message-ID: <20071210102917.GA18903@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 11:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ftO-0000Ev-4E
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 11:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbXLJK3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 05:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbXLJK3V
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 05:29:21 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4246 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbXLJK3U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 05:29:20 -0500
Received: (qmail 31977 invoked by uid 111); 10 Dec 2007 10:29:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 10 Dec 2007 05:29:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Dec 2007 05:29:18 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67700>


Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index bac60ce..5eaba41 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,6 +12,7 @@ git-archive
 git-bisect
 git-blame
 git-branch
+git-browse-help
 git-bundle
 git-cat-file
 git-check-attr
-- 
1.5.3.7.2227.gf64a8

From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] replace: replace spaces with tabs in indentation
Date: Tue, 24 Jun 2014 05:43:07 -0400
Message-ID: <20140624094303.GA14514@sigill.intra.peff.net>
References: <20140624094217.GA14216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 11:43:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzNG3-0006tw-VD
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 11:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbaFXJnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 05:43:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:50131 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751859AbaFXJnN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 05:43:13 -0400
Received: (qmail 16375 invoked by uid 102); 24 Jun 2014 09:43:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jun 2014 04:43:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2014 05:43:07 -0400
Content-Disposition: inline
In-Reply-To: <20140624094217.GA14216@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252391>

This matches our usual style and the surrounding code.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/replace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 1bb491d..8507835 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -23,9 +23,9 @@ static const char * const git_replace_usage[] = {
 };
 
 enum replace_format {
-      REPLACE_FORMAT_SHORT,
-      REPLACE_FORMAT_MEDIUM,
-      REPLACE_FORMAT_LONG
+	REPLACE_FORMAT_SHORT,
+	REPLACE_FORMAT_MEDIUM,
+	REPLACE_FORMAT_LONG
 };
 
 struct show_data {
-- 
2.0.0.566.gfe3e6b2

From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] command-list: add git-sh-i18n
Date: Wed, 8 Aug 2012 14:34:39 -0400
Message-ID: <20120808183439.GC24574@sigill.intra.peff.net>
References: <20120808183132.GA24550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 20:34:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzB5n-0001bq-Df
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 20:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932842Ab2HHSeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 14:34:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57543 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932561Ab2HHSep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 14:34:45 -0400
Received: (qmail 9592 invoked by uid 107); 8 Aug 2012 18:34:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 14:34:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 14:34:39 -0400
Content-Disposition: inline
In-Reply-To: <20120808183132.GA24550@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203112>

This is in the same category as git-sh-setup.

Signed-off-by: Jeff King <peff@peff.net>
---
 command-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/command-list.txt b/command-list.txt
index ec64cac..1da8f0d 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -114,6 +114,7 @@ git-show                                mainporcelain common
 git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
+git-sh-i18n                             purehelpers
 git-sh-setup                            purehelpers
 git-stash                               mainporcelain
 git-status                              mainporcelain common
-- 
1.7.12.rc2.2.g584e0d9

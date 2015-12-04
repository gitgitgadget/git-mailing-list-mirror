From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2015, #02; Fri, 4)
Date: Fri, 4 Dec 2015 18:24:36 -0500
Message-ID: <20151204232436.GB15064@sigill.intra.peff.net>
References: <xmqqa8pprej5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 00:24:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4ziV-0001QY-IQ
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 00:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356AbbLDXYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 18:24:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:37608 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755226AbbLDXYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 18:24:39 -0500
Received: (qmail 12608 invoked by uid 102); 4 Dec 2015 23:24:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 17:24:38 -0600
Received: (qmail 30289 invoked by uid 107); 4 Dec 2015 23:24:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 18:24:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Dec 2015 18:24:36 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa8pprej5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282017>

On Fri, Dec 04, 2015 at 03:15:58PM -0800, Junio C Hamano wrote:

> You can find the normal integration branches at:
> 
>     https://github.com/git/git/
> 
> and all topic branches at:
> 
>     https://github.com/peff/git/
> 
> But note that I will _not_ be pushing to kernel.org.

You may want to update this in the whats-cooking template. :)

diff --git a/whats-cooking.txt b/whats-cooking.txt
index 43394b7..04f6208 100644
--- a/whats-cooking.txt
+++ b/whats-cooking.txt
@@ -25,7 +25,11 @@ and all topic branches at:
 
     https://github.com/peff/git/
 
-But note that I will _not_ be pushing to kernel.org.
+You can find the changes described here in the integration branches
+of the repositories listed at
+
+    http://git-blame.blogspot.com/p/git-public-repositories.html
+
 
 --------------------------------------------------
 [Graduated to "master"]

-Peff

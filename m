From: Jeff King <peff@peff.net>
Subject: Re: GIT Performance question
Date: Sat, 17 Apr 2010 07:55:02 -0400
Message-ID: <20100417115502.GC28623@coredump.intra.peff.net>
References: <1271498149921-4917066.post@n2.nabble.com>
 <20100417104037.GA20631@dpotapov.dyndns.org>
 <1271503273779-4917251.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: santos2010 <santos.claudia2009@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 13:55:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O36cc-0006oP-D9
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 13:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541Ab0DQLze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 07:55:34 -0400
Received: from peff.net ([208.65.91.99]:40033 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137Ab0DQLzd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 07:55:33 -0400
Received: (qmail 17432 invoked by uid 107); 17 Apr 2010 11:55:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Apr 2010 07:55:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Apr 2010 07:55:02 -0400
Content-Disposition: inline
In-Reply-To: <1271503273779-4917251.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145140>

On Sat, Apr 17, 2010 at 03:21:13AM -0800, santos2010 wrote:

> Thanks a lot for the quick answer. Are there some references (on-line books
> or web pages) where i could find details about this approach? I need this to
> justify my evaluation :)

Try the "Git Internals" chapter of Scott Chacon's Pro Git book, which is
available online here:

  http://progit.org/book/ch9-0.html

He has some pretty pictures, too.

-Peff

From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH] git-send-email: skip RFC2047 quoting for ASCII subjects
Date: Thu, 25 Oct 2012 13:19:19 +0200
Message-ID: <20121025111919.GA25272@shrek.podlesie.net>
References: <1351065815-22416-1-git-send-email-krzysiek@podlesie.net>
 <20121024084636.GA23500@sigill.intra.peff.net>
 <20121024171036.GA18880@shrek.podlesie.net>
 <20121024192530.GA26477@sigill.intra.peff.net>
 <20121024210826.GA23562@shrek.podlesie.net>
 <20121025090149.GC8390@sigill.intra.peff.net>
 <20121025100854.GN8390@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 13:25:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRLZ5-0006XE-GB
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 13:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669Ab2JYLZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 07:25:19 -0400
Received: from shrek-modem2.podlesie.net ([83.13.132.46]:49070 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422642Ab2JYLZS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 07:25:18 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 67A8A399; Thu, 25 Oct 2012 13:19:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20121025100854.GN8390@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208393>

On Thu, Oct 25, 2012 at 06:08:54AM -0400, Jeff King wrote:
> 
> Ah, never mind. I missed your earlier "use compose-encoding for
> Subject". I've queued it and all of the follow-ons onto the
> km/send-email-compose-encoding topic.
> 

thanks, what about the problem with whitespaces in "quote_subject" patch?

Krzysiek

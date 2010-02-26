From: Jeff King <peff@peff.net>
Subject: Re: git as an sfc member project
Date: Fri, 26 Feb 2010 07:25:54 -0500
Message-ID: <20100226122554.GA10198@coredump.intra.peff.net>
References: <20100224154452.GA25872@coredump.intra.peff.net>
 <201002241844.37207.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 26 13:26:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkzGz-0005Ca-4l
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 13:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935856Ab0BZM0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 07:26:01 -0500
Received: from peff.net ([208.65.91.99]:53505 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935863Ab0BZMZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 07:25:59 -0500
Received: (qmail 31912 invoked by uid 107); 26 Feb 2010 12:26:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 26 Feb 2010 07:26:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2010 07:25:54 -0500
Content-Disposition: inline
In-Reply-To: <201002241844.37207.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141124>

On Wed, Feb 24, 2010 at 06:44:37PM +0100, Christian Couder wrote:

> > Junio C Hamano <gitster@pobox.com>
> > Shawn O. Pearce <spearce@spearce.org>
> > Linus Torvalds <torvalds@linux-foundation.org>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Eric Wong <normalperson@yhbt.net>
> > Jeff King <peff@peff.net>
> > Jakub Narebski <jnareb@gmail.com>
> > Nicolas Pitre <nico@fluxnic.net>
> > Paul Mackerras <paulus@samba.org>
> > Christian Couder <chriscool@tuxfamily.org>
> 
> I am very happy to be considered a key developer in your list, but it seems 
> unfair for both Johannes Sixt and Simon Hausmann as they have a higher commit 
> count than I have. So you should perhaps add them too. Or did you count lines 
> of code?

No, I used "shortlog -nse" because I wanted the email addresses, but
that short-changes people who have patches under multiple addresses.
Some of them I just removed duplicates (like Linus), but for some people
it bumped them off the top 10 list.

I'll fix that in the next iteration.

-Peff

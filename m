From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2015, #04; Tue, 24)
Date: Wed, 25 Nov 2015 05:15:44 -0500
Message-ID: <20151125101543.GA2738@sigill.intra.peff.net>
References: <20151125010722.GA23632@sigill.intra.peff.net>
 <20151125101342.GE18913@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:16:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1X7T-0007md-P3
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 11:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbbKYKPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 05:15:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:33797 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751412AbbKYKPr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 05:15:47 -0500
Received: (qmail 31928 invoked by uid 102); 25 Nov 2015 10:15:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 04:15:47 -0600
Received: (qmail 24902 invoked by uid 107); 25 Nov 2015 10:15:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 05:15:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2015 05:15:44 -0500
Content-Disposition: inline
In-Reply-To: <20151125101342.GE18913@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281694>

On Wed, Nov 25, 2015 at 10:13:42AM +0000, John Keeping wrote:

> On Tue, Nov 24, 2015 at 08:07:23PM -0500, Jeff King wrote:
> > * jk/send-email-ssl-errors (2015-11-24) 1 commit
> >  - send-email: enable SSL level 1 debug output
> > 
> >  Improve error reporting when SMTP TLS fails.
> > 
> >  Will merge to 'next'.
> 
> Can you hold off on this one?  I think my last-minute change not to
> switch on --smtp-debug has introduced a Perl warning that needs to be
> suppressed.

Sure. Thanks for letting me know.

-Peff

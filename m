From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] config-include fixes
Date: Thu, 16 Feb 2012 22:23:25 -0500
Message-ID: <20120217032325.GB5738@sigill.intra.peff.net>
References: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
 <20120214214729.GA24711@sigill.intra.peff.net>
 <7vmx8l5aw3.fsf@alter.siamese.dyndns.org>
 <20120214220953.GC24802@sigill.intra.peff.net>
 <20120216080102.GA11793@sigill.intra.peff.net>
 <7v1upuzgfr.fsf@alter.siamese.dyndns.org>
 <20120217001438.GD4756@sigill.intra.peff.net>
 <7vty2quq9r.fsf@alter.siamese.dyndns.org>
 <20120217031723.GA5738@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 04:23:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyEQ1-0007ny-Sq
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 04:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab2BQDX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 22:23:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38911
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356Ab2BQDX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 22:23:28 -0500
Received: (qmail 3544 invoked by uid 107); 17 Feb 2012 03:30:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 22:30:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 22:23:25 -0500
Content-Disposition: inline
In-Reply-To: <20120217031723.GA5738@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190934>

On Thu, Feb 16, 2012 at 10:17:23PM -0500, Jeff King wrote:

> On Thu, Feb 16, 2012 at 06:50:40PM -0800, Junio C Hamano wrote:
> 
> > I'll push out the re-roll that follows your outline above in 'pu'; I think
> > I got all the conflict resolved correctly, but please eyeball the result.
> 
> Will do.

I see you just pushed it out. The result looks good to me.

> Since you are re-rolling, these are the documentation fixes I had
> squashed in based on your earlier review (though come to think of it,
> the new patches should now also describe `git_config_with_options`).

Looks like you just reverted the "include" patch instead of the merge of
the whole topic.  I'll prepare a few documentation fixups on top, then.

-Peff

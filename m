From: Jeff King <peff@peff.net>
Subject: Re: git://github.com/some/thing.git/?
Date: Wed, 28 Mar 2012 00:28:26 -0400
Message-ID: <20120328042826.GC30251@sigill.intra.peff.net>
References: <7vpqbyjbbx.fsf@alter.siamese.dyndns.org>
 <20120327163339.GA5941@sigill.intra.peff.net>
 <7vd37xj3zh.fsf@alter.siamese.dyndns.org>
 <20120327183833.GB8460@sigill.intra.peff.net>
 <20120327184754.GA27070@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 06:28:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCkUt-0004Q7-98
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 06:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103Ab2C1E23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 00:28:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34874
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab2C1E23 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 00:28:29 -0400
Received: (qmail 10958 invoked by uid 107); 28 Mar 2012 04:28:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 00:28:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 00:28:26 -0400
Content-Disposition: inline
In-Reply-To: <20120327184754.GA27070@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194104>

On Tue, Mar 27, 2012 at 01:47:54PM -0500, Jonathan Nieder wrote:

> > For some definition of "we"; AFAICT, github has never allowed this, and
> > this is the first complaint
> 
> I complained and got a dismissive response about two years ago. ;-)  I
> am not sure if bugs from back then are tracked any more.  The URL in
> my records is [1].

I wasn't able to find the original discussion, as we've migrated through
a few different support systems in the last few years. Probably it is in
there somewhere, but I don't usually do support stuff, and I didn't
think it was worth bothering the regular support people with it.

> > However, it turned out to be a one-line patch. I've pushed it out for
> > review by other GitHubbers.
> 
> Hoorah!  Thanks for taking care of it.

FYI, this is now deployed, and the various front-end machines are
getting updated slowly over the next few hours (until then, it's
non-deterministic whether it will work for you or not :) ).

-Peff

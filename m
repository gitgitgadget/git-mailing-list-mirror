From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
	objects'
Date: Thu, 18 Oct 2007 22:12:55 -0400
Message-ID: <20071019021255.GD3290@coredump.intra.peff.net>
References: <20071019004527.GA12930@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihMs-0007Lw-1l
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933563AbXJSCM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764993AbXJSCM7
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:12:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3204 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764181AbXJSCM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:12:58 -0400
Received: (qmail 7426 invoked by uid 111); 19 Oct 2007 02:12:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 22:12:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 22:12:55 -0400
Content-Disposition: inline
In-Reply-To: <20071019004527.GA12930@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61601>

On Thu, Oct 18, 2007 at 08:45:27PM -0400, Shawn O. Pearce wrote:

> Recently I was referred to the Grammar Police as the git-pack-objects
> progress message 'Deltifying %u objects' is considered to be not
> proper English to at least some small but vocal segment of the
> English speaking population.  Techncially we are applying delta
> compression to these objects at this stage, so the new term is
> slightly more acceptable to the Grammar Police but is also just
> as correct.

Boo. I _like_ "deltifying". Sure, it's probably not in the dictionary,
but that's how languages change: saying "delta compressing" all the time
will get awkward, so people invent a new word using existing rules to
explain a common phenomenon.

Anyway, if you want to please the Grammar Police, should it not be
"Delta-compressing"?  "Delta" is not an adverb here, but rather the
phrase acts as a compound verb (i.e., the two words work in place of a
single verb). Although "Delta-compressing objects" just looks stupid.

-Peff

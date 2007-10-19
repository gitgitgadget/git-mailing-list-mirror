From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
	objects'
Date: Thu, 18 Oct 2007 22:25:29 -0400
Message-ID: <20071019022529.GA8298@coredump.intra.peff.net>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <47181430.2080907@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihYW-0000eR-44
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763297AbXJSCZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763030AbXJSCZc
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:25:32 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3318 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758959AbXJSCZc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:25:32 -0400
Received: (qmail 7622 invoked by uid 111); 19 Oct 2007 02:25:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 22:25:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 22:25:29 -0400
Content-Disposition: inline
In-Reply-To: <47181430.2080907@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61607>

On Fri, Oct 19, 2007 at 03:19:28PM +1300, Sam Vilain wrote:

> This is not very considerate to non-native speakers, though, who might
> not grasp the neogolism.
> 
> Perhaps just "compressing" if it gets awkward.

I would have thought it would be easier for non-native speakers, since
it has a precise meaning which I assumed we defined in a glossary (but
now I see that we don't, though that can be corrected). But of course,
I'm a native speaker (and AIUI, so are you), so perhaps we should wait
for somebody else to comment.

But I do agree that making sense to non-native speakers should be a
priority when phrasing things like this.

-Peff

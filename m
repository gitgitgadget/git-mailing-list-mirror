From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Tue, 1 Mar 2011 17:01:45 -0500
Message-ID: <20110301220144.GC23945@sigill.intra.peff.net>
References: <20110225133056.GA1026@sigill.intra.peff.net>
 <4D6A6056.20201@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 23:01:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuXdT-0004Ji-T4
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 23:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab1CAWBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 17:01:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51087 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755643Ab1CAWBf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 17:01:35 -0500
Received: (qmail 10874 invoked by uid 111); 1 Mar 2011 22:01:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 22:01:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 17:01:45 -0500
Content-Disposition: inline
In-Reply-To: <4D6A6056.20201@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168263>

On Sun, Feb 27, 2011 at 03:31:50PM +0100, Michael J Gruber wrote:

> > So your commit template looks like:
> > 
> >   subject
> > 
> >   commit message body
> >   ---
> >   notes data
> > 
> >   # usual template stuff
> > 
> I can haz tis wiz "format-patch --notes-behind-triple-dash"?

Yeah, I think that would be a nice 2/2 to this series. From past
threads, it seems that it is not as trivial as one would like, but I can
take a look.

-Peff

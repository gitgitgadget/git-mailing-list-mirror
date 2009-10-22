From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/fetch-options.txt: order options
 alphabetically
Date: Thu, 22 Oct 2009 07:25:26 -0400
Message-ID: <20091022112526.GA7005@coredump.intra.peff.net>
References: <87eiow1pey.fsf@jondo.cante.net>
 <7vpr8g32ht.fsf@alter.siamese.dyndns.org>
 <7vhbts3285.fsf@alter.siamese.dyndns.org>
 <20091022192152.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 13:26:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0vnX-0001kL-Mh
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 13:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbZJVLZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 07:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753613AbZJVLZ3
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 07:25:29 -0400
Received: from peff.net ([208.65.91.99]:60967 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494AbZJVLZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 07:25:28 -0400
Received: (qmail 24926 invoked by uid 107); 22 Oct 2009 11:29:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 22 Oct 2009 07:29:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Oct 2009 07:25:26 -0400
Content-Disposition: inline
In-Reply-To: <20091022192152.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131019>

On Thu, Oct 22, 2009 at 07:21:52PM +0900, Nanako Shiraishi wrote:

> > Ah, in your defense ;-) I think you looked only at git-fetch.txt without
> > checking where else this file is included.  Then the patch certainly is
> > understandable.  It would probably make git-fetch.{1,html} easier to scan,
> > while making things not worse for git-pull.{1,html}
> 
> Can't we introduce subsections in the OPTIONS section to 
> group them together, like this (sorry, not a patch)?

Yes, that was my first thought when reading this thread, too (sorry, no
patch here, either. I need to sleep and then get on a plane).

-Peff

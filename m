From: Jeff King <peff@peff.net>
Subject: Re: Rebase & Trailing Whitespace
Date: Thu, 1 Sep 2011 17:26:18 -0400
Message-ID: <20110901212618.GB16308@sigill.intra.peff.net>
References: <CAE1pOi0rY4kRR4rvEdFhzzTgfhUczHMX=H5_9+o5aHnv4vTadw@mail.gmail.com>
 <20110901023127.GB31838@sigill.intra.peff.net>
 <29267EE41F9343E68AAAE2C33AA40E1A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Sep 01 23:26:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzEmI-0004lD-E3
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 23:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758038Ab1IAV0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 17:26:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49811
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757996Ab1IAV0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 17:26:20 -0400
Received: (qmail 24557 invoked by uid 107); 1 Sep 2011 21:27:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Sep 2011 17:27:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2011 17:26:18 -0400
Content-Disposition: inline
In-Reply-To: <29267EE41F9343E68AAAE2C33AA40E1A@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180573>

On Thu, Sep 01, 2011 at 10:00:38PM +0100, Philip Oakley wrote:

> >[1] If you don't remember the empty tree sha1, you can always derive it
> >   with:
> >
> >       git hash-object -t tree /dev/null
> >
> 
> I've added this tip to the
> https://git.wiki.kernel.org/index.php/Aliases page

Thanks. By itself, I think many readers would ask "why would I want the
empty tree, so I threw in a few examples of use on the wiki, too.

-Peff

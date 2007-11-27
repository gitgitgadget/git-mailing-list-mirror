From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:59:42 -0500
Message-ID: <20071127015942.GM14735@spearce.org>
References: <200711252248.27904.jnareb@gmail.com> <20071127014804.GJ14735@spearce.org> <7vd4twe9mn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 03:00:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwpk5-0000se-K4
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 03:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbXK0B7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 20:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753344AbXK0B7r
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 20:59:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43956 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbXK0B7q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 20:59:46 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IwpjZ-0004Lm-FM; Mon, 26 Nov 2007 20:59:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C63A120FBAE; Mon, 26 Nov 2007 20:59:42 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vd4twe9mn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66159>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > All of the above is written with 20/20 hindsight and all that.
> >
> > Looking back (and knowing myself well) I think the only item I
> > would have gotten right if I had written Git from scratch is the
> > first one above (the tree entry ordering).  I probably would have
> > done something equally "as bad" as what we have today for all of
> > the others...
> 
> ... not to mention countless others you would get wrong that you did not
> list in the above, as the current git got them right ;-)

Indeed.

Which is why nobody is looking to rewrite Git from scratch.

Except myself and a few other nuts who want a pure Java
implementation for Eclipse plugins.  :-)

-- 
Shawn.

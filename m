From: Jeff King <peff@peff.net>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 15:12:01 -0400
Message-ID: <20070927191201.GA31807@sigill.intra.peff.net>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com> <20070927185707.GC12427@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Kelvie Wong <kelvie@ieee.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 21:12:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaymA-0002OH-CK
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757349AbXI0TLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756823AbXI0TLt
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:11:49 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3977 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757335AbXI0TLs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:11:48 -0400
Received: (qmail 2757 invoked by uid 111); 27 Sep 2007 19:11:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 27 Sep 2007 15:11:47 -0400
Received: (qmail 31878 invoked by uid 1000); 27 Sep 2007 19:12:01 -0000
Content-Disposition: inline
In-Reply-To: <20070927185707.GC12427@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59315>

On Thu, Sep 27, 2007 at 08:57:07PM +0200, Pierre Habouzit wrote:

>   Which tool are you using ? kdiff3 ? I've noticed that it often fails
> miserably, or worse, create bad merges silentely with it.
> 
>   And as none of the other merge tool that are supported are able to
> either do 3way merges, or have a decent UI (that definitely seems to be
> exclusive features) I've given up on git-mergetool (and to be fair, it
> sucks, because it could be _sooo_ useful sometimes).

Huh? I use xxdiff all the time, and it works fine.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Mon, 22 Oct 2007 02:59:48 -0400
Message-ID: <20071022065948.GB2737@coredump.intra.peff.net>
References: <20071022063222.GS14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 09:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjrHM-0006cC-D9
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 09:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbXJVG7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 02:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbXJVG7w
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 02:59:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1613 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbXJVG7v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 02:59:51 -0400
Received: (qmail 16895 invoked by uid 111); 22 Oct 2007 06:59:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 22 Oct 2007 02:59:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2007 02:59:48 -0400
Content-Disposition: inline
In-Reply-To: <20071022063222.GS14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61961>

On Mon, Oct 22, 2007 at 02:32:22AM -0400, Shawn O. Pearce wrote:

> * jk/terse-fetch (Fri Oct 19 03:40:57 2007 -0400) 62 commits
>  - park
>  - git-fetch: mega-terse fetch output
>  ... db/fetch-pack begins here ...
> 
> Much discussion on the list about this topic.  I think we may have
> come to an agreement about what the output should look like, but
> this topic doesn't implement that output format.  Someone needs to
> either update this topic or rewrite it.  Starting from Jeff King's
> patch makes things a lot easier.

I will eventually get around to rewriting this (it seems the list
comments have died down), but it is much more interesting to play with
Linus' rename stuff tonight. :) If somebody else wants to take a stab,
please go ahead.

-Peff

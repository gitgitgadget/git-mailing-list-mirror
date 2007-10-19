From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-pack: respect '+' on wildcard refspecs
Date: Fri, 19 Oct 2007 09:43:39 -0400
Message-ID: <20071019134339.GA21852@coredump.intra.peff.net>
References: <20071019090400.GA8944@coredump.intra.peff.net> <449c10960710190510y3af3ffa2ydb9ae4a01b5d480c@mail.gmail.com> <20071019122755.GA17002@coredump.intra.peff.net> <449c10960710190638j5823b19dl903ae369965e884e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Dan McGee <dan@archlinux.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 15:43:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iis8n-0002cs-Hu
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 15:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbXJSNnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 09:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753377AbXJSNnm
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 09:43:42 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1940 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752981AbXJSNnm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 09:43:42 -0400
Received: (qmail 12972 invoked by uid 111); 19 Oct 2007 13:43:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Oct 2007 09:43:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2007 09:43:39 -0400
Content-Disposition: inline
In-Reply-To: <449c10960710190638j5823b19dl903ae369965e884e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61709>

On Fri, Oct 19, 2007 at 08:38:06AM -0500, Dan McGee wrote:

> origin(junio)/master: 58ba4f6
> origin(junio)/next: fe96ee67ec5840
> spearce/master: 7840ce6cb24a9d
> spearce/next: 2fe5433b416f0df
> 
> Can you let me know what commit you based the patch off of? I'm at
> work for the next 8 hours or so, so I can't look in to this a whole
> lot until tonight.

It is based on Shawn's next, 2fe5433b. Are you sure you're not doing
something silly like executing an older version of git that is in your
PATH?

-Peff

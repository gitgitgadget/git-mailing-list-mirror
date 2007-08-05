From: Jeff King <peff@peff.net>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 05:46:48 -0400
Message-ID: <20070805094648.GA15676@coredump.intra.peff.net>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804120243.GB9716@coredump.intra.peff.net> <85tzrfh3yg.fsf@lola.goethe.zz> <20070805092115.GA12507@coredump.intra.peff.net> <85myx6ba8n.fsf@lola.goethe.zz> <20070805093232.GC12507@coredump.intra.peff.net> <85fy2yb9jn.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 11:46:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHchJ-0006tj-4x
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 11:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbXHEJqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 05:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753039AbXHEJqu
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 05:46:50 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1347 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162AbXHEJqu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 05:46:50 -0400
Received: (qmail 16203 invoked from network); 5 Aug 2007 09:46:53 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 09:46:53 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 05:46:48 -0400
Content-Disposition: inline
In-Reply-To: <85fy2yb9jn.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54978>

On Sun, Aug 05, 2007 at 11:44:12AM +0200, David Kastrup wrote:

> Well, one problem is that there simply _is_ no part of the
> documentation where such an explanation would have a place.  It does
> [...]
> Hm.  Probably the usermanual is the best option in the current scheme
> of things.

I'm not too familiar with the usermanual, it having come about long
after I started with git. But I wonder if a subsection on "refs" under
the "Git internals" section might make sense.

-Peff

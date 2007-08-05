From: Jeff King <peff@peff.net>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 05:32:32 -0400
Message-ID: <20070805093232.GC12507@coredump.intra.peff.net>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804120243.GB9716@coredump.intra.peff.net> <85tzrfh3yg.fsf@lola.goethe.zz> <20070805092115.GA12507@coredump.intra.peff.net> <85myx6ba8n.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 11:32:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHcTV-0004C5-TO
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 11:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbXHEJcf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 05:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbXHEJce
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 05:32:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4955 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbXHEJce (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 05:32:34 -0400
Received: (qmail 15595 invoked from network); 5 Aug 2007 09:32:37 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 09:32:37 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 05:32:32 -0400
Content-Disposition: inline
In-Reply-To: <85myx6ba8n.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54973>

On Sun, Aug 05, 2007 at 11:29:12AM +0200, David Kastrup wrote:

> The main question is why I can't find this explained in this manner in
> the documentation.  Are you going to put it in yourself, or should I
> attempt doing it?

I guess because nobody complained it wasn't there before. :) Some of the
information is a bit under-the-hood for most end-users, but obviously in
your case the lack of information was creating confusion about the
terms.

Why don't you take a stab at updating the documentation (since you are
the one who knows which parts were confusing you), and I will be more
than happy to help with making sure the changes are accurate.

-Peff

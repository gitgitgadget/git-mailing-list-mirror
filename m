From: Jeff King <peff@peff.net>
Subject: Re: Feedback outside of the user survey
Date: Thu, 16 Oct 2008 06:28:35 -0400
Message-ID: <20081016102835.GC20762@sigill.intra.peff.net>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 12:30:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqQ7D-0002Su-CS
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 12:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbYJPK2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 06:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753527AbYJPK2i
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 06:28:38 -0400
Received: from peff.net ([208.65.91.99]:2657 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193AbYJPK2i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 06:28:38 -0400
Received: (qmail 6325 invoked by uid 111); 16 Oct 2008 10:28:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 16 Oct 2008 06:28:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2008 06:28:35 -0400
Content-Disposition: inline
In-Reply-To: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98364>

On Thu, Oct 16, 2008 at 12:19:36PM +0200, Richard Hartmann wrote:

> 1) A table/An overview along the lines of "So, you are used to
> foo and that is how you do it in git."
> For example "What is the equivalent of svn co" (yes, that is an
> easy one ;). This should not be limited to things git can do.

How about:

  Git - SVN Crash Course
  http://git.or.cz/course/svn.html

> 2) A use case repository. "So you want to merge two
> branches", etc. This would be a good place to explain the
> different ways git offers to do stuff, as well.

How about:

  Git User's Manual
  http://www.kernel.org/pub/software/scm/git/docs/user-manual.html

(though I do think a user-contributed "recipe" database might be useful.
Maybe such a thing even exists already and I don't know about it).

> 3) A tutorial. It does not even have to be as sophisticated
> as vimtutor. A simple text file specifying steps to do stuff
> would be enough.

How about:

  The Git Tutorial
  http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html

Is there something about these that doesn't meet your criteria? Or did
you not know about them (in which case, maybe we need to be more
prominently pointing to them)?

-Peff

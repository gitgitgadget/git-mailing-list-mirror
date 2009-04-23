From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Thu, 23 Apr 2009 16:16:36 -0400
Message-ID: <20090423201636.GD3056@coredump.intra.peff.net>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 22:18:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx5N9-0004ur-AE
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 22:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbZDWUQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 16:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbZDWUQk
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 16:16:40 -0400
Received: from peff.net ([208.65.91.99]:52576 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbZDWUQj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 16:16:39 -0400
Received: (qmail 24735 invoked by uid 107); 23 Apr 2009 20:16:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 23 Apr 2009 16:16:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Apr 2009 16:16:36 -0400
Content-Disposition: inline
In-Reply-To: <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117379>

On Thu, Apr 23, 2009 at 01:37:05PM -0500, Michael Witten wrote:

> Everyone talks about "before one has the conceptual foundation
> necessary to understand". Well, here's an idea: The git documentation
> should start with the concepts!
> 
> Why don't the docs start out defining blobs and trees and the object
> database and references into that database? The reason everything is
> so confusing is that the understanding is brushed under the tutorial
> rug. People need to learn how to think before they can effectively
> learn to start doing.

I agree with you, but not everyone does (and you can find prior debates
in the list archives). The user-manual is pretty "top down". There are
some "bottom-up" resources available, but I haven't seen one pointed to
as "definitive". I think it might actually be nice for there to be a
parallel to the user manual that follows the bottom-up approach, and
people could read the one that appeals most to them (or if they have a
lot of time on their hands, read both and hopefully it makes sense in
the middle ;) ).

But we would need somebody to volunteer to write it. I would be happy to
help out, but I'm too short on time at the moment to be the driving
force.

-Peff

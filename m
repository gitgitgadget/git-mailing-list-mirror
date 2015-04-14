From: Jeff King <peff@peff.net>
Subject: Re: About the "git merge" tee-shirt
Date: Mon, 13 Apr 2015 21:05:05 -0400
Message-ID: <20150414010505.GE3684@peff.net>
References: <vpqr3rnoiq8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 14 03:04:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhpHU-0002lM-BX
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 03:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066AbbDNBEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 21:04:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:45148 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752124AbbDNBEn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 21:04:43 -0400
Received: (qmail 1120 invoked by uid 102); 14 Apr 2015 01:04:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Apr 2015 20:04:42 -0500
Received: (qmail 3816 invoked by uid 1000); 14 Apr 2015 01:05:05 -0000
Content-Disposition: inline
In-Reply-To: <vpqr3rnoiq8.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267105>

On Mon, Apr 13, 2015 at 10:50:55PM +0200, Matthieu Moy wrote:

> For those of you who weren't at the Git Merge conference last week, we
> goot a tee-shirt with this drawing:
> [...]

Oops, you made me realize that I forgot to grab a t-shirt. :)

I'm going to see if we had leftovers (which I guess we should, since
there should have been one per attendee). If you attended but did not
get one, let me know and I'll see if it's possible to get one shipped.

> Initially, I thought the circles represented Git contributors, and links
> represented people contributing to the same parts of the codebase. But
> looking at the output of "shortlog -s", I can't find a correspondance
> with the tee-shirt. My second guess is that they represent directories.
> But even then, I can't find which of the tee-shirt's circles represents
> which directory, and the count doesn't match.
> 
> Does anybody have a better explanation? Or is it just a random drawing
> to say "Git is bigger than it used to be"?

I believe it is "gource"[1] output from 2005 and 2015, tweaked by a
graphic designer to make it look nicer.

I do like the design, but it's probably not the most meaningful
representation of git's growth. It is showing that the tree has grown,
but I think it is much more interesting how the number of contributors
has grown (or the number of users!). Unfortunately, exponential graphs
are not as interesting to look at. :)

-Peff

[1] https://github.com/acaudwell/Gource

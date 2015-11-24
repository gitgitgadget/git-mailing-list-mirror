From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2015, #03; Fri, 20)
Date: Tue, 24 Nov 2015 17:06:26 -0500
Message-ID: <20151124220626.GA8842@sigill.intra.peff.net>
References: <20151120140937.GA17079@sigill.intra.peff.net>
 <20151124220410.GA5030@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Nov 24 23:06:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1LjO-0006cm-Ad
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 23:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbbKXWGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 17:06:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:33471 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753826AbbKXWG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 17:06:29 -0500
Received: (qmail 25950 invoked by uid 102); 24 Nov 2015 22:06:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 16:06:29 -0600
Received: (qmail 18925 invoked by uid 107); 24 Nov 2015 22:06:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 17:06:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 17:06:26 -0500
Content-Disposition: inline
In-Reply-To: <20151124220410.GA5030@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281637>

On Wed, Nov 25, 2015 at 12:04:10AM +0200, Max Kirillov wrote:

> On Fri, Nov 20, 2015 at 09:09:37AM -0500, Jeff King wrote:
> > * mk/blame-first-parent (2015-11-20) 1 commit
> >  - blame: fix object casting regression
> > 
> >  Regression fix for a topic already in master.
> > 
> >  Will merge to 'next'.
> 
> You mistyped my name in the commit message of 044e0ad679 :)

Argh, sorry about that. I even remember checking it because I wanted to
make sure I got the correct number of l's. But vowels, eh, it's fine. :)

Will fix. Thanks for catching it.

-Peff

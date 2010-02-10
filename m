From: Jeff King <peff@peff.net>
Subject: Re: A Visual Git Reference
Date: Wed, 10 Feb 2010 00:20:57 -0500
Message-ID: <20100210052057.GE28526@coredump.intra.peff.net>
References: <ca433831002081134m698f531bwa22f0474db0cdcb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 06:22:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf527-0001Fn-2a
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 06:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985Ab0BJFU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 00:20:57 -0500
Received: from peff.net ([208.65.91.99]:47678 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab0BJFU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 00:20:56 -0500
Received: (qmail 30116 invoked by uid 107); 10 Feb 2010 05:21:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 10 Feb 2010 00:21:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2010 00:20:57 -0500
Content-Disposition: inline
In-Reply-To: <ca433831002081134m698f531bwa22f0474db0cdcb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139487>

On Mon, Feb 08, 2010 at 02:34:21PM -0500, Mark Lodato wrote:

> I put together a "Visual Git Reference" containing visualizations of
> the most common git commands, for people who prefer to see images over
> text.  It is designed as a reference, not a tutorial, so readers need
> to have some amount of experience before the page will become useful.
> 
> URL: http://marklodato.github.com/visual-git-guide/
> Git repo: http://github.com/marklodato/visual-git-guide/
> 
> If you have any feedback or suggestions, please let me know!

This looks really awesome, thanks for doing it (though I'll admit I
threw up in my mouth a little when I saw you did all of the diagrams as
TeX. ;) ).

One of the projects I have wanted to do but never found time for is a
"Git Picture Glossary". I was intending to start with much simpler
concepts, like how the various object types relate, what a ref is, how a
symref differs, what a detached HEAD is, etc. And then move on to "here
is what happens when you branch", "here is what happens when you merge",
etc. Sort of like "Git for Computer Scientists", but organized as a
glossary, with each entry starting off with "to understand this, you
first need to understand entries X and Y", with links.

And it seems like what you have done is more or less the same thing,
except you skipped all of the really basic entries and went straight to
the action-oriented ones.

-Peff

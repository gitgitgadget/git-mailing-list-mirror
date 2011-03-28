From: Jeff King <peff@peff.net>
Subject: Re: GSoC questions
Date: Mon, 28 Mar 2011 10:35:06 -0400
Message-ID: <20110328143506.GC14763@sigill.intra.peff.net>
References: <AANLkTinTM8hQpcahGgDyB4UJvGbdN0xyp65wL5PDQGKa@mail.gmail.com>
 <20110328001152.GA11294@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexandru Sutii <sutii.alex@gmail.com>, git@vger.kernel.org,
	libgit2@librelist.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 16:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4DXJ-0005JT-NF
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 16:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab1C1OfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 10:35:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60892
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776Ab1C1OfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 10:35:09 -0400
Received: (qmail 10620 invoked by uid 107); 28 Mar 2011 14:35:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Mar 2011 10:35:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2011 10:35:06 -0400
Content-Disposition: inline
In-Reply-To: <20110328001152.GA11294@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170132>

On Sun, Mar 27, 2011 at 07:11:53PM -0500, Jonathan Nieder wrote:

> The ideas page mentions areas in which libgit2 functionality is
> incomplete --- depending on your interest, you might want to focus on
> one of these (so the project would be to add functionality to libgit2
> as well as using it) or to steer clear of them (to focus on
> functionality libgit2 already has).
> 
> So, to make a long story short: there is something sneaky about us
> presenting this idea, since there is so much room for choice.  As your
> project becomes more precise it should be possible for people on the
> list to give more detailed advice.

Yes. I didn't write those ideas on the idea page, but I do like their
sneakiness. On the ideas I put up, I also tried to be a little bit
vague.

Because I'd really rather see a student not do a proposal based on one
of our ideas as a checklist of things to code. I'd much rather give them
a _problem_, then come up with and implement their own solution,
figuring out the requirements and the best way to go about it
themselves (with hints from the community, of course; none of us works
in a vacuum, and certainly somebody new to the project isn't going to
always know the best way to go about things).

But GSoC (IMHO) is not just about getting code written. It's also about
showing students what it's like to take part in open source projects,
and to see a problem in need of solving and scratch that itch. And from
the project's perspective, hopefully that gets the student addicted to
scratching itches and they keep doing it.

> Another note.  Please feel free to venture beyond projects listed on
> the ideas page.  For example the 2010 ideas page contains some gems:

I very much agree with this. Though I would caution students to talk to
the community a bit before doing a proposal for something out of the
blue. Because often people have tried and failed at something similar
before, and knowing the context helps. So post to the list and say "I am
thinking of doing X. Has anybody done something like it before? What
would be the best way to go about?"

-Peff

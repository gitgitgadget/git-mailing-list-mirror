From: Jeff King <peff@peff.net>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 13:58:01 -0500
Message-ID: <20130218185801.GA25673@sigill.intra.peff.net>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 19:58:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Vv4-0003De-Dn
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 19:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264Ab3BRS6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 13:58:05 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52114 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828Ab3BRS6D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 13:58:03 -0500
Received: (qmail 23110 invoked by uid 107); 18 Feb 2013 18:59:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 13:59:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 13:58:01 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216495>

On Tue, Feb 19, 2013 at 12:14:19AM +0530, Ramkumar Ramachandra wrote:

> I'll be frank here.  I think the main reason for a student to stick
> around is to see more of his code hit `master`.  I think it is
> absolutely essential to get students constantly post iteration after
> iteration on the list. It would be nice to get them connected with 2~3
> people in the community who will follow their progress and pitch in
> everytime they post an iteration.  It might also make sense to stage
> their work in the main tree (a gsoc/ namespace?), so we can just
> checkout to their branch to demo what they've done.

I agree. One of the main problems with GSoC projects is that the student
goes away and works for a while, and then at the end does not
necessarily have something mergeable. That is not how regular
contributors work. They post works in progress, get feedback, and
iterate on ideas. They break work into easily digestable and reviewable
chunks. So maybe the mentors should be focusing more on that than on
actual code problems.

> Also, we need more projects that will scratch everyday itches.  A
> collection of related tiny features might not be a bad idea.  Often,
> we risk erring on the side of too-big-for-one-summer when it comes to
> specifying projects.  What's the harm of including something estimated
> to take 80% of a summer?

I very much agree with you here. One problem is that those smaller
projects often do not sound as grand or as interesting, and so students
do not propose them. We have to work with the applicants we get.

> On a related note, I don't like our Wiki.  It's down half the time,
> and it's very badly maintained.  I want to write content for our Wiki
> from the comfort of my editor, with version control aiding me.  And I
> can't stand archaic WikiText.

Agreed on all of those points. Putting the Wiki on GitHub fixes that.
But it means contributors need to have a GitHub account. On the other
hand, I think kernel.org wiki contributors need an account these days?
And GitHub is putting some active effort into finding and killing spammy
accounts, which might keep wiki spam down (I do not pay too much
attention to those efforts, but on kernel.org, it is mostly up to the
Git community to do it ourselves).

-Peff

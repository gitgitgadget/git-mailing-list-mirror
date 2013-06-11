From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 16:33:03 -0400
Message-ID: <20130611203303.GA14907@sigill.intra.peff.net>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
 <51B6AA7F.1060505@alum.mit.edu>
 <7v38sod1kn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 22:33:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmVFl-0000wm-9O
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 22:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290Ab3FKUdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 16:33:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:58282 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757446Ab3FKUdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 16:33:08 -0400
Received: (qmail 6306 invoked by uid 102); 11 Jun 2013 20:33:59 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Jun 2013 15:33:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jun 2013 16:33:03 -0400
Content-Disposition: inline
In-Reply-To: <7v38sod1kn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227513>

On Tue, Jun 11, 2013 at 10:00:56AM -0700, Junio C Hamano wrote:

> > * Accept reviewers' comments gratefully and take them very seriously.
> > Show that you appreciate the help by giving the reviewer the benefit of
> > the doubt.  If, after careful consideration, you find that you cannot
> > agree with a reviewer's suggestion, explain your reasoning carefully
> > without taking or giving offense, and seek compromise.
> 
> In short, the only acceptable response to review comments are "You
> are right. Here is a reroll", or "I think your suggestion will miss
> these cases which I wanted to cover and that is why I did it this
> way". There may be other small variants of the above two, but I
> think I can agree with the general principle.
> 
> In cases, there are two or more equally valid approaches to solving
> a problem.  I do not think I had to accept (or reject) many "it can
> be done better in different ways and this perhaps is not the best
> one" (or "it could be argued that it is correct") borderline topics
> in the recent past, but I suspect that "a disagreement is healthy"
> has to be accompanied by how disagreements that do not resolve
> themselves are resolved (I think I've heard somewhere that some
> communities break ties in favor of reviewers, for example).

I more or less agree with what both of you have said above. The "ties
goes to reviewers" thing I would be very wary of, at least as a hard
rule. We do not (and do not want to) put any restrictions on who is
allowed to do review. That sometimes results in unhelpful or even wrong
reviews by new people, but those reviews are a stepping stone to being a
more experienced and capable reviewer.

Most of the time such reviews are resolved by other community members
joining the discussion and coming to some agreement, but not always.
And that is not even getting into the cases where long-time experienced
reviewers are simply wrong or misguided, or the issue is legitimately a
difficult tradeoff to consider, and the discussion ends in a stalemate.

And I think that is where the benevolent dictator role comes in. They
weigh not just the points made in the discussion (or a summary of it),
but also use their judgement on who is making comments (how many people,
the utility of their past comments) and other factors (other things
happening in the project, being conservative because of recent mistakes
made, etc). They may break such a tie by applying or rejecting, even by
putting off a decision to revisit later (which is a de facto reject, of
course).

So there are no hard rules, and this is not a democracy[1]. For the most
part the community runs itself in an open and collective fashion, and
the dictator's job is easy; but ultimately, he or she is in charge of
what gets applied and what doesn't. Rules like "break ties in favor of
reviewers" are just a guideline for the dictator to use in making
decisions.

I do not think any of that is news to you, but I think the point needs
to be made, as it applies to any concrete rules.

-Peff

[1] Note that I think a benevolent dictator is a _terrible_ way to run a
    real government, but it works in an open source project. I think the
    difference is that dictatorship is open to abuse of power. In the
    real world, there is a lot of power to abuse, and it is hard for
    people to opt out of it. In the open source world, there is not that
    much power, and if there is a bad dictator everyone can go somewhere
    else (another project, or even a fork). So while a dictator _can_
    play favorites, or start deciding which patches to take based on
    what they had for breakfast, there is a real incentive to remain
    fair and reasonable.

From: Jeff King <peff@peff.net>
Subject: Git and GSoC 2013
Date: Wed, 27 Mar 2013 14:34:11 -0400
Message-ID: <20130327183410.GA26066@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 19:34:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKvBN-0004dt-T7
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab3C0SeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:34:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41760 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905Ab3C0SeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 14:34:16 -0400
Received: (qmail 16789 invoked by uid 107); 27 Mar 2013 18:36:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Mar 2013 14:36:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2013 14:34:11 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219298>

There was a big thread about a month ago on whether Git should do Google
Summer of Code this year[1].

Some people seemed in favor, and some not. The deadline for git to apply
to GSoC is March 29 (this Friday) at 19:00 UTC. I am willing to act as
the admin again if list consensus is that we should do it. But my point
in sending this email is not to say "yes, we should definitely apply";
it is to give people on both sides one more chance to make their points
and come to a conclusion before the deadline. I.e., I did not want the
decision to be made for us because people were not aware of the
deadline.

In my opinion, a lot of the issues come down to project selection; one
thing that seemed to come up in the thread was that projects are often
not scoped appropriately to get fully merged by the end of the summer. I
think the much smaller projects done by Matthieu Moy's summer students
in past years have been very successful _because_ they are of a size
much closer to patch series done by normal contributors. I realize that
the GSoC time-frame is longer, but I think it's again a matter of
scoping; one large project that tries to merge at the end of the summer
is never going to work. It must be broken down into a series of
reviewable steps, and those steps need to be reviewed and merged
throughout the summer, just like contributions from regular
contributors.

Hand in hand with that, I think we need to treat students more like
regular contributors: discussion on-list, patches reviewed and revised
on-list, etc. And all of that happening throughout the summer. Coding is
only part of being involved in open-source, and traditionally the
students have focused on the code and not on the process of interacting
with the community and shepherding their changes through to "master".

Looking over the proposed project page, I am not that excited about any
of them (including ones I have written for past years) as being both
scoped appropriately and interesting/useful for students and for the
project. I think if people want to do GSoC, we really need to make a
commitment to smaller-scoped projects, and to getting students more
involved in the "regular" process of patch submission. The obvious first
step to that is revising the Ideas list to either have smaller projects,
or to break larger ones into more manageable pieces. Unless that
happens, I don't think it's worth applying.

And if we do apply and get accepted, I think we should look carefully at
the proposals that we select, and be very picky about students and
projects that will fit in the summer scope.

I realize that there is only about 48 hours until the deadline, which is
not much. But I am willing to work on the application materials if
people can agree on a reasonable set of proposed projects[2].

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/216485

[2] I have always hoped for students who would submit their own project
    proposals, independent of anything we suggest. After all, that is
    how things happen naturally in open source; contributors scratch
    their own itches. And that is part of why the ideas I post are often
    vague and try to describe a problem rather than a solution. But in
    all our years of GSoC, I recall very few cases of students proposing
    their own projects, and even fewer of them being successful. So I
    have kind of given up hope that we would get any proposal that is
    not spelled out on our ideas page.

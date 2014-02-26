From: Jeff King <peff@peff.net>
Subject: Re: Git in GSoC 2014
Date: Wed, 26 Feb 2014 05:23:50 -0500
Message-ID: <20140226102350.GB25711@sigill.intra.peff.net>
References: <20140225154158.GA9038@sigill.intra.peff.net>
 <530CCFB0.5050406@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 26 11:24:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIbew-000227-Ij
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 11:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbaBZKYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 05:24:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:57243 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751245AbaBZKXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 05:23:52 -0500
Received: (qmail 8403 invoked by uid 102); 26 Feb 2014 10:23:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Feb 2014 04:23:53 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Feb 2014 05:23:50 -0500
Content-Disposition: inline
In-Reply-To: <530CCFB0.5050406@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242708>

On Tue, Feb 25, 2014 at 06:15:28PM +0100, Michael Haggerty wrote:

> > We didn't discuss earlier whether we would have any specific
> > requirements for students during the proposal period (e.g., having a
> > patch accepted). It would be good to put together rules (or barring any
> > specific requirements, guidelines to help students put together a good
> > proposal) as soon as possible. Suggestions are welcome.
> 
> Requiring students to submit a reasonable patch and follow up on review
> comments seems like it would be a good way to filter out non-serious
> students.  (I hesitate to require that the patch be accepted because it
> can take quite a while for a patch to make it to master, despite of the
> student's efforts.)

Yeah, I think the early stages of "accepted" are somewhat vague.
Probably "patch is in next" is a reasonable definition, but I do not
think we even need to bind ourselves so strictly. Humans read, evaluate,
and rank the proposals, so we can use our judgement about whether a
patch looks promising.

> Does anybody know whether other organizations have had good experience
> with criteria like that?  Does it chase *all* the applicants away?

If you haven't seen it, there is a guide written by mentors and admins
from past years:

 http://en.flossmanuals.net/GSoCMentoring/

I did not see this particular subject covered, though I seem to recall
it has come up on the mentor list in past years. I can't search the
archive now, because they haven't re-added me for this year yet, but
I'll do so once I have access.

I think I'm in favor. It seems like a minimal hurdle to overcome, and I
think everybody is more than happy to coach new contributors through the
process.

> If we wanted to impose such a hurdle, then we would definitely have to
> make up a list of microprojects so that the students don't have to start
> from nothing.  I imagine it shouldn't be too hard to find tiny projects
> estimated at 10-30 minutes of actual work, which should be plenty
> difficult for a student who also has to figure out how to check out the
> code, conform to our coding standards, run the unit tests, create a
> patch submission, etc.

The hack-a-thon bug list I posted earlier has some potential points of
interest, but I need to update it to reflect the work done that day (a
lot of that is trickling in to me for initial comments, and then I'll
direct them to the list, but I'm a bit behind on dealing with it).

> If the reaction is positive to this idea then I volunteer to spend
> several hours tomorrow looking for microprojects, and I suggest other
> core developers do so as well.  They should presumably be submitted as
> patches to the ideas repository [1].

Yes, though I think it makes sense to put them on a separate page. We
should probably write up some notes for students, too: how to get in
touch with us, what do we expect of them in the pre-proposal period,
what would we expect in terms of communication and day-to-day workflow
during the summer, etc.

-Peff

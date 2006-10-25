X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Junio C Hamano <junkio@cox.net>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 14:08:20 -0700
Message-ID: <7v3b9cnlx7.fsf@assigned-by-dhcp.cox.net>
References: <453536AE.6060601@utoronto.ca>
	<200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca>
	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
	<vpq4ptz2uh8.fsf@ecrins.imag.fr>
	<453DAC87.8050203@research.canon.com.au>
	<Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
	<Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
	<Pine.LNX.4.64.0610240812410.3962@g5.osdl.org>
	<Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu>
	<20061025084810.GA26618@coredump.intra.peff.net>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: sea.gmane.org 1161810540 17663 80.91.229.2 (25 Oct 2006 21:09:00 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Wed, 25 Oct 2006 21:09:00 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	David Rientjes <rientjes@cs.washington.edu>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 25 23:08:54 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcpzN-0000nI-LE
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 25 Oct 2006 23:08:42 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GcpzF-0003D8-D7; Wed, 25 Oct 2006 22:08:34 +0100
Received: from fed1rmmtao08.cox.net ([68.230.241.31])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <junkio@cox.net>) id 1Gcpz4-0003Ca-Vh
	for bazaar-ng@lists.canonical.com; Wed, 25 Oct 2006 22:08:23 +0100
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
	(InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
	id <20061025210821.GFXR22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
	Wed, 25 Oct 2006 17:08:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp id el831V0131kojtg0000000
	Wed, 25 Oct 2006 17:08:04 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20061025084810.GA26618@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 25 Oct 2006 04:48:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Original-Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:18787 gmane.comp.version-control.git:30101
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30101>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 24, 2006 at 01:12:52PM -0700, David Rientjes wrote:
>
>> And I would prefer the opposite because we're talking about git.  As an 
>> information manager, it should be seen and not heard.  Nobody is going to 
>> spend their time to become a git or CVS or perforce expert.  As an 
>> individual primarily interested in development, I should not be required 
>> to learn command lines for dozens of different git-specific commands to do 
>> my job quickly and effectively.  I would opt for a much more simpler 
>> approach and deal with shell scripting for many of these commands because 
>> I'm familiar with them and I can pipe any command with the options I 
>> already know and have used before to any other command.
>
> I don't understand how converting shell scripts to C has any impact
> whatsoever on the usage of git. The plumbing shell scripts didn't go
> away; you can still call them and they behave identically.
>
> Is there some specific change in functionality that you're lamenting?

That's also I wondered, but I also can understand where David is
coming from, and I agree with him to a certain degree.

When I learned git, I learned a lot from trying to piece my own
plumbing together, since there weren't much Porcelain to speak
of back then.  Then we had many usability enhancements before
the 1.0 release to add Porcelainish done as shell scripts.

This had two positive effects, aside from adding usability.
Interested people had more shell scripts to learn from.  The
scripts were easy to adjust to feature requests from the list,
and as we learned from user experience based on these scripts it
was definitely quicker to codify the best current practice
workflow in them than if they were written in C.  It would have
taken us a lot more effort to add "git commit -o paths" vs "git
commit -i paths" if it were already converted to C, for example.
This continued and our Porcelainish scripts matured quickly.

Then 1.3 series started to move some of the mature ones into C.
As many people already have pointed out, being written in C and
not doing pipe() has two advantages (better portability to
platforms with awkward pipe support and one less process usually
mean better performance).  git-log family with path limiting had
a real boost in performance because the path limiting can be
done in the revision traversal side not diff-tree that used to
be on the downstream side of the pipe.  So this in overall was a
right thing to do.

One thing we lost during the process, however, is a ready access
to the pool of "sample scripts" when people would want to
scratch their own itches.  Linus's original tutorial talked
about "this pattern of pipe is so useful that we have a three
liner shell script wrapper that is called git-foo", and
interested people can easily look at how the plumbing commands
fit together.

The plumbing is still there, and I and people who already know
git would still script around git-rev-list when we need to (by
the way, scripting around git-log is a wrong thing to do -- it
is for human consumption and scripting should be done with
plumbing).  But when we rewrote mature ones in C (and I keep
stressing "mature" because another thing I agree with David is
that shell is definitely easier to futz with), we did not leave
the older shell implementation around as reference.  People
coming to git after 1.3 series certainly do have harder time to
learn how plumbing would fit together than when git old-timers
learned it, if that is the area they are interested in, as
opposed to just using git as a revision tracking system.

We could probably do two things to address this issue:

 - Create examples/ hierarchy in the source tree to house these
   historical implementations as a reference material, or an
   entirely different branch or repository to house them.

 - Learn the itches David and other people have, that the
   current git Porcelain-ish does not scratch well, and enrich
   Documentation/technical with real-world working scripts built
   around plumbing.






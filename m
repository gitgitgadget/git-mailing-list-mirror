From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Wed, 12 Jun 2013 08:27:23 -0400
Message-ID: <20130612122723.GA26281@thunk.org>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
 <51B6AA7F.1060505@alum.mit.edu>
 <7v38sod1kn.fsf@alter.siamese.dyndns.org>
 <20130611203303.GA14907@sigill.intra.peff.net>
 <7va9mw9xkb.fsf@alter.siamese.dyndns.org>
 <CAMP44s10TVF9-uT5OtCLXBKrrXAspYnHM+go1zvu6ocMZwN14A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 14:27:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umk9I-0006bR-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 14:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998Ab3FLM1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 08:27:32 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:57223 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab3FLM1b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 08:27:31 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1UmkDF-0001e8-DJ; Wed, 12 Jun 2013 12:31:41 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id F0B3B580E3B; Wed, 12 Jun 2013 08:27:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s10TVF9-uT5OtCLXBKrrXAspYnHM+go1zvu6ocMZwN14A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227605>

On Tue, Jun 11, 2013 at 06:19:23PM -0500, Felipe Contreras wrote:
> Fair? Fairness requires to judge each action without biases, nor
> double standards. In the case of an open source community it requires
> you to listen to the arguments before dismissing them, and consider
> the patches before dropping them on the floor. Fairness requires no
> favoritism.

At least in development communities that *I* run, if someone were as
rude to me as you have been in some previous exchanges to Junio, I
would have set the bozo bit a long time ago and reviewed your
submissions with a very jaudiced eye, and treated your non-technical
arguments with same amount of attention as I give madmen and drunkards
in the street.  Junio has given you *far* more latitude than I would
have.

Keep in mind, the demands for respect go in both directions, and in
non-technical matters about style and "good taste", at the end of the
day the maintainer does get to have the final say, because he or she
is the one who applies the patches or accepts the pull request.  So if
the maintainer says something like, "maintaining ABI backwards
compatibility for libext2fs (or for kernel syscalls) is critically
important", that's not up to you.  Sending me abusive e-mails about
how I'm not listening to your arguments isn't going to help.  You can
try to change my mind with reasoned arguments, but for questions like
that, or what functions do or don't belong in a library, the
maintainer is the benevolent dictator.

Things a very different for things like "this change causes a 30%
performance regression in a particular workload".  For those sorts of
technical questions, a much more collaborative discussion style is
important.  But for questions of what is and isn't "good taste", it's
not a good idea to reply to a maintainer's e-mail with "that's your
opinion" over and over again.  For things like that it *IS* his (or
her) opinion, and if you can't live with it, you'll save a lot of
bandwidth on the mailing list by moving on to some other project.

Regards,

					- Ted

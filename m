From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Mon, 26 Jan 2009 17:58:35 -0500
Message-ID: <20090126225835.GB10118@mit.edu>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com> <20090121170434.GA21727@hashpling.org> <81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com> <20090122142258.GA2316@hashpling.org> <81bfc67a0901230716i166bfc4chd9a5c0990b0cd3b6@mail.gmail.com> <7vwscmue5z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caleb Cushing <xenoterracide@gmail.com>,
	Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 03:08:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRdNN-0006Q5-ND
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 03:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbZA0CHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 21:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbZA0CHD
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 21:07:03 -0500
Received: from THUNK.ORG ([69.25.196.29]:33942 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbZA0CHB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 21:07:01 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1LRdLu-0008O9-4z; Mon, 26 Jan 2009 21:06:58 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1LRaPb-0002g6-AO; Mon, 26 Jan 2009 17:58:35 -0500
Content-Disposition: inline
In-Reply-To: <7vwscmue5z.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107299>

On Fri, Jan 23, 2009 at 09:26:32AM -0800, Junio C Hamano wrote:
> Caleb Cushing <xenoterracide@gmail.com> writes:
> 
> > so does my patch satisfy now? what's it take to get it included in the
> > next version of git?
> 
> I do not use mergetool myself so I generally do not pay attention to
> patches on this tool, but I would want to pick up ones that people
> involved in mergetool discussion can agree to be good patches.
> 
> There are a few mergetool updates in flight from various authors.  How
> does your submission compare with others' in both form/presentation and
> clarity of logic (remember, I am not keeping track)?

I was the original author of mergetool, and for a while I was the
person that was reviewing and managing the mergetool patches for
Junio.  Unfortunately, in the last couple of months I just haven't had
the time keep up with the various mergetool proposed patch updates.

So maybe it's time for me to hand it off to someone who has the time
and interest in continuing to hack mergetool, and has the necessary
"good taste" and such that Junio would be willing to trust that person
to be the git mergetool patch wrangler?

							- Ted

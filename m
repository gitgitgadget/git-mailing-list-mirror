From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 14:50:04 +0200
Message-ID: <87egzwtthf.fsf@fencepost.gnu.org>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<536a83097302f_76ff7a52ec6c@nysa.notmuch>
	<xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
	<536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
	<xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
	<536ad9601b73b_3caaa612ecdc@nysa.notmuch>
	<CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
	<xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
	<CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
	<87mweku2pt.fsf@fencepost.gnu.org>
	<CAGK7Mr5ezbTVyq2wr7kYWjab6V1srrYwkqSGjo1GuPnkSuGWTQ@mail.gmail.com>
	<87iop8u1km.fsf@fencepost.gnu.org>
	<CAGK7Mr4N5L+jRE0ykBHvopgGv1x4iNXAK+_94R5KhBxHHqMYmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 14:50:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkYdb-0002iC-Qv
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 14:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbaENMuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 08:50:19 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:44282 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaENMuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 08:50:17 -0400
Received: from localhost ([127.0.0.1]:43323 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WkYdU-00088n-St; Wed, 14 May 2014 08:50:17 -0400
Received: by lola (Postfix, from userid 1000)
	id D7E53E0D4F; Wed, 14 May 2014 14:50:04 +0200 (CEST)
In-Reply-To: <CAGK7Mr4N5L+jRE0ykBHvopgGv1x4iNXAK+_94R5KhBxHHqMYmA@mail.gmail.com>
	(Philippe Vaucher's message of "Wed, 14 May 2014 14:11:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248911>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

>> Basically you have to write in a manner "if a seedy stranger gave me
>> that code on a street corner, I would have no problem checking it
>> in".  In practice, the shortcuts offering themselves through civil
>> behavior and mutual trust get a lot more work done.
>
> My point was more that it's very hard to produce high quality commits
> without social interaction with others explaining what you missed,
> stuffs you overlooked, etc.

You are overgeneralizing.  You are assuming that it's easier for
everybody to interact with humans rather than the Tao of Computing.

> And there B issues quickly isolate you.

Unless you were isolated to start with.

> Anyway, I think we are speaking about different things. All I'm saying
> is that humans are social creatures and that thinking you can
> contribute to projects ran by humans without according a high
> importance to social behaviors (like Felipe thinks) is not possible.

You are assuming that "according a high importance to social behaviors"
is all that it takes for anybody.  Do you tell the beggar on the next
street corner that "according a high importance to earning millions"
would be all that would be necessary for him to afford anything to drink
that he'd like?

> Threads like this are proof that while technical quality might be
> important for the short term, social behaviors is impossible to ignore
> in the long term.

Not really.

> Both are very important to be an appreciated contributor, or to
> contribute at all in the long term.

The one thing where social behavior comes in is noticing who tends to be
running free software projects.

There is the mythical "scratching one's itch" theory, but it does not
fit the bill.  Those people who invest enough time into a project's
progress to make a fundamental difference tend to do it at the cost of
not having any worthwhile amount of time left actually _using_ the
product.

People mainly working on music software create very little music
themselves, people mainly working on text processing software do not
write many texts themselves, people writing high-performance operating
systems have very little use for high-performance operating systems
themselves.

All of this might have started at one time as scratching their own itch,
but once their contributions become significant, it's almost always the
itches of others they are scratching, and continue to scratch, feeling
responsible for them due to the skills they have been not as much
blessed or cursed but entrusted with.

And programming and social skills tend to be packaged separately.  So
not everybody is gifted with being able to contribute _gracefully_.

-- 
David Kastrup

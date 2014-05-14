From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Thu, 15 May 2014 00:12:24 +0200
Message-ID: <87egzwrovr.fsf@fencepost.gnu.org>
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
	<87egzwtthf.fsf@fencepost.gnu.org>
	<CAGK7Mr6XTxpeJLSqL8PZMS8w+YCqxLrC5wX-dg4BdEaW3QAYTA@mail.gmail.com>
	<87a9aktqms.fsf@fencepost.gnu.org>
	<CAGK7Mr7jhpizoHuA9NDnyNPy_rr8_R0m8-hCFO3CDn2Hbh3_pQ@mail.gmail.com>
	<5373cfb744982_57c3bfb300a0@nysa.notmuch>
	<87mwekrsap.fsf@fencepost.gnu.org>
	<5373e2af9ae58_592416ad2f892@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 00:12:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhPa-0003qD-N2
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbaENWM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:12:27 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:57126 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaENWM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:12:26 -0400
Received: from localhost ([127.0.0.1]:56167 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WkhPV-0001QS-8k; Wed, 14 May 2014 18:12:25 -0400
Received: by lola (Postfix, from userid 1000)
	id E5669E0BD9; Thu, 15 May 2014 00:12:24 +0200 (CEST)
In-Reply-To: <5373e2af9ae58_592416ad2f892@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 14 May 2014 16:39:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249005>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> David Kastrup wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Philippe Vaucher wrote:
>> 
>> [...]
>> 
>> >> > Do you feel Felipe is in control of what you label bad behavior?  Do you
>> >> > feel you are in control over how you react to his behavior?
>> >> 
>> >> I feel that Felipe cannot control this (or decided not to),
>> >
>> > I am pretty much in control of my behavior. Those who know me
>> > personally know that I *never* get angry.
>> 
>> You are missing the point.  The point is not what effect your behavior
>> has on you but what it has on others.
>
> If me saying "I do not believe in God" has a negative effect on Mark,
> your answer seems to be "do not tell Mark the truth".

Shouting "your God is an imaginary shithead" every time you see Mark and
asking everybody in the room "Isn't it right that Mark's God is an
imaginary shithead?  Can anybody here testify having seen him?" whenever
anybody is there, and occasionally calling him and others on the phone
when you have nothing else to do and tell him that you consider his God
an imaginary shithead and him a gullible fool to believe otherwise...

Do you really think that's the way you are going to earn people's
respect?  By prouding yourself on having seen through Mark's purported
stupidity and pointing it out to everybody?

> But if Mark was a member of an open source project, I do have an
> option and I'd rather tell it like it is.

And everybody else, of course, is wrong about it.  And only you are
right.  All you need to do is to be as obnoxious as you can manage, and
you'll win everyone over to your side.

Don't kid yourself: you are doing this entire sad spectacle only to
satisfy your own self-righteousness, just to be able to tell yourself
"all those people working on Git with the exception of myself are
pitiable fools and/or bad persons letting Junio pull the wool over their
eyes".

You've made your point.  People don't agree with it.  Repeating your
point over and over will not change that.

> If Mark has a problem with that, I can always avoid Mark, or just
> leave the project (say if Mark was the maintainer).
>
> In both cases Mark is wrong. I do understand that most people would
> rather comprimise their beliefs in order to win penguing points. I'm
> not that way.

No, you rather compromise your standing in order to win your beliefs.
Take them.  They are yours.  Nobody else wants them.  Even if there
would have been merit in them originally, after revomiting them a dozen
times on people's laps they just want the stench to go away.

> If I can't speak my mind in an open source project where I'm
> contributing my time *for free*, I do not want to be part of that
> project. It's the project that's wrong, not me, and it's the project
> that looses, not me.

Well, you are a sore winner for sure.

-- 
David Kastrup

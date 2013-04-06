From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Sat, 6 Apr 2013 10:01:04 -0600
Message-ID: <CAMP44s1_5wq6XSMZ64wRMcohLB_oA0s1VWqmJ1iBGnV_nCijXQ@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
	<CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
	<EF2F8946-4F60-4659-9215-6C21C9641AB0@quendi.de>
	<CAMP44s3qAPJtNVsb4gvYd1PunN4c-crxpVJc0K9520eiBO8iwA@mail.gmail.com>
	<BA2657F2-708B-434E-87D2-D6371806E2D3@quendi.de>
	<CAMP44s10HGpfz=r1m8QRFY4V+rAOkiRaerW1T=vHz2YpbBH6Zg@mail.gmail.com>
	<CDBF6E3BB68D4385B19C53A447186556@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, gitifyhg@googlegroups.com
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:35:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWWs-0001D7-W1
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423251Ab3DFQBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 12:01:17 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:46948 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423233Ab3DFQBH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 12:01:07 -0400
Received: by mail-la0-f41.google.com with SMTP id eg20so219321lab.14
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=A7FoWLD65ltYscWF3fj4RpQ5xzESllpdP6QkpJtIics=;
        b=LW0Z+egK+90z6NTrQXv8OtLsh9S60fUlpB9Fvu3nuGkl4RTFUI6CJHT+u/pi+fmXyg
         nprrcSmiOLhSywvn17pUmVk09Lwzvy4EdCybnKzDVv0wnYJepcwZJvCJUQjbmlWBwwaU
         PLP34KEeThIw46NXqkRCpNrSfutzmeaURkqTn6AZsKzIpz3u60ZjD1tCe34UqlB839LC
         c8tTLnKN4et7hMVDXY/0FNTueM0PEA74qzAm6V9/VNo82HXBQuEbJKEEilLZafc9DdHX
         VudU1AH2bxQNF7ctXCeVe5JRxlDKeGu4gihyE/WhU8WE4xoaFEl4lhooOGksEgcl7Xd8
         IKKg==
X-Received: by 10.112.145.8 with SMTP id sq8mr8517727lbb.55.1365264064811;
 Sat, 06 Apr 2013 09:01:04 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sat, 6 Apr 2013 09:01:04 -0700 (PDT)
In-Reply-To: <CDBF6E3BB68D4385B19C53A447186556@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220218>

On Sat, Apr 6, 2013 at 8:09 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> Sent: Saturday, April 06, 2013 1:45 AM

>> Ultimately this is not about people, this is about the code.
>
>
> In the case of helper functions this is not the case.
>
> The question would be better framed:
> "Does this, or that, helper function make users (people) feel helped, or
> frustrated (or somewhere in limbo)?".

And that question is ultimately answered by code.

> I've called IT help desks and often felt frustrated, and some times I've got
> one of the good girls/guys who worked with me to improve my situation (often
> despite official policies). I get back to those folks (even if they
> 'failed').

That is not an issue when you don't have a situation that needs
support, when everything just works. Having one issue with bad support
is better than having 5 issues with good support.

> It's not a binary black/white issue when real users need help. It's no good
> keeping with the faith (e.g. the Git ideal, the coders ideal, ..) when the
> users (a mixed group) environmental doctine differs.

And neither Max or Jed are users, so this doesn't apply to them.

As for actual users, well show me, which remote-hg users have had bad support?

https://github.com/felipec/git/issues

>>    A sensible person that is not emotionally attached to any code,
>
>  [I'm thinking users here, they are emotionally attached to their original
> problem, and sense doesn't come into it]

That's irrelevant, a sensible developer would maximize the amount of
issues that do **not** hit the users.

>>  would simply look at the code,
>
> Unfortunately, even for reasonable coders, looking at the code isn't usually
> the case because of lack of time, unfamiliarity with the code, extent of the
> code, availablity of the code (they may be simply running a
> packaged/compiled 'app'), this is not that likely to happen. We should be
> thankful when folk do look.

If this sensible developer doesn't have time to look at remote-hg
code, he has less time to make a possibly inferior alternative work on
par or better. Thus a sensible developer would either look at
remote-hg code, or do not develop.

> It's hard enough to get "good" bug reports from fellow coders (they are only
> human / no more human than us) that tell us what _we_ want to know (rather
> than what _they_ remember, or was important to them). ;-)

Nobody is asking for that.

> I don't use Hg, but as I read the discussion, there are incomaptibilities
> between Git, and Hg. Thus neither helper can ever be perfect. The winners
> will be those who solve a user need with enough documentation and error
> capture to make them (their user group) feel happy. At the moment it looks
> like the discussion is stratifying into various "it worked for me" camps,
> each with their own problem children repos that won't respond to parental
> advice, even with a --force from social services.

I don't think so. The discussion has been about hypothetical, not real
users. The one person that did claim was hit by a bug, had no evidence
for it nor cared, so it hardly matters. The rest is in pondering such
as if the user does this and that, and somebody else in the team does
that, and then the user does this, and the team has that policy, they
might end in a bit of a kerfuffle. Not something that has _actually_
happened.

And I'm confident that with time it will be shown that in terms of
real issues, remote-hg would have less, and be fixed faster.

Cheers.

-- 
Felipe Contreras

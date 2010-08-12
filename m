From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Proposal for new Git Wiki admin
Date: Thu, 12 Aug 2010 19:15:07 +0300
Message-ID: <AANLkTikBwCCsSHWNaGkFTZ=1DFL7QCkKGWJxan04PQTa@mail.gmail.com>
References: <20100810162602.GG3921@kytes>
	<m3y6ce2kdz.fsf@localhost.localdomain>
	<20100811050056.GA3715@kytes>
	<4C62494A.2030805@drmicha.warpmail.net>
	<AANLkTimuHzC_brw2bBDTvc=-Cj+70AMFEj7nzspW5mGq@mail.gmail.com>
	<20100811134640.GA10888@kytes>
	<AANLkTimQsNj-3M=y7Dop4brB8U-8vVPqgD0+zBX5R6FG@mail.gmail.com>
	<20100812165647.38ee2809@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Thu Aug 12 18:15:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjaR3-0000n7-Jp
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 18:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933876Ab0HLQPL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 12:15:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51320 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735Ab0HLQPJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 12:15:09 -0400
Received: by bwz3 with SMTP id 3so1018682bwz.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LWgf5zzGQLJpa2gmEbPyJhFJo9uuyihsONcjTalVRuU=;
        b=QSbFDEND1ZWuhRy3mZkoMv2AyHOuqiJ3g2hpFv413nDqdUGYksvttButdzyz7nkSsh
         RIHPG9mimiAzt/TQRsq2cN6ekc57Wq4j8VcHGgYXUo2JsfrbkbvRCwLBvXwCVPRcJ00T
         pvAKRxvIRMGe5ZkM6mltchIIn8hKMWGNFEfHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jGKKWH/Fgpkx2fPyHi5E4oNHBCBSgASZRknEjelo1RKlvy6Gn/q0l7f31o9LAQ8FoX
         /W4Kf7wYkO8/A22QyIcjpknvi6sMP1CXbzp+IWShrXDAxD1HZZeSKdqNHoily8NDUmCO
         oB+JkL1qXrkX3Z/uXDp4+lFw0CrMea2pMrnH0=
Received: by 10.204.84.17 with SMTP id h17mr219015bkl.101.1281629707503; Thu,
 12 Aug 2010 09:15:07 -0700 (PDT)
Received: by 10.204.21.200 with HTTP; Thu, 12 Aug 2010 09:15:07 -0700 (PDT)
In-Reply-To: <20100812165647.38ee2809@jk.gs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153384>

On Thu, Aug 12, 2010 at 5:56 PM, Jan Kr=C3=BCger <jk@jk.gs> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> IMO having more than one admin is only part o the solution, see:
>> https://git.wiki.kernel.org/index.php/WikiIdeas
>
> Here are my comments on that. For the sake of archive-friendliness, I=
'm
> referring to this version of it:
> https://git.wiki.kernel.org/index.php?title=3DWikiIdeas&oldid=3D8996
>
> (Why am I commenting here instead of on the wiki? Because I think the=
re
> are few things worse than a wiki for discussing something.)

I disagree, and the whole wikipedia would too; it's a different kind
of communication.

> | Up to now, good faithed users have been blocked immediately, and
> | permanently, without a warning. Instead of doing that, a policy lik=
e
> | wikipedia's one should be followed:
>
> I'd like to point out that this drastically increases the
> administration effort. For example, issued warnings have to be tracke=
d.

I disagree. It's very small overhead, the warning is in the wiki, it's
_very_ easy to find by *anyone*.

Anyway, I'm willing to help patrolling, so I can take that overhead.

> Also, this is serious overhead for obvious spammers, and different
> people will have different perspectives on what constitutes an obviou=
s
> spammer.

I disagree, spotting spam is extremely easy by a human.

> To the best of anyone's knowledge, only one false positive has
> ever occurred until now.

Of course, because the evidence for the contrary has been deleted.

> I think this approach is overkill. I would
> suggest, if technically possible, automatically showing banned users =
a
> notice that asks them to contact admins via some channel or another i=
f
> they believe that they have been wrongly blocked.

There's already a channel for that, the wiki, and it has a significant
advantage over other channels; everyone can see it, and it never goes
away.

> | Some people might have been wrongly blocked. By changing the blocki=
ng
> | policy the old blocks might not apply and warnings should be issued=
 instead.
>
> Same reasoning. Also, the deletion logs look very much like only
> obvious spammers got blocked.

The deletion logs don't show anything besides the usernames.

> | Allow users to see deleted pages
> | This would allow transparency into the action of the admins.
>
> I don't oppose that, but it raises technical issues. Deleted pages
> should not be indexed by search engines, because doing so would defea=
t
> the purpose of removing spammy links. I don't know whether MediaWiki
> implements that; I do know that it tells robots not to index old
> versions of pages.

All right. But that's just another argument to avoid deleting them.

> | Up to now, good faithed users have been blocked immediately, and
> | permanently, without a warning. Instead of doing that, a policy lik=
e
> | wikipedia's one should be followed:
>
> Yes, but why use a wiki for communication if you can simply use e-mai=
l
> instead?

Because:
 a) the e-mail is not available anywhere (as user pages are apparently
frowned upon)
 b) e-mails have a limited destination, and thus cannot be viewed by
the rest of the community, plus the admin can ignore them, or get
misrepresented as spam, etc.

> To me, all this "using wiki pages for communication and
> discussions" is a classic case of "when you have a hammer"...

Yeap, except the hammer is the email.

> Also, the proposal about patrol groups seems to be about solving the
> same problem, though I don't know how well it works for dealing with
> problematic edits in real time. Okay, I guess we'd need a *lot* more
> admins for that anyway.

Not true, considering the amount of people blocked (12), probably one
admin can deal with warnings plus bocks. But hey, if you don't think
so, I'm willing to take that responsibility completely.

> All in all, I think it would be completely sufficient to find a way t=
o
> let users help with reporting spam, and to add a couple of admins...
> and perhaps notify users when blocking them. I don't think anything
> else is necessary or useful.

I still would like to see someone revisit old blocks, but for the
future, yeah, that would be enough.

>> > [...] Personally, I don't think
>> > you should work with Johannes, atleast in the state in which you'r=
e
>> > in right now. Please disagree only if you feel that Jakub or I wil=
l
>> > do a bad job.
>>
>> It's not Johannes' wiki; it's the community's. And I'm certain that =
I
>> can work just fine with Jakub as I've done it in the past.
>
> Nobody claimed that you wouldn't be able to work with Jakub, there wa=
s
> only doubt that you might have difficulty working with Johannes (in a
> way that leaves both of you in a healthy state of mind).

Imagine the two situations when dealing with spam:
 a) obvious spam: I delete the page and block
 b) non-obvious spam: I delete the page, and warn the user

How might that clash with Johannes?

--=20
=46elipe Contreras

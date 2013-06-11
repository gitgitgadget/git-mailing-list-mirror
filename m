From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 00:16:03 -0500
Message-ID: <CAMP44s3ZSTZQ5juNnwRTC_tSSe68wvjvOi=MBwu3g9pTbPBNqA@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B5D9A1.1080900@ensimag.fr>
	<vpqhah6hxjm.fsf@anie.imag.fr>
	<robbat2-20130610T162316-152176477Z@orbis-terrarum.net>
	<7vzjuxj21b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 07:16:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmGwR-0000Q1-5h
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 07:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab3FKFQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 01:16:07 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:62838 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab3FKFQF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 01:16:05 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so4589569lab.11
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 22:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QREhKgi45BdXnjmK229QUq5Io2u6K58gA1Aql1Obr+M=;
        b=TCRbPkIJP4YaigQSj/tt4+OODc0QqQ4eYcOl3QpojIwje0ToaMEEb6UKqpF0KUE5Nm
         A1d5cV380MNwEFKMhrFyIWYKBAcMh89unGD4MMzfTQspDg+e5B4nQw4fXC0ZQ8aeWARE
         OZul5a38jfWTPZ9x3h/pYd1n/TPaPM+DFBYUpZv1Qqxwvv44Lf9k5dLweSLJP5aowm+I
         pTw4ypQ/GHbJjXe1Mkk/z25ajIFqVGrd2bbpR+UAWHNN5tu+vq/qKsj1VNsLR4ZuOzu/
         4jMNRstnBC1O7WATr4PVQG1o93tQL2mTQNclTQpNVO5Y9MHt0zaN6bmt5ZybUZj981pl
         xB2A==
X-Received: by 10.112.16.163 with SMTP id h3mr7908111lbd.85.1370927763378;
 Mon, 10 Jun 2013 22:16:03 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 22:16:03 -0700 (PDT)
In-Reply-To: <7vzjuxj21b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227417>

On Mon, Jun 10, 2013 at 12:42 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> "Robin H. Johnson" <robbat2@gentoo.org> writes:
>
>> On Mon, Jun 10, 2013 at 04:04:29PM +0200,  Matthieu Moy wrote:
>>> C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:
>>>
>>> > Le 10/06/2013 15:28, Ramkumar Ramachandra a =C3=A9crit :
>>> >> 0. You do not take offense, no matter what.  If someone attacks =
you
>>> >> irrationally, you do not respond.  This is a public mailing list=
, and
>>> >> we are all rational people: the attacker has already humiliated
>>> >> herself in public, and everyone can see that.
>>> >
>>> > "Herself"?
>>> > Typo I guess :)
>>>
>>> Not necessarily. It's quite common in english to use "she" when the
>>> gender is not known.
>> Could you please use "themself" instead?
>
> I think "himself or herself" is the politically correct form ;-)
>
> But more seriously.
>
> The intent behind the document might be a noble one, but I am afraid
> that the text is too broad and vague and does not address the real
> issue to be of practical use.
>
> Taking one bullet point from the top for example:
>
>     0. You do not take offense, no matter what.  If someone attacks
>     you irrationally, you do not respond.  This is a public mailing
>     list, and we are all rational people: the attacker has already
>     humiliated herself in public, and everyone can see that.
>
> What does saying "we are all rational people" help when "the
> attacker" poses a risk to destroy the community?  What does "we are
> all rational people" even mean in this sentence?

Science shows that humans are in fact, not rational people. It's
simply one of our countless limitations. We acknowledge we have
physical limitations, but we forget our mental limitations.

We should aim to be rational people, yes, but we are not.

> It does not address the real cause of flamewars---why do rational
> people feel the need to respond when an irrational comment is made,
> e.g. when a reasonable review comments were responded not with
> either "Yeah, you are right, thanks." or "Not really, because you
> missed this case, I think..."  but with nitpicks with immaterial
> details or repetition without justification that takes account that
> the reviewer is in disagreement and there must be some reason behind
> it, i.e. a poisonous behaviour?

=46irst of all, you should not refer to it as "poisonous behavior".
Maybe you think it's poisonous, maybe everyone else in the mailing
list agrees it's poisonous, but talk doesn't make things real,
otherwise there were a lot of real witches in the past.

You should refer to it as 'what could be considered poisonous
behavior'. That is accurate.

Calling it "poisonous behavior" at best can be considered a logical
fallacy, and at worst could even be described as a poisonous comment
itself.

> I suspect it mostly has to do with the desire to make sure that
> bystanders do not get an impression that the one who speaks last
> gives the conclusion to the discussion, so stating "The attacker
> being the one who speaks last in the discussion does not mean the
> conclusion is his." explicitly might be one way to make it more
> practically useful by alleviating the urge to respond, instead of
> saying "no matter what".
>
> I dunno.

I think we all know at some level why flame war arise, as XKCD makes
it comically succinct[1].

If somebody wants to argue for the sake of arguing, they should go to
some forum, or reddit, or something else other than the mailing list.

In the mailing list you should avoid flamewars. If you have identified
a flamewar, don't poke it, and ask for others to do the same; don't
throw lumber unto the flames.

I know you worry that somebody is wrong on the Internet, and you worry
that somebody else might read that, and think the person that is wrong
is actually right. But you cannot fix that. Move on. If the reader is
smart, they'll understand the signal "Don't throw lumber unto the
flames." followed by silence from other members of the community.

Trying to "correct" somebody often sends the wrong signal; you
validate the other person's point of view as something worth arguing
about. If you truly think a flamewar is taking place, resist your urge
to participate in it, and mute it.

Maybe it's not really flamewar, and something important is being
discussed, but you should leave the people that do not think a
flamewar is taking place to argue with each other, and stay out of
that. If you think it's a flamewar, and you comment in it, you are
making it worst, and perhaps turning it into a real flamewar if it
wasn't.

In general; do not participate in a flamewar. Period.

[1] http://xkcd.com/386/

--=20
=46elipe Contreras

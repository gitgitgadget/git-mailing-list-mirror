From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Fri, 17 Sep 2010 09:23:32 +0200
Message-ID: <4C931774.9060808@drmicha.warpmail.net>
References: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de> <20100916125751.163d8691@jk.gs> <4C9204BE.800@drmicha.warpmail.net> <20100916184803.39576fd2@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Stimming <stimming@tuhh.de>, trast@student.ethz.ch,
	avarab@gmail.com, git <git@vger.kernel.org>
To: =?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Fri Sep 17 09:23:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwVID-0003NN-Eq
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 09:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab0IQHX2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 03:23:28 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43526 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788Ab0IQHX1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 03:23:27 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 00E6039E;
	Fri, 17 Sep 2010 03:23:27 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Sep 2010 03:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=GDD9oN6/TMeztEtYVDC0uIFR9U0=; b=bqeRONfCEn8v5kTHpcGnZker64xnP4cezTw/nCIV2T4rToM34pO1aO7YxGDbetb3UL0LPNorRu55yl0I/fPDYJS3bRK+G9mkhKx3xF4gFaO2mZd3DP/A58ts3Ds8GqMjS7ES1FJYMKm50Ve9hok5LVtPNAaCAnAu+dQpGywytng=
X-Sasl-enc: HPZo/0dpL07HC5ylW0m3f3dROHcTUJ0IG2gWgcpv51AN 1284708206
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E8F675E6DBA;
	Fri, 17 Sep 2010 03:23:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <20100916184803.39576fd2@jk.gs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156373>

[snipping most parts to make this shorter]

Jan Kr=C3=BCger venit, vidit, dixit 16.09.2010 18:48:
> Michael J Gruber <git@drmicha.warpmail.net> wrote:
>=20
>>> Translating these terms into German does not change anything about
>>> that. All terms still need to be explained.
>>
>> Absolutely true, and absolutely irrelevant for the decision whether =
to
>> translate these, since they need to be explained in any case.
>=20
> The argument for translating them in the first place was that that
> makes it easier to understand the text. My argument was that the
> translated terms are not more understandable because they still need =
to
> be explained. How is that irrelevant? I consider the original argumen=
t

If it makes no difference then it is irrelevant for the decision. It's
neither pro nor con, other arguments have to be brought up.

>> I really have to oppose this reasoning. Are you seriously suggesting
>> we should not translate the following words as a matter of principle=
?
>=20
> I would indeed keep quite a few of them as they are. But you're
> right, the fact that they would likely be kept as command names just
> makes me feel better about keeping them untranslated; the main reason
> is that I can't find good translations. Let's step through them one
> by one, against my better judgement.

This was not meant as a list to be worked through, but as an argument
that the principle "do not translate command names at all" (i.e. in *no=
*
context) is not viable.

>>> I believe that the English "tag" is a much better metaphor than the
>>> German "Markierung". One use of "tag" refers to a small label that
>>> is attached to, for example, baggage. This is exactly the concept
>>> we have in git. "Markierung" doesn't come close at all to
>>> describing the same concept. Conflicts markers are "Markierungen";
>>> tags are not.
>>
>> That's exactly why I suggested "Marke", see my earlier reply also fo=
r
>> the other terms. It conveys the same multiple metaphorical
>> associations.
>=20
> I disagree. Arguably, the strongest association is
> "Briefmarke" (postage stamp), probably followed by
> "Erkennungsmarke/Markenzeichen" (trademark) and perhaps
> "Plakette" (insignia). None of these reflect what a "tag" is about:
> (more or less) loosely attaching an identifier to a revision, as in t=
he
> case of a baggage tag or a dog tag. What's more, the word "Tag" is

dog tag is Hundemarke. I really think Marke conveys most meanings of
tag, especially those relevant to the meaning of tag in Git context. If
you insist on translating all aspects and connotations of a word then
there is no translation at all.

> already widely used in German version control lingo. For example, the
> German translation of the SVN red book uses it.
>=20
>> You know, there's a reason why translating is a profession. You need
>> to be proficient in both languages, as well as creative. In fact, I
>> don't think the majority of people are proficient enough for that
>> even in their native language (as a translation target), but every
>> native speaker thinks he or she is, of course. (This is a general
>> remark not aimed at anyone specifically.)
>=20
> The whole profession argument has never sat well with me. I know
> hobbyists who have ten times the skills of some professionals. I agre=
e

I talked about "profession", not about hobbyists vs. professionals. And
I don't like it when you turn around my words in my mouth.

> that translating is a nontrivial task, though... and I, personally,
> will not be involved in anything less than a very good translation. I
> have outlined what I perceive as shortcomings in a number of
> suggestions made here. I'll be glad to look at alternative suggestion=
s,
> but so far, for a number of terms, I haven't seen a satisfactory
> alternative to adopting the English ones.
>=20
> (FWIW, I've bounced some of the more controversial of my translations
> off a couple of git users, but also off a graduate of German language
> and literature studies who uses neither git nor English. I'm just
> mentioning that due to your totally-not-aimed-at-anyone remark, thoug=
h;

You can take that for face-value - it was not aimed at anyone, and you
have no reason to claim otherwise.

> I don't think it should actually make any difference.)
>=20
> At any rate, I will stop working on translating git as long as this
> discussion goes on. And, of course, should you guys end up insisting =
on
> bad translations, I'll leave you to writing it that way. Under
> protest. :)

We simply have to decide about a concept, about an approach first, abou=
t
what is "bad" and what is "good" (for the yet to be determined target
audience) as you put it, before flooding the single de.po with
translation pieces without an agreement on a glossary for the main term=
s.

But, given the direction this discussion is taking now, I'm really
pessimistic that this is going to happen. Maybe switching to DE would
help, I dunno.

Michael

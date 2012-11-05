From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Lack of netiquette, was Re: [PATCH v4 00/13] New remote-hg helper
Date: Mon, 05 Nov 2012 10:25:34 +0100
Message-ID: <5097860E.5040607@drmicha.warpmail.net>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com> <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com> <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info> <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com> <5090EFCA.7070606@drmicha.warpmail.net> <20121031102712.GB30879@sigill.intra.peff.net> <alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info> <CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com> <20121031185903.GA1480@elie.Belkin> <CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com> <alpine.DEB.1.00.1210312126080.7256@s15462909.onlinehome-server.info> <bec4d263-b458-4636-9fa6-1c1202416810@email.android.com> <CAMP44s2G2MGuPH-UXfoKNOpx0cuSE87Uz=6B-7H1MzJHf6VMjA@
 mail.gmail.com> <50927D29.3020703@lsrfire.ath.cx> <5093949D.4070509@op5.se> <5093A873.9090701@drmicha.warpmail.net> <CAMP44s0yk3k1awYbJCcReBDEAjMyfHtKH70S7v2ZOJ1u5OcBAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 10:25:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVIwK-0002Zp-7X
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 10:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab2KEJZj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2012 04:25:39 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60541 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761Ab2KEJZi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2012 04:25:38 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 228C5204E7;
	Mon,  5 Nov 2012 04:25:37 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 05 Nov 2012 04:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=cQMPo7Y0j1Z3dC//pv/ks5
	zWEDg=; b=cxiUvSYoiZ1hL95AaRgx7n52qQbjQV4UT4JZGffb6nGvasxHZgpFS2
	/G4La2xYHvystcxVDdOqnR0KXjHfhmRVS2+rVPT8DcgPLi+Faw1M7gtFUiLhk+2G
	7QWeyMv+M26ZRaLamiRmT6hOBcQphyGcycWohpz6sNN4vLj7kSHBQ=
X-Sasl-enc: TqqR/SSPg9TlK17dBo3E4PDbF1KguHN0npXEjfN25kWI 1352107536
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8DD488E04D0;
	Mon,  5 Nov 2012 04:25:35 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAMP44s0yk3k1awYbJCcReBDEAjMyfHtKH70S7v2ZOJ1u5OcBAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209055>

=46elipe Contreras venit, vidit, dixit 02.11.2012 17:09:
> On Fri, Nov 2, 2012 at 12:03 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Andreas Ericsson venit, vidit, dixit 02.11.2012 10:38:
>>> On 11/01/2012 02:46 PM, Ren=C3=A9 Scharfe wrote:
>>>>
>>>> Also, and I'm sure you didn't know that, "Jedem das Seine" (to eac=
h
>>>> his own) was the slogan of the Buchenwald concentration camp.  For
>>>> that reason some (including me) hear the unspoken cynical
>>>> half-sentence "and some people just have to be sent to the gas
>>>> chamber" when someone uses this proverb.
>>>>
>>>
>>> It goes further back than that.
>>>
>>> "Suum cuique pulchrum est" ("To each his own is a beautiful thing")=
 is
>>> a latin phrase said to be used frequently in the roman senate when
>>> senators politely agreed to disagree and let a vote decide the outc=
ome
>>> rather than debating further.
>>>
>>> Please don't let the twisted views of whatever nazi idiot thought i=
t
>>> meant "you may have the wrong faith and therefore deserve to die, s=
o you
>>> shall" pollute it. The original meaning is both poetic and democrat=
ic,
>>> and I firmly believe most people have the original meaning to the f=
ore
>>> of their mind when using it. After all, very few people knowingly q=
uote
>>> nazi concentration camp slogans.
>>>
>>
>> In fact, many German terms and words are "forbidden area" since Nazi
>> times, but I don't think this one carries the same connotation.
>>
>> But that is a side track.
>>
>> Collaboration (and code review is a form of collaboration) requires
>> communication. The linked code of conduct pages describe quite well =
how
>> to ensure a productive environment in which "everyone" feels comfort=
able
>> communicating and collaborating.
>=20
> Yes, but that's assuming we want "everyone" to feel comfortable
> communicating and collaborating.

I put "everyone" in quotes because you can never reach 100%, so
"everyone" means almost everyone.

Undeniably, the answers in this and the other threads show that on the
git mailing list, "everyone" wants "everyone" to feel comfortable
communicating and collaborating.

> I cite again the example of the Linux
> kernel, where certainly not "everyone" feels that way. But somehow

It's a different list with different standards and tone, so it doesn't
really matter for our list. That being said:

> they manage to be perhaps the most successful software project in
> history. And I would argue even more: it's _because_ not everyone
> feels comfortable, it's because ideas and code are criticized freely,
> and because only the ones that do have merit stand. If you are able t=
o
> take criticism, and you are not emotionally and personally attacked t=
o
> your code and your ideas, you would thrive in this environment. If yo=
u
> don't want your precious little baby code to fight against the big
> guys, then you shouldn't send it out to the world.

=46or one thing, contributors on the kernel list are open to technical
arguments, and that includes the arguments of others; just like we are
here. On the other hand, you seem to rebuke "any" (most) technical
argument in harsh words as if it were a personal attack; at least that'=
s
how your answers come across to me (and apparently others). That really
makes it difficult for most of us here to argue with you technically,
which is a pity. That lack of openness for the arguments of others woul=
d
make your life difficult on the kernel list also.

A completely different issue is that of language. You talk German on a
German list and English on an international list. You talk "kernel
English" on the kernel list, which is full of words and phrases you
would never use in a normal social setting where you talk to people in
person; it would be completely unacceptable. Here on the Git list, we
prefer to talk like in a normal, albeit colloquial social setting. If
you're open for advice: just imagine talking to the people here in
person, to colleagues across your desk, and you have a good guideline.

And no, using the same or similar language does not make us the same at
all. Using the same language is the natural prerequisite for successful
communication.

=46elipe, please try to see the efforts many of us are making here in
order to keep you as a contributor, and reward it by accepting the
advice to revise your language: colleague to colleague.

Michael

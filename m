From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Lack of netiquette, was Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 1 Nov 2012 15:34:57 +0100
Message-ID: <CAMP44s0TVQOKc=Ce_k1DTwZHuPUmroOaVMPg4t--bmt=3fDPuQ@mail.gmail.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<20121031102712.GB30879@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
	<CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com>
	<20121031185903.GA1480@elie.Belkin>
	<CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com>
	<alpine.DEB.1.00.1210312126080.7256@s15462909.onlinehome-server.info>
	<bec4d263-b458-4636-9fa6-1c1202416810@email.android.com>
	<CAMP44s2G2MGuPH-UXfoKNOpx0cuSE87Uz=6B-7H1MzJHf6VMjA@mail.gmail.com>
	<50927D29.3020703@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Nov 01 15:35:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTvrU-0000Qa-O1
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 15:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761653Ab2KAOe7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Nov 2012 10:34:59 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44638 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761623Ab2KAOe6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2012 10:34:58 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2584769obb.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SjwQHdLgSkjzMNGU49i4cxcYsqkHUDm8EMTZC/y3c4c=;
        b=h58M6lylvPtFoMHf4PCGUTQt4PaStv8UH5VE3l7AQSoqW5A4v5NTt/+u8+GXqm2RzT
         VbHYbM+WcvehjKotjqCA1f7nzWiOYJOT6cGH0jhYtxCETvxwiqLuIi/WDcpd2D4ValwG
         1GIIoeHdU+vjuJIA2ude7GtPRQa93uFQf6uMEVIE1683Xqq/y04Tch5aMGZE7glVgNN+
         KnumStibHK37+vbeXQ7isBjXLu93MuxO/atmxj05lyx5cCTJxHZUVfRiZsJnSPprJhsC
         iV3SLbLORSPBBx/3VrU/39qpwPu3FBUALBtdty+P/5cUDLjXrKXy+E5mKzaFReQsXz7i
         kqtw==
Received: by 10.60.32.19 with SMTP id e19mr35488384oei.9.1351780497820; Thu,
 01 Nov 2012 07:34:57 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Thu, 1 Nov 2012 07:34:57 -0700 (PDT)
In-Reply-To: <50927D29.3020703@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208877>

On Thu, Nov 1, 2012 at 2:46 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 01.11.2012 03:58, schrieb Felipe Contreras:
>
>> On Thu, Nov 1, 2012 at 2:32 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>>
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>>
>>>> On Wed, 31 Oct 2012, Felipe Contreras wrote:
>>>>
>>>>> It doesn't get any more obvious than that. But to each his own.
>>>>
>>>>
>>>> In my opinion, Jonathan does not deserve any of such condescending
>>>> words.
>>>> But maybe the Git maintainers are okay with such a tone on this li=
st?
>>>
>>>
>>> Agreed, and no.
>>>
>>> We've been hoping we can do without a rigid code of conduct written=
 down
>>> to maintain cordial community focused on technical merits, and inst=
ead
>>> relied on people's common sense, but sense may not be so common,
>>> unfortunately, so we may have to have one.
>>
>>
>> Just for the record, what exactly is the problem with the above?
>>
>> 1) The fact that I say it's obvious
>> 2) The fact that I say everyone is entitled to their own opinions
>
>
> Obviousness is in the eye of the beholder.

Sometimes. Other times things are obviously obvious, not for the
person uttering the words, but for everyone. But I agree that others
would disagree, which is why I followed that sentence to one making
sure that I understand that there's a disagreement.

> This is a fact that I tend to forget just too easily as well.

I didn't.

And even if I did, what is the problem with saying "this is obvious"?

> You probably didn't intend it, but your sentences at the top can be r=
ead
> more like: "This is a logical consequence.  If you don't understand t=
hat,
> your mental capabilities must be lacking.".  That's obviously (ha!) a=
 rude
> thing to say.

People can read things in many ways. If you need to pass every
sentence you write in a *technical* mailing list through a public
relation professional, well, the throughput of such mailing list is
going to suffer.

That being said, I did wonder what must be going through his mind to
not see that as obvious, but I did NOT *say* anything offensive.
Specially because I know people have different perspectives, and the
fact that a perspective doesn't allow you to see something obvious
doesn't say anything about your mental capabilities, only about your
perspectives, biases, or even current mental state. Who knows, maybe
you skipped your coffee.

To assume otherwise is reading too much into things. Read what is
being said, and nothing more. Don't make assumptions.

And a guideline I love from Wikipedia: Always assume *good faith*.
Sometimes, of course, even if you assume good faith things are
offensive. This is not the case here.

> Also, and I'm sure you didn't know that, "Jedem das Seine" (to each h=
is own)
> was the slogan of the Buchenwald concentration camp.

No, I don't know, and frankly, I don't care.

Cultural differences go both ways. You need to assume that whatever
cultural reference you are thinking of, might not be the same for the
other person. Again: assume *good faith*.

And in English, and probably most Latin language countries, "to each
his own" is pretty well understood:

http://en.wiktionary.org/wiki/to_each_his_own

Etymology
A calque of Latin suum cuique, short for suum cuique pulchrum est (=E2=80=
=9Cto
each his own is beautiful=E2=80=9D).

Proverb
to each his own
Every person is entitled to his or her personal preferences and tastes.
I would never want my bathroom decorated in chartreuse and turquoise,
but to each his own, I suppose.

Synonyms
there's no accounting for taste

> For that reason some
> (including me) hear the unspoken cynical half-sentence "and some peop=
le just
> have to be sent to the gas chamber" when someone uses this proverb.

I never said anything of the sort, and assuming otherwise is a mistake.

If you always assume bad faith you will inevitably get offended by
things that were never meant to be offensive. It's not a good
guideline.

> No accusations intended, just trying to answer your question from my =
point
> of view.

Thanks, but I think if others are thinking along the same lines, this
is not good. Following the guideline of always assuming good faith
makes it easier for people to communicate, and people not getting hurt
when in fact no offense was intended, which it turns out to be most of
the time.

Cheers.

--=20
=46elipe Contreras

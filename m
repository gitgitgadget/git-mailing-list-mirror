From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Lack of netiquette, was Re: [PATCH v4 00/13] New remote-hg helper
Date: Fri, 2 Nov 2012 17:09:11 +0100
Message-ID: <CAMP44s0yk3k1awYbJCcReBDEAjMyfHtKH70S7v2ZOJ1u5OcBAw@mail.gmail.com>
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
	<5093949D.4070509@op5.se>
	<5093A873.9090701@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 17:09:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJoE-0001dd-1k
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 17:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179Ab2KBQJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2012 12:09:13 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55363 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab2KBQJM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2012 12:09:12 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3752118obb.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=p9U2n4JxiAfIiEFJZWRO6PGtGisWPmru+0AxxgasMMs=;
        b=FQ9kaHzur20q8qcjgoToP2a/4ipBqFMaM0ccrfW0cMZJHzKDDAXXKFjH6cjpLB50ub
         W7vxUEepTg8OShIdpvKLrwyzxe3g79vLNAtNXcRHLPxaObfJROg0XrNakh4w+StjlhkO
         EtCBO7q8FWSoK8kmCG7f8x3tIV9D+UKpH+8Ehx2t5kXN0THvHjnY1mkAgHHMedRVmge6
         RtIzoSg3FqfhPfwKMhMKq9E9huYX4csR92XCMIPLnDtwURQMdOjAtxgHFI13K41+oHxX
         urDL7xTOSqWoeE2+6l1HmBNpaon6hg90oiGi8mdsKsrwGn7wTZW8uKmdEFQuKZ7CPUzl
         077A==
Received: by 10.60.12.233 with SMTP id b9mr1759376oec.95.1351872551648; Fri,
 02 Nov 2012 09:09:11 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 09:09:11 -0700 (PDT)
In-Reply-To: <5093A873.9090701@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208958>

On Fri, Nov 2, 2012 at 12:03 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Andreas Ericsson venit, vidit, dixit 02.11.2012 10:38:
>> On 11/01/2012 02:46 PM, Ren=C3=A9 Scharfe wrote:
>>>
>>> Also, and I'm sure you didn't know that, "Jedem das Seine" (to each
>>> his own) was the slogan of the Buchenwald concentration camp.  For
>>> that reason some (including me) hear the unspoken cynical
>>> half-sentence "and some people just have to be sent to the gas
>>> chamber" when someone uses this proverb.
>>>
>>
>> It goes further back than that.
>>
>> "Suum cuique pulchrum est" ("To each his own is a beautiful thing") =
is
>> a latin phrase said to be used frequently in the roman senate when
>> senators politely agreed to disagree and let a vote decide the outco=
me
>> rather than debating further.
>>
>> Please don't let the twisted views of whatever nazi idiot thought it
>> meant "you may have the wrong faith and therefore deserve to die, so=
 you
>> shall" pollute it. The original meaning is both poetic and democrati=
c,
>> and I firmly believe most people have the original meaning to the fo=
re
>> of their mind when using it. After all, very few people knowingly qu=
ote
>> nazi concentration camp slogans.
>>
>
> In fact, many German terms and words are "forbidden area" since Nazi
> times, but I don't think this one carries the same connotation.
>
> But that is a side track.
>
> Collaboration (and code review is a form of collaboration) requires
> communication. The linked code of conduct pages describe quite well h=
ow
> to ensure a productive environment in which "everyone" feels comforta=
ble
> communicating and collaborating.

Yes, but that's assuming we want "everyone" to feel comfortable
communicating and collaborating. I cite again the example of the Linux
kernel, where certainly not "everyone" feels that way. But somehow
they manage to be perhaps the most successful software project in
history. And I would argue even more: it's _because_ not everyone
feels comfortable, it's because ideas and code are criticized freely,
and because only the ones that do have merit stand. If you are able to
take criticism, and you are not emotionally and personally attacked to
your code and your ideas, you would thrive in this environment. If you
don't want your precious little baby code to fight against the big
guys, then you shouldn't send it out to the world.

Junio mentioned "technical merit", and I believe for that open and
_honest_ communication is more important than making "everyone" feel
comfortable.

And FWIW I don't feel comfortable expressing my opinion any more,
because even if I criticize ideas and code on a *technical* basis, I'm
assumed to be referencing Nazism and whatnot without any regards of
what my original intentions were, or what I actually said, and
definitely not assuming good faith. And when asked for clarification
of what exactly that I said was offensive, I get no clear answer.

The dangers of "everyone" following the same style of communication,
and making "everyone" feel comfortable, is that "everyone" ends up
being the same kind of people, and the ones that don't fit the
definition of "everyone" feel like outsiders, or outright leave the
project. And you end up with an homogeneous group of people incapable
of criticizing each other honestly (on a technical basis), whether
it's because of lack of a different perspective, or unwillingness to
speak openly, or difficulty in finding the right polite words. I've
seen many projects fall into this, and erode with time, since nothing
important actually happens, and real deep issues within the code or
the community get ignored.

Anyway, I've yet to find what was actually wrong in the words I said.

Cheers.

--=20
=46elipe Contreras

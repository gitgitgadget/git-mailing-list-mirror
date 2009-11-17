From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Tue, 17 Nov 2009 21:06:25 +0900
Message-ID: <20091117210625.6117@nanako3.lavabit.com>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
	<7vy6n065os.fsf@alter.siamese.dyndns.org>
	<7vr5ss64e5.fsf@alter.siamese.dyndns.org>
	<94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>
	<7vy6n02mrk.fsf@alter.siamese.dyndns.org>
	<94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>
	<20091025111438.GA11252@progeny.tock>
	<94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
	<4AFBF18E.7070906@drmicha.warpmail.net>
	<20091114060600.6117@nanako3.lavabit.com>
	<94a0d4530911161452xe82858el322a1985341bf13c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 13:06:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAMpV-0002bE-1z
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 13:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbZKQMG1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 07:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755209AbZKQMG1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 07:06:27 -0500
Received: from karen.lavabit.com ([72.249.41.33]:37642 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754940AbZKQMG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 07:06:26 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 59E5411B972;
	Tue, 17 Nov 2009 06:06:32 -0600 (CST)
Received: from 9694.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id X8BA6F8DFFOU; Tue, 17 Nov 2009 06:06:32 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Ls/UzCV/tjJj6SPektNodYDyP94kC/8oJdQ8P7O/OtdxBDs1Zvmzbr3Nrbt7A8f0Tin/3mRGbGMUXhaZ9fAQj2FtEsS1UNjOavh19DN98bvRVXsUKEL7vZl+pckaseC9pnftVFCI2+5QnbKc0U7dq1C71+mvlA18XqT+mWaGGRk=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <94a0d4530911161452xe82858el322a1985341bf13c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133087>

Quoting Felipe Contreras <felipe.contreras@gmail.com>

> On Fri, Nov 13, 2009 at 11:06 PM, Nanako Shiraishi <nanako3@lavabit.c=
om> wrote:
>> ... I don't
>> think Felipe seriously wants to change them to --gogo vs --dance, bu=
t
>> if he made a more constructive proposal, instead of making such a
>> comment whose intended effect is only to annoy people, we may see
>> an improved UI at the end.  Proposing "--index-only" vs "--index-too=
"
>> or even "--stage-only" vs "--stage-too" would have helped him appear
>> to be more serious and constructive and I think your expression
>> "mismatching participants" was a great way to say this.
>
> Right, your explanation is more clear:

You have a funny way of saying "I'm sorry, I wasn't constructive,=20
and my attitude repelled many participants from the discussion".

> the fact that we need both
> doesn't mean we cannot use the term "stage". As to "constructive
> proposal" I deliberately tried to avoid them in case somebody tried t=
o
> disregard it as bike-shedding, and move on.

If the only constructive proposal you could make is to replace=20
words used in two operations without clarifying concepts any=20
better to newbies, then what you are doing is bike-shedding.=20
I don't think trying to hide that by not making any proposal=20
changes that.

> What I'm trying to do is
> bring up the issue that the stage is not user friendly.

I thought you were the one who wanted to use "stage" everywhere?

=46or what it's worth, "stage" isn't very user friendly to me;=20
maybe it is because I'm not a native English speaker. I'm not=20
saying that when I hear "index" or "cached" I'll understand=20
what they mean even if I didn't have any prior knowledge of=20
git, but I am saying "stage" isn't any better than these two=20
words in that respect. Of course the user needs to understand=20
what it is and how it is used, no matter what word you use.

I think a proposal to replace the word "index" with "stage"=20
will sound nothing but bike-shedding to anybody, especially=20
after getting familiar with "index" and seeing it taught on=20
many web pages and books.

> I like David K=C3=A5gedal's suggestion more:
> http://kerneltrap.org/mailarchive/git/2008/10/29/3857134

=46or people who like a usable threaded interface to read=20
the message in context here is its URL.

http://thread.gmane.org/gmane.comp.version-control.git/99332/focus=3D99=
401

Yes, I had David's proposal in mind when I wrote my response.=20
Even though the fundamental idea is the same, I used --X-vs-Y=20
option to avoid the problems David's proposal has in a slightly=20
nicer way.

David's proposal introduced two magic tokens STAGE and WORKTREE.

  git diff STAGE WORKTREE   (like "git diff" today)
  git diff HEAD WORKTREE    (like "git diff HEAD" today)
  git diff WORKTREE HEAD    (like "git diff -R HEAD" today)
  git diff HEAD STAGE       (like "git diff --cached" today)
  git diff commit STAGE     (like "git diff --cached commit" today)

This looks nice on surface, but I think the apparent niceness=20
is shallow. If of course has a small problem of introducing an=20
obvious backward incompatibility. You can't use a branch whose=20
name is STAGE anymore, but a deeper problem is that these two=20
magic tokens pretend to be refs. But they do so only to the diff=20
command. I don't see how you can make them sanely be usable to=20
other commands like "git log v1.0.0..WORKTREE".

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

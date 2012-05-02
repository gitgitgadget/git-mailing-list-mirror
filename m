From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Please pull git-po master branch
Date: Wed, 2 May 2012 15:58:17 +0200
Message-ID: <87ehr2znuu.fsf@thomas.inf.ethz.ch>
References: <CANYiYbHtKKWw9LPnr+1khC5Oms-kOtA2WEucoNoE3Njzqiahzw@mail.gmail.com>
	<87d36n2f2r.fsf@thomas.inf.ethz.ch>
	<CAN0XMOJ0PBA2qptw2Lm9HOq4SAkeZNAyOwPdvcb-uAcsxKnzwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 02 15:58:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPa4X-000242-D8
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854Ab2EBN6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:58:21 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:28275 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831Ab2EBN6T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 09:58:19 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Wed, 2 May
 2012 15:58:16 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 2 May
 2012 15:58:18 +0200
In-Reply-To: <CAN0XMOJ0PBA2qptw2Lm9HOq4SAkeZNAyOwPdvcb-uAcsxKnzwg@mail.gmail.com>
	(Ralf Thielow's message of "Wed, 2 May 2012 11:13:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196822>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

> As I said I've tried to unify with the git-gui translation. Actually,=
 I was
> wondered why they translate terms like "Tag" or "Commit" because
> I think they should be known by a Git user.
>=20
> I know German books about Git using many other terms like
> "Staging" or "Index" as it is.

Well, this is getting into the eternal "German vs. Denglish"
bikeshedding war.  If you can actually cite books, that would probably
constitute a good argument in favour of changing it to the English term=
s
for these.  (I'd be all for it, and AFAIK so would Jan, but as I said
this has been going on for a while.)

>> * Make a glossary of the relevant terminology first. =C2=A0Sadly
>> =C2=A0gitglossary(7) has gotten somewhat stale, and perhaps can also=
 benefit
>> =C2=A0from an overhaul. =C2=A0=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 recently made a list[4] of
>> =C2=A0the most important terms, which is a good start.
>
> I would be happy to work together with you on these things.
> Tiny changes in the translation of basic terms can make
> a big difference.

Perhaps you could use the Github wiki feature to import =C3=86var's lis=
t into
a wiki in your git-de-po repository, which we could then edit?

> I don't think that it's sooo bad that it needs to get reverted.

Probably not, since that would be pointless without another minor
release.  But I am saying it should not have been fast-tracked to maint
in the first place.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch

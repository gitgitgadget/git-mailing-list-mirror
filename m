From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How we should translate Git
Date: Wed, 15 Sep 2010 22:54:19 +0200
Message-ID: <4C91327B.1070203@drmicha.warpmail.net>
References: <AANLkTinJSzP+3xNLHJisqKzg2LHFaSuaRWxgdFrFp17R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Christian Stimming <stimming@tuhh.de>, jk@jk.gs,
	git <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 22:54:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovz0I-0008AH-O6
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 22:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab0IOUyQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 16:54:16 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60078 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752938Ab0IOUyQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 16:54:16 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C13C35C6;
	Wed, 15 Sep 2010 16:54:15 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 15 Sep 2010 16:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=bNhw8r98mblThj9aH2MKVUlo7BI=; b=kGoAjnnaoqFMUXL9GAtx+tNQKpcfSCS6DgKHMMGXlT3UjEhxO4LVioz9FW27VCD05sXLuQ8A8g9Bwd9ApxTepc5ksBfKGwhnUYA6YZqN2WedykyLD2Svid003bV6ewJfuf1Bh5EVO2rv3Ld4xgh2lk0P/ZJbqOvwoDjbNYzRBjI=
X-Sasl-enc: zzPIybxaGyjy0bW7623/N1lGQgk52toe/Ip9o1NylMf2 1284584055
Received: from localhost.localdomain (p548580A7.dip0.t-ipconnect.de [84.133.128.167])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A4708400293;
	Wed, 15 Sep 2010 16:54:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <AANLkTinJSzP+3xNLHJisqKzg2LHFaSuaRWxgdFrFp17R@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156257>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 15.09.2010 2=
2:09:
> On Wed, Sep 15, 2010 at 09:47, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>> There are German terms for all the untranslated ones, but I rarely
>> hear them in practical usage.  Books probably go for a full
>> translation since they want to be normative (how should I know, it's
>> been a while since I used a German book), but lectures stick to the
>> half-translated version.
>>
>> And much like the average computer scientist around here uses a numb=
er
>> of English terms even in German informal speech, I suspect the avera=
ge
>> German user of git would not translate *every* term.  Unless you are
>> aiming for a normative usage, in which case we would also have to
>> translate the theory (manpages, books) using the same terms...
>>
>> I'll leave it at that for my $0.02, since as you note, I'm not
>> actually the intended audience.
>=20
> I'm forking this off from the German thread since I wanted to make a
> more general point about how we translate Git in general.
>=20
> Firstly, not to step on anyone's toes. I think that final say on how
> to translate Git has to be left to each language community, some
> languages (like German) simply use more loan words. While others (lik=
e
> Icelandic) prefer to translate pretty much anything as a matter of
> course.
>=20
> But here's something to keep in mind:
>=20
> Unlike the German article on version control we're going to be the
> primary and definite source for Git translations, and given Git's
> popularity probably the definite source for all DVCS translations for
> a given language.
>=20
> While translating some things might look awkward now words are usuall=
y
> awkward because you aren't familiar with them.
>=20
> The translations we come up with are going to be used for a long time=
,
> DVCS is a relatively new field, and if we do a good job people using
> Git (or other derived systems) in the year 2050 might be using some o=
f
> the terms we come up with, and they'll sound natural to them because
> they're used to them.
>=20
> More and more people from all walks of life are using computers, word
> processing used to be a relatively advanced thing 20 years ago, now
> everyone does it.
>=20
> Similarly, everyone might be using a DVCS 30 years from now. Small
> children might be "forking" and "branching" on their tablet computers
> as they collaborate on some school project.
>=20
> People like that will benefit from a more exhaustive translation into
> their native language, and even people that are bilingual will benefi=
t
> from a good translation.
>=20
> I find it very easy to think in either English or Icelandic, but I
> struggle when I have to do both at the same time. I'd guess that
> people who explicitly turn on translations on their computer usually
> want a more complete one than not.

I just have to say that I agree totally. Thanks :)

Michael

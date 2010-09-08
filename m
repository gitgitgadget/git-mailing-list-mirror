From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] po/hi.po: Add Hindi Translation
Date: Wed, 8 Sep 2010 20:20:10 +0530
Message-ID: <20100908144954.GC30671@kytes>
References: <1283711267-27679-1-git-send-email-artagnon@gmail.com>
 <AANLkTinGvySGu=rQxccCJ6v3ct6s6kf3butEcZvSMPpB@mail.gmail.com>
 <20100906042942.GA32387@kytes>
 <AANLkTimprZ39ggcfgh_6b9yGDnfM8vFSfs+rH82ZWfkD@mail.gmail.com>
 <20100907075509.GA9533@kytes>
 <AANLkTimQx7nNBTnOZ334=1bmuRH5x-r4XtNRU4ODbm-e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Antriksh Pany <antriksh.pany@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 16:52:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtM0l-0005Cy-Cv
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 16:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab0IHOwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 10:52:22 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46514 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab0IHOwV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 10:52:21 -0400
Received: by pvg2 with SMTP id 2so54094pvg.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YE6WMJbYybmH3G3fDWEF93CRPe4Vxctvt93YFnqV61M=;
        b=ajfESG7b0LW1/R9suwgoBIe0fq3CUj2WwROeYkxdOb662qQI/AXHdA0JN8ysHSq2/x
         pAStfr2xdn7JR3gQQggH3cPSIVakDloPXJYrVoRoLNdG8JrVa0E3wSEkhKN5r2CNJN/T
         P8bbQ+g4fwG2FrhYuj+dobTCmw/b48Hxtlc54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lIDzJAwEw1ocQ/3CHooYgSNhJfNNOQk2ZuUN4wRdXxvH/uivccwC6QVmNHdHw2jpqs
         2E8Pcgw9mtQJCwcnPE/6cdjHsZYB3L1scdO7JXA/rOsYszcoVwtUwoHKl4dpU7YR7ePA
         TK4/vscf6CKPyd0au33Bbk0CQ/o3Mg2JA/qc4=
Received: by 10.114.121.8 with SMTP id t8mr76970wac.156.1283957530915;
        Wed, 08 Sep 2010 07:52:10 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id d38sm191755wam.8.2010.09.08.07.52.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 07:52:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimQx7nNBTnOZ334=1bmuRH5x-r4XtNRU4ODbm-e@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155790>

Hi Antriksh,

Antriksh Pany writes:
> Some more comments (spotted a few more possible improvements) and
> responses inline.

Thanks for additionally clearing my doubts :)

> >> > =C2=A0#, c-format
> >> > =C2=A0msgid "cannot copy '%s' to '%s'"
> >> > -msgstr "'%s' =E0=A4=95=E0=A4=BE =E0=A4=A8=E0=A4=95=E0=A4=B2 '%s=
' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=
=B8=E0=A4=95=E0=A5=87"
> >> > +msgstr "'%s' =E0=A4=95=E0=A4=BE =E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=
=95=E0=A5=83=E0=A4=A4=E0=A4=BF '%s' =E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=A8=
=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=
=87"
> >> ka -> ki
> >
> > Ah, yes. Gender ambiguity in Hindi. I also felt it should be =E0=A4=
=95=E0=A5=80. Can
> > you explain why though? '%s' a noun here; have you chosen it to be
> > feminine? But =E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=95=E0=A5=83=E0=A4=A4=
=E0=A4=BF is a noun as well, and quite obviously
> > feminine. Is that why?
>=20
> Yes, =E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=95=E0=A5=83=E0=A4=A4=E0=A4=BF =
being feminine is what causes 'ki' to be used here.

Got it.

> >> > =C2=A0#, c-format
> >> > =C2=A0msgid "ignoring template %s"
> >> > -msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=
=A5=87=E0=A4=9F =E0=A4=95=E0=A5=8B =E0=A4=89=E0=A4=AA=E0=A5=87=E0=A4=95=
=E0=A5=8D=E0=A4=B7=E0=A4=BE =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=
=87 =E0=A4=B9=E0=A5=88: %s"
> >> > +msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=
=A5=87=E0=A4=9F %s =E0=A4=95=E0=A4=BE =E0=A4=89=E0=A4=AA=E0=A5=87=E0=A4=
=95=E0=A5=8D=E0=A4=B7=E0=A4=BE =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=
=A5=87 =E0=A4=B9=E0=A5=88"
> >> ka -> ki
> >
> > Similar confusion- I'd like an explanation if possible. =E0=A4=89=E0=
=A4=AA=E0=A5=87=E0=A4=95=E0=A5=8D=E0=A4=B7=E0=A4=BE is a
> > verb, and I'm not sure how it transforms when gender is afflicted o=
n
> > it. I have chosen =E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=
=B2=E0=A5=87=E0=A4=9F to be masculine- do you think it should be
> > feminine?
>=20
> Again, =E0=A4=89=E0=A4=AA=E0=A5=87=E0=A4=95=E0=A5=8D=E0=A4=B7=E0=A4=BE=
 is determining the gender usage.
> Also, not sure if this is a good word to use. =E0=A4=89=E0=A4=AA=E0=A5=
=87=E0=A4=95=E0=A5=8D=E0=A4=B7=E0=A4=BE typically has a negative
> connotation, so does not seem to fit well here. =E0=A4=85=E0=A4=A8=E0=
=A4=A6=E0=A5=87=E0=A4=96=E0=A4=BE (while not being
> perfect either) may be better?

Actually, this was my intent. I considered =E0=A4=85=E0=A4=A8=E0=A4=A6=E0=
=A5=87=E0=A4=96=E0=A4=BE in the beginning, but
I thought =E0=A4=89=E0=A4=AA=E0=A5=87=E0=A4=95=E0=A5=8D=E0=A4=B7=E0=A4=BE=
 was closer. =E0=A4=85=E0=A4=A8=E0=A4=A6=E0=A5=87=E0=A4=96=E0=A4=BE sou=
nds like "didn't look", but I was
aiming for a more aggressive word for conciously ignoring.

> >> > =C2=A0#, c-format
> >> > =C2=A0msgid "insanely long template path %s"
> >> > -msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=
=A5=87=E0=A4=9F =E0=A4=95=E0=A4=BE =E0=A4=86=E0=A4=95=E0=A4=BE=E0=A4=B0=
 =E0=A4=AC=E0=A4=B9=E0=A5=81=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=A4=
=BE =E0=A4=B9=E0=A5=88: %s"
> >> > +msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=
=A5=87=E0=A4=9F %s =E0=A4=95=E0=A4=BE =E0=A4=86=E0=A4=95=E0=A4=BE=E0=A4=
=B0 =E0=A4=AC=E0=A4=B9=E0=A5=81=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=
=A4=BE =E0=A4=B9=E0=A5=88"
> >> Again: bahut -> atyant. And again, '=E0=A4=B9=E0=A5=88' could be d=
ropped perhaps.
> >
> > Ok.
>=20
> On second thoughts, =E0=A4=86=E0=A4=95=E0=A4=BE=E0=A4=B0 is definitel=
y not close enough to 'path'.
> Can we think of something else?

A literal translation like =E0=A4=AA=E0=A4=A5 is probably not the way t=
o go. =E0=A4=B0=E0=A4=BE=E0=A4=B9 is
only marginally better. Although =E0=A4=86=E0=A4=95=E0=A4=BE=E0=A4=B0 l=
iterally means "form", I also
think it's not close enough. If we run out of ideas, we have to
transliterate.

> >> > =C2=A0#, c-format
> >> > =C2=A0msgid "not copying templates of a wrong format version %d =
from '%s'"
> >> > -msgstr "'%s' =E0=A4=B8=E0=A5=87 =E0=A4=97=E0=A4=B2=E0=A4=A4 =E0=
=A4=B8=E0=A5=8D=E0=A4=B5=E0=A4=B0=E0=A5=82=E0=A4=AA =E0=A4=B8=E0=A4=82=E0=
=A4=B8=E0=A5=8D=E0=A4=95=E0=A4=B0=E0=A4=A3 %d =E0=A4=95=E0=A4=BE =E0=A4=
=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=E0=A4=9F =E0=A4=
=A8=E0=A4=95=E0=A4=B2 =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=
=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=87 =E0=A4=B9=E0=A5=88"
> >> > +msgstr "'%s' =E0=A4=B8=E0=A5=87 =E0=A4=97=E0=A4=B2=E0=A4=A4 =E0=
=A4=B8=E0=A5=8D=E0=A4=B5=E0=A4=B0=E0=A5=82=E0=A4=AA =E0=A4=B8=E0=A4=82=E0=
=A4=B8=E0=A5=8D=E0=A4=95=E0=A4=B0=E0=A4=A3 %d =E0=A4=95=E0=A5=87 =E0=A4=
=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=E0=A4=9F=E0=A5=
=8D=E0=A4=B8 =E0=A4=95=E0=A5=87 =E0=A4=A8=E0=A4=95=E0=A4=B2 =E0=A4=A8=E0=
=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=87
> >> > =E0=A4=B9=E0=A5=88"
> >> Had changed =E0=A4=A8=E0=A4=95=E0=A4=B2 to =E0=A4=85=E0=A4=A8=E0=A5=
=81=E0=A4=95=E0=A5=83=E0=A4=A4=E0=A4=BF earlier. Not doing that here?
> >
> > While =E0=A4=A8=E0=A4=95=E0=A4=B2 is definitely the easier word to =
use, it's a verb. =E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=95=E0=A5=83=E0=A4=A4=
=E0=A4=BF is
> > a noun on the other hand- I had to introduce it into the previous
> > sentence because "Make a =E0=A4=A8=E0=A4=95=E0=A4=B2 of X in Y" wou=
ld be technically
> > incorrect.
> >
>=20
> '=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=E0=A4=
=9F=E0=A5=8D=E0=A4=B8 =E0=A4=95=E0=A5=87 ' -> 'ki' would have to be use=
d here. '=E0=A4=A8=E0=A4=95=E0=A4=B2' is determining
> gender here :)

Nice catch :)

> Well, I really thought that the purpose of translation is more utilit=
arian
> than anything else. And I would still count myself among those friend=
s
> of yours who either don't see many Indians using this, or see some va=
lue
> only if words which don't have a direct reference in Hindi are transl=
iterated
> :)
>=20
> There are other languages where effort is taken to find equivalents t=
o modern
> terms, and hence don't need a lot of transliterations. That, unfortun=
ately, is
> not the case with Hindi :(

Yeah, translation definitely hasn't caught up here- especially with
everyone aggressively pursuing English education.

> Really appreciate the effort you have put in on this, despite not bei=
ng
> a native Hindi speaker. Sorry for so many nits :)

Thanks for the nits. Being a grammar nazi can't be easy :)
I'll submit another revision with some amendments soon.

-- Ram

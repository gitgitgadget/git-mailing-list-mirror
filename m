From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Translate the tutorial to Brazillian Portuguese.
Date: Mon, 29 Jun 2009 09:33:06 -0700 (PDT)
Message-ID: <m3prcnvw3v.fsf@localhost.localdomain>
References: <7vljnbcbjs.fsf@alter.siamese.dyndns.org>
	<1246289542-1596-1-git-send-email-cascardo@holoscopio.com>
	<7vfxdjc9b3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	git@vger.kernel.org, Yasuaki Narita <yasuaki_n@mti.biglobe.ne.jp>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 18:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLJnD-0005rh-US
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 18:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758900AbZF2QdJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jun 2009 12:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758251AbZF2QdI
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 12:33:08 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:50443 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbZF2QdH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2009 12:33:07 -0400
Received: by fxm18 with SMTP id 18so1080695fxm.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=lllAf9SMGGHTogc8ga97EB9Mc1awqTB0fQrCu3s05Ow=;
        b=W9RJic6+VBln1+y3Oz+H1OMQa1vAfwcTjBPov7cXmAyU3LUKcXvUli4QY13kAP4XTa
         ndX9uGTn4ZE3nsbvIExBjREDGH9KF7ZuXOzog25NvMY4qvtSI+MSSMoBHFIg/R237sce
         bLkcjtAwjQ6w/ovRlISl44HjyB8UiJvAmm9+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=EYfTqsuEXiJVa50ZDqb1h5AaMv2wJXajhTA5yp/rNoMC8+dyIe8tF4AU/ur9QSqspV
         63+1Y+nfmyi9zPcThZ06DXDqP0dJGT2r+PuDL6rqPRLRLj730T9R7keLs4trpsFneItJ
         uRVq8ZfIc5Nzp5upvxF4wtLsQLlb88uQYNtW4=
Received: by 10.86.31.17 with SMTP id e17mr1564423fge.47.1246293187318;
        Mon, 29 Jun 2009 09:33:07 -0700 (PDT)
Received: from localhost.localdomain (abvw77.neoplus.adsl.tpnet.pl [83.8.220.77])
        by mx.google.com with ESMTPS id e20sm6391166fga.0.2009.06.29.09.33.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 09:33:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5TGX548011676;
	Mon, 29 Jun 2009 18:33:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5TGWrdn011672;
	Mon, 29 Jun 2009 18:32:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vfxdjc9b3.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122447>

Junio C Hamano <gitster@pobox.com> writes:

> Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com> writes:

> > +Voc=C3=AA tamb=C3=A9m pode dar ao 'git-log' um "intervalo" de comm=
its onde o
> > +primeiro n=C3=A3o =C3=A9 necessariamente um ancestral do segundo; =
por exemplo, se
> > +as pontas dos ramos "stable" e "master" divergiram de um commit
> > +comum algum tempo atr=C3=A1s, ent=C3=A3o
> > +
> > +-------------------------------------
> > +$ git log stable..experimental
> > +-------------------------------------
=20
> I am somewhat worried about the way how this translation will be
> maintained to keep in sync with the authoritative English version.
> Narita-san (CC'ed) who translated the document to Japanese did this:
>=20
>     gittutorial(7)
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     // =3D gittutorial(7)
>=20
>     NAME
>     ----
>     // =3D=3D NAME
>     gittutorial - A tutorial introduction to git (for version 1.5.1 o=
r newer)
>     // gittutorial - git =E3=83=81=E3=83=A5=E3=83=BC=E3=83=88=E3=83=AA=
=E3=82=A2=E3=83=AB (=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3 1.5.1=
 =E4=BB=A5=E9=99=8D=E7=94=A8)
>=20
> and the idea seems that without // (comments in AsciiDoc markup) it
> matches the English copy, and after passing sed -ne 's|^// ||p' it yi=
elds
> Japanese version.  Narita-san's translation can be seen at
>=20
>     http://github.com/yasuaki/git-manual-jp.git/Documentation
>=20
> if anybody is interested.
>=20
> With this format, merging upstream changes may not work as smoothly a=
s it
> could be, but at least you can check which part of your translation i=
s
> based on a stale copy with something like this arrangement.
>=20
> I am wondering if it would be a good idea to extend Narita-san's sche=
me so
> that we can keep a single source, perhaps like:
>=20
>     =3D gittutorial(7)
>     // ja =3D gittutorial(7)
>     // pt =3D gittutorial(7)
>     =3D=3D NAME
>     // ja =3D NAME
>     // pt =3D NAME
>     gittutorial - A tutorial introduction to git (for version 1.5.1 o=
r ...
>     // ja gittutorial - git =E3=83=81=E3=83=A5=E3=83=BC=E3=83=88=E3=83=
=AA=E3=82=A2=E3=83=AB (=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3 1.=
5.1 =E4=BB=A5=E9=99=8D=E7=94=A8)
>     // pt gittutorial - Um tutorial de introdu=C3=A7=C3=A3o ao git (p=
ara vers=C3=A3o 1....
>=20
> Then whenever somebody makes a change to the English version, he can =
and
> should also mark the corresponding translated versions "stale", so th=
at it
> is easier to spot by translators.

[...]
> I however am not sure how practical it would be to force people to lo=
ok at
> the *.txt version of document, only 1/n lines of which is now readabl=
e by
> him (if you are like a typical American who understands only English =
;-).
>=20
> Thoughts?

Somebody here (or on #git channel) pointed that there is po4a[1-4]
project using gettext to translate documentation.

[1] http://po4a.alioth.debian.org/
[2] https://launchpad.net/po4a
[3] http://freshmeat.net/projects/po4a
[4] http://www.ohloh.net/p/po4a
--=20
Jakub Narebski
Poland
ShadeHawk on #git

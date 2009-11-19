From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: Re: gitk : french translation
Date: Thu, 19 Nov 2009 20:47:53 +0100
Message-ID: <20091119204753.85765c5d.etrillaud@gmail.com>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com>
	<9f50533b0911100945l2c3b7399w1d72771fd2cf8df@mail.gmail.com>
	<20091111001050.GC27518@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Maximilien Noal <noal.maximilien@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Guy Brand <gb@unistra.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Nov 19 20:49:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBD0o-0000HQ-Ge
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 20:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbZKSTtk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2009 14:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbZKSTtk
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 14:49:40 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:55574 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177AbZKSTtj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 14:49:39 -0500
Received: by qw-out-2122.google.com with SMTP id 3so594910qwe.37
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 11:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=U+Io57/N4M4h9e5Gdp5LqpwuSZSpUL4xlLWLYDx9Da8=;
        b=bpeE4rl+/ZPK2bfU8GMZWpBa5KBeGwcYuQsrrG1xsKV7SfQ6gaFzH69WrtmZm+NMKJ
         eBZ+gUee3gNHZso3CNIp5oaKriFW5ooIHtv4ZiWPLzu1q8dzeG0HlNMFZKjR4UHIJTRZ
         TmDet0qhZ/5Rzono/NOljHf4oSPGfcmQZI/js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=srccqkZ+e0+e87Ql4bA29DqNksUzU2wqKnuYgRb1bUumdu5pzLSZvOXie3ipbSdEg2
         qOXxXjXJCYdoi/9776FWrFRz4kvqpLoPH6ijWrx0NbJr0+bzC/6dKE3uO4HQCVynE6Q0
         D+yzY/vCrezE8v6SG/47gzWISJNwVWtZN6TUc=
Received: by 10.213.23.156 with SMTP id r28mr1890069ebb.86.1258660183813;
        Thu, 19 Nov 2009 11:49:43 -0800 (PST)
Received: from eleanor (cxr69-1-87-88-216-137.dsl.club-internet.fr [87.88.216.137])
        by mx.google.com with ESMTPS id 5sm216258eyh.24.2009.11.19.11.49.41
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 11:49:42 -0800 (PST)
In-Reply-To: <20091111001050.GC27518@vidovic>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133251>

I finally took some time to improve the gitk french translation V2. The
V3 address most of the comments of Nicolas. I respond to this message
with the actual V3.

>=20
> Line wraping error; configure your mail user agent to not wrap lines,
> please.
>=20
> > +#FIXME : am=E9liorer la traduction de 'file limite'
>=20
> If you add some FIXME (which is good), you also should mark the
> translation as "fuzzy" like this:
In those cases, I either improve the translations or mark them fuzzy

>=20
>=20
> > +#: gitk:1793 gitk:1817 gitk:3916 gitk:8786 gitk:10322 gitk:10498
> > +msgid "OK"
> > +msgstr "OK"
>=20
> This one should not be required.
Those strings are already "translated", so I see no reason to
remove the translation (if the strings change !? we'll have translate
them anyway)

> > +#: gitk:2713
> > +msgid "/\t\tFocus the search box"
> > +msgstr "/"
=2E..


> > +# FIXME : traduction de "skip"
>=20
> "=E9viter"?
>=20
> > +#: gitk:3697
> > +msgid "Limit and/or skip a number of revisions (positive integer):=
"
> > +msgstr "Limiter et/ou sauter un certain nombre (entier positif) de=
 r=E9vision :"
=2E..

> > +#FIXME : traduction de "branch sides"
> > +#: gitk:3702
>=20
> #, fuzzy
>=20
> > +msgid "Mark branch sides"
> > +msgstr "Marquer le flanc des branches"
>=20
> What about "c=F4t=E9"?
I choose "extr=E9mit=E9s" but I let the string fuzzy

=20
> > +#FIXME : plut=F4t traduire par "pas un descendant"
> > +#: gitk:4606
>=20
> #, fuzzy
>=20
> > +msgid "Not descendant"
> > +msgstr "Non descendant"
I use "Pas un descendant"

> > +#FIXME : plut=F4t traduire par "pas un anc=EAtre"
> > +#: gitk:4614
>=20
> #, fuzzy
>=20
> > +msgid "Not ancestor"
> > +msgstr "Non anc=EAtre"
I use "Pas un anc=EAtre"
=20

> > +#: gitk:9257
> > +msgid ""
> > +"Error reading commit topology information; branch and preceding/f=
ollowing "
> > +"tag information will be incomplete."
> > +msgstr ""
> > +"Erreur =E0 la lecture des informations sur la topology des commit=
s. "
>=20
> s/topology/topologie/
> s/./ ;/
I use "," instead. We don't use the ";" often in french.

> > +#: gitk:10441
> > +msgid "Support per-file encodings"
> > +msgstr "Support pour un encodage de caract=E8re par fichier"
>=20
> s/de caract=E8re/ des caract=E8res/
>=20

> --=20
> Nicolas Sebrecht


--=20
Emmanuel Trillaud <etrillaud@gmail.com>

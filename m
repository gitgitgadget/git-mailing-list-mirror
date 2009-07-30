From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: [PATCH] Fix typos on pt_BR/gittutorial.txt translation
Date: Thu, 30 Jul 2009 20:19:11 -0300
Message-ID: <20090730231911.GI1727@vespa.holoscopio.com>
References: <b8bf37780907292044i5ad7b879ueb5048447e4e5bb5@mail.gmail.com> <20090730145044.GA1727@vespa.holoscopio.com> <4A71C6A7.80008@drmicha.warpmail.net> <7viqhaar7v.fsf@alter.siamese.dyndns.org> <b8bf37780907301551w4cdc7e96m137aa188ce1a0a8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u/L2/WlOHZg+YGU4"
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>
To: =?utf-8?B?QW5kcsOp?= Goddard Rosa <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 01:19:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWeu9-0002gq-5i
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 01:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbZG3XTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 19:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbZG3XTO
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 19:19:14 -0400
Received: from liberdade.minaslivre.org ([72.232.18.203]:33738 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbZG3XTN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 19:19:13 -0400
Received: from vespa.holoscopio.com (unknown [201.80.130.87])
	by liberdade.minaslivre.org (Postfix) with ESMTPSA id C59A4208019;
	Thu, 30 Jul 2009 20:31:44 -0300 (BRT)
Received: by vespa.holoscopio.com (Postfix, from userid 1000)
	id BCD6DC22A; Thu, 30 Jul 2009 20:19:11 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <b8bf37780907301551w4cdc7e96m137aa188ce1a0a8c@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124486>


--u/L2/WlOHZg+YGU4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2009 at 07:51:17PM -0300, Andr=C3=A9 Goddard Rosa wrote:
> On 7/30/09, Junio C Hamano <gitster@pobox.com> wrote:
> > Michael J Gruber <git@drmicha.warpmail.net> writes:
> >
> >> Isn't it more like "kernel of linux", which is pretty OK (at least in
> >> English)?
> >
> > Google shows (in a query limited to Portuguese) 912000 hits for "kernel=
 do
> > Linux" and 6550 hits for "o Linux kernel", so as Thadeu already said, it
> > appears to be not just "common", but "so common that practically nobody
> > uses the other form."
> >
> > I do not know if there is a war between the factions that use these two
> > phrases in Portuguese speaking community, but this smells somewhat simi=
lar
> > to the "Is it Linux or GNU/Linux?" religious war.  GNU/Linux example mi=
ght
> > be much more religious, as opposed to a lingusitc disagreement Thadeu's
> > comment suggests the Portuguese situation is, though.
> >
> > Be it religious or linguistic, I'd rather not to see the war fought in =
our
> > documentation.  The documentation is not about the Linux kernel to begin
> > with, and being easier to read and understand by using phrases more
> > familiar to the readers is much more important than being technically a=
nd
> > linguistically correct but risking to make novices stutter while reading
> > due to uncommon wording.
> >
>=20
> Hi, Junio!
>=20
>     I surely won't argue with your pragmatic view, I do believe it's
> good for the project, as you have mentioned.
>=20
>     Would you like to get another patch or can you adjust it himself
> as you like?
>=20
> Thanks,
> Andre

I'd rather remove the linux example and use something else (like git
itself), since the Documentation is not about linux, as Juno says and
that would stop the disagreements.

Regards,
Cascardo.


diff --git a/Documentation/pt_BR/gittutorial.txt b/Documentation/pt_BR/gitt=
utorial.txt
index 38fab57..2b982f3 100644
--- a/Documentation/pt_BR/gittutorial.txt
+++ b/Documentation/pt_BR/gittutorial.txt
@@ -595,9 +595,9 @@ uma lista. Quando a hist=C3=B3ria tem linhas de desenvo=
lvimento que
 divergiram e ent=C3=A3o foram unificadas novamente, a ordem em que 'git-lo=
g'
 apresenta essas mudan=C3=A7as =C3=A9 irrelevante.
=20
-A maioria dos projetos com m=C3=BAltiplos contribuidores (como o kernel
-Linux, ou o pr=C3=B3prio git) tem unifica=C3=A7=C3=B5es frequentes, e 'git=
k' faz um
-trabalho melhor de visualizar sua hist=C3=B3ria. Por exemplo,
+A maioria dos projetos com m=C3=BAltiplos contribuidores (como o pr=C3=B3p=
rio git)
+tem unifica=C3=A7=C3=B5es frequentes, e 'gitk' faz um trabalho melhor de
+visualizar sua hist=C3=B3ria. Por exemplo,
=20
 -------------------------------------
 $ gitk --since=3D"2 weeks ago" drivers/
@@ -646,8 +646,7 @@ outras digress=C3=B5es que podem ser interessantes nest=
e ponto s=C3=A3o:
=20
   * linkgit:git-format-patch[1], linkgit:git-am[1]: Estes convertem
     s=C3=A9ries de commits em patches para email, e vice-versa, =C3=BAteis=
 para
-    projetos como o kernel Linux que dependem fortemente de patches
-    enviados por email.
+    projetos que dependem fortemente de patches enviados por email.
=20
   * linkgit:git-bisect[1]: Quando h=C3=A1 uma regress=C3=A3o em seu projet=
o, uma
     forma de rastrear um bug =C3=A9 procurando pela hist=C3=B3ria para enc=
ontrar o

--u/L2/WlOHZg+YGU4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpyKm8ACgkQyTpryRcqtS0GpACfbTGbEA+3tKYUHfWv5uDTLxsb
3kgAn03y+uasX/2b/WIOChIDvnFGtVRH
=wVBu
-----END PGP SIGNATURE-----

--u/L2/WlOHZg+YGU4--

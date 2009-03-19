From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-gui: various French translation fixes
Date: Thu, 19 Mar 2009 08:02:46 +0100
Message-ID: <20090319070246.GA6561@glandium.org>
References: <20090318205410.GA900@zoy.org> <200903190609.25344.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Hocevar <sam@zoy.org>, Git List <git@vger.kernel.org>,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 08:03:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkCHw-0007S1-O1
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 08:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302AbZCSHCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 03:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755632AbZCSHCH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 03:02:07 -0400
Received: from vuizook.err.no ([85.19.221.46]:56379 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756629AbZCSHCF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 03:02:05 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LkCGH-0002ZG-KN; Thu, 19 Mar 2009 08:01:56 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LkCH8-0001i4-3S; Thu, 19 Mar 2009 08:02:46 +0100
Content-Disposition: inline
In-Reply-To: <200903190609.25344.chriscool@tuxfamily.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 1.6): No, score=1.6 required=5.0 tests=RDNS_DYNAMIC,WEIRD_PORT autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113723>

On Thu, Mar 19, 2009 at 06:09:25AM +0100, Christian Couder wrote:
> Le mercredi 18 mars 2009, Sam Hocevar a =E9crit :
> > Mostly grammar, spelling and typography fixes, but also a few wordi=
ng
> > enhancements here and there.
>=20
> It looks mostly good to me.
>=20
> > Signed-off-by: Sam Hocevar <sam@zoy.org>
> > ---
> >  po/fr.po |  196
> > +++++++++++++++++++++++++++++++------------------------------- 1 fi=
les
> > changed, 98 insertions(+), 98 deletions(-)
> >
> >  #: git-gui.sh:2484 lib/index.tcl:410
> >  msgid "Revert Changes"
> > -msgstr "Annuler les modifications (revert)"
> > +msgstr "R=E9voquer les modifications"
>=20
> I am not sure that "R=E9voquer" is better than "Annuler".
>=20
> [...]
>=20
> >  #: lib/index.tcl:326
> >  msgid "Ready to commit."
> > @@ -1719,18 +1719,18 @@ msgstr "Ajout de %s"
> >  #: lib/index.tcl:396
> >  #, tcl-format
> >  msgid "Revert changes in file %s?"
> > -msgstr "Annuler les modifications dans le fichier %s ? "
> > +msgstr "R=E9voquer les modifications dans le fichier %s ? "
> >
> >  #: lib/index.tcl:398
> >  #, tcl-format
> >  msgid "Revert changes in these %i files?"
> > -msgstr "Annuler les modifications dans ces %i fichiers ?"
> > +msgstr "R=E9voquer les modifications dans ces %i fichiers ?"
> >
> >  #: lib/index.tcl:406
> >  msgid "Any unstaged changes will be permanently lost by the revert=
=2E"
> >  msgstr ""
> >  "Toutes les modifications non-index=E9es seront d=E9finitivement p=
erdues par
> > " -"l'annulation."
> > +"la r=E9vocation."
>=20
> Same thing for the 3 strings above.

I'm not sure i like "non-index=E9es" for "unstaged"

> [...]
>=20
> >  #: lib/index.tcl:427
> >  msgid "Reverting selected files"
> > -msgstr "Annuler modifications dans fichiers selectionn=E9s"
> > +msgstr "R=E9vocation en cours des fichiers selectionn=E9s"
> >
> >  #: lib/index.tcl:431
> >  #, tcl-format
> >  msgid "Reverting %s"
> > -msgstr "Annulation des modifications dans %s"
> > +msgstr "R=E9vocation en cours de %s"
>=20
> Same thing above.
>=20
> >  #: lib/remote_branch_delete.tcl:47
> >  msgid "From Repository"
> > @@ -2244,7 +2244,7 @@ msgid ""
> >  "One or more of the merge tests failed because you have not fetche=
d the
> > " "necessary commits.  Try fetching from %s first."
> >  msgstr ""
> > -"Une ou plusieurs des tests de fusion ont =E9chou=E9s parce que vo=
us n'avez
> > pas "
> > +"Un ou plusieurs des tests de fusion ont =E9chou=E9 parce que vous=
=20
> > n'avez pas "
> > "r=E9cup=E9r=E9 les commits n=E9cessaires. Essayez de r=E9cup=E9r=E9=
 =E0=20
> > partir de %s d'abord."
>=20
> The last "r=E9cup=E9r=E9" should be changed to "r=E9cup=E9rer".

No it shouldn't, it's "vous n'avez pas r=E9cup=E9r=E9"

Mike

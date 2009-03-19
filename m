From: Sam Hocevar <sam@zoy.org>
Subject: Re: [PATCH] git-gui: various French translation fixes
Date: Thu, 19 Mar 2009 13:49:02 +0100
Message-ID: <20090319124901.GM27280@zoy.org>
References: <20090318205410.GA900@zoy.org> <200903190609.25344.chriscool@tuxfamily.org> <200903190714.25211.chriscool@tuxfamily.org> <20090319075855.GJ27280@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 13:50:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkHhk-0007Af-Bl
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 13:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbZCSMtI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 08:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbZCSMtG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 08:49:06 -0400
Received: from poulet.zoy.org ([80.65.228.129]:57448 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170AbZCSMtF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 08:49:05 -0400
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id 332CF1203C0; Thu, 19 Mar 2009 13:49:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090319075855.GJ27280@zoy.org>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113767>

On Thu, Mar 19, 2009, Sam Hocevar wrote:
> On Thu, Mar 19, 2009, Christian Couder wrote:
> > > >  #: git-gui.sh:2484 lib/index.tcl:410
> > > >  msgid "Revert Changes"
> > > > -msgstr "Annuler les modifications (revert)"
> > > > +msgstr "R=E9voquer les modifications"
> > >
> > > I am not sure that "R=E9voquer" is better than "Annuler".
> >=20
> > Perhaps "Inverser"?
>=20
>    I suggested "r=E9voquer" because it was close enough to "revert" t=
hat
> there was no need to specify "(revert)" in the translation itself.
> It's what the French Wikipedia interface used to say to revert edits.
> But I see they now use "d=E9faire" (undo), so apparently they deemed
> it inappropriate for some reason. I have no strong preference for
> "Inverser" or even "Annuler", I just want it to be consistent and to =
get
> rid of the "(revert)" at the end of this message.

   Sorry, I misread the Wikipedia interface because I wasn't logged in
and only admins can truly revert edits. So it does have "revert" (to
cancel an edit) and "undo" (to perform the opposite edit of a given
edit), which get translated to "r=E9voquer" and "d=E9faire". I therefor=
e
think "r=E9voquer" is just as good as the others.

--=20
Sam.

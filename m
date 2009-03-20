From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Re: git-gui: various French translation fixes
Date: Fri, 20 Mar 2009 07:45:50 +0100
Message-ID: <200903200745.50700.chriscool@tuxfamily.org>
References: <20090318205410.GA900@zoy.org> <20090319124901.GM27280@zoy.org> <20090319183839.GA12913@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Hocevar <sam@zoy.org>, Git List <git@vger.kernel.org>,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 07:48:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkYWi-0002P4-27
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 07:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbZCTGqt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 02:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbZCTGqt
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 02:46:49 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:34828 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbZCTGqs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 02:46:48 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 30848D480C6;
	Fri, 20 Mar 2009 07:46:38 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id DC76BD480FF;
	Fri, 20 Mar 2009 07:46:35 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20090319183839.GA12913@vidovic>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113902>

Le jeudi 19 mars 2009, Nicolas Sebrecht a =E9crit :
> On Thu, Mar 19, 2009 at 01:49:02PM +0100, Sam Hocevar wrote:
> > On Thu, Mar 19, 2009, Sam Hocevar wrote:
> > > On Thu, Mar 19, 2009, Christian Couder wrote:
> > > > > >  #: git-gui.sh:2484 lib/index.tcl:410
> > > > > >  msgid "Revert Changes"
> > > > > > -msgstr "Annuler les modifications (revert)"
> > > > > > +msgstr "R=E9voquer les modifications"
> > > > >
> > > > > I am not sure that "R=E9voquer" is better than "Annuler".
> > > >
> > > > Perhaps "Inverser"?
>
> [...]
>
> >    Sorry, I misread the Wikipedia interface because I wasn't logged=
 in
> > and only admins can truly revert edits.
>
> I don't think that we have to conform to Wikip=E9dia.
>
> >                                         So it does have "revert" (t=
o
> > cancel an edit) and "undo" (to perform the opposite edit of a given
> > edit), which get translated to "r=E9voquer" and "d=E9faire". I ther=
efore
> > think "r=E9voquer" is just as good as the others.
>
> I disagree here.
>
> "Annuler", "R=E9voquer", "Inverser" or "D=E9faire" usualy stands for =
the
> same thing but :
> - thoses words doesn't have stricly the same meanings ;
> - we are in a special case here because of the underlying technical
>   result.
>
> We should care that the revert operation does *not* remove a commit b=
ut
> add a new one (this makes sense to Git). As a consequence, we should
> avoid "Annuler", "R=E9voquer" and "D=E9faire".
>
> "Inverser" looks like the best translation.

Yeah, I agree with that reasoning.

Regards,
Christian.

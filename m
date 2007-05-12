From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Document patch syntax.
Date: Sat, 12 May 2007 16:38:27 +0200
Message-ID: <20070512143827.GE16903@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070512120704.22970.45140.stgit@gandelf.nowhere.earth> <20070512135644.GA28039@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat May 12 16:39:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmsl2-0000y7-Ow
	for gcvg-git@gmane.org; Sat, 12 May 2007 16:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbXELOjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 10:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbXELOjf
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 10:39:35 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:48890 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754917AbXELOjf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 10:39:35 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 9E59A5E15C;
	Sat, 12 May 2007 16:39:33 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id A62541F161; Sat, 12 May 2007 16:38:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070512135644.GA28039@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47050>

On Sat, May 12, 2007 at 03:56:44PM +0200, Karl Hasselstr=F6m wrote:
> On 2007-05-12 14:07:04 +0200, Yann Dirson wrote:
>=20
> > +Patches in the stack are identified with a short name, which must =
be
> > +unique in the stack.
>=20
> s/a short name/short names/, maybe.

Hm, not sure how that would play with the end of the sentence - any
native english speaker with an opinion ?


> > +Patches in the current stack are just refered to by their name.  S=
ome
> > +commands allow to specify a patch in another stack of the reposito=
ry;
>=20
> s/allow to/allow you to/. Or "allows one to", but I prefer the second
> person here.

No strong opinion here.  However, that makes me think we should
probably use guideline for the docs - here comes the question of which
convention to use when refering to the user.  Do we address her
directly ("you"), indirectly ("the user", "her" - don't remember where
the "female user" use comes from, but we could maybe follow this),
even more indirectly ("one"), or any other way ?


> s/a '@'/an '@'/; "'@'" begins with a vowel sound. :-)
> s/position/positions/.
> s/ie./i.e./.
> s/refering/referring/.

OK

> > +bottom-most patch).  Similarly ''//top.old'' and ''//bottom.old''
>=20
> You use double quotes here, and single quotes above. What's the
> distinction?

Er... is "typo" a distinction ? :)
Confusion induced by wiki markups, probably :(


> Yes, I'm too picky.

Not a problem, I tend to be quite picky too :)

Best regards,
--=20
Yann.

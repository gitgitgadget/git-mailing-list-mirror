From: "W. Trevor King" <wking@tremily.us>
Subject: Outdated and broken online versions of user-manual.html
Date: Fri, 10 May 2013 15:02:30 -0400
Message-ID: <20130510190229.GA31708@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=PNTmBPCT7hxwcZjr
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 22:03:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UatX0-0000LY-M9
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 22:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab3EJUDC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 16:03:02 -0400
Received: from vms173021pub.verizon.net ([206.46.173.21]:39410 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab3EJUDA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 16:03:00 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 May 2013 16:03:00 EDT
Received: from odin.tremily.us ([unknown] [72.68.85.10])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MML005OSJK70L00@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 10 May 2013 14:02:32 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 2B373999C89; Fri,
 10 May 2013 15:02:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1368212550; bh=T51WPB4akmfnkPK4TWGVmVVO2dyQ04KybQwp5XK1u0M=;
	h=Date:From:To:Subject;
	b=mDXia+iwYh0J814LhOZ2kw48BQ8GTm6mXsMaNj+L21AG2bsA0kEUeQLOKjDKg+goI
 15YIWwmkr3YxYHUyECRHKEmVmifEXWm6DaqcEfAUpLk1F2pk2woQqgd84yvdFBSdKK
 WfsafG+Vx+CzyMM2fzDqG/SNjih44VtrMxNaLrNM=
Content-disposition: inline
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223901>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I went to reference some `rebase -i` discussion that landed in 3ca26e8
(Merge branch 'wk/user-manual', 2013-02-25), and I couldn't find a
version of the manual online that contained the new content.  There's
a version on kernel.org [1], but that doesn't seem to have been
updated since February.  There's also a version on git-scm.com [2],
but this cuts out after the first section (before =E2=80=9CExploring Git
history=E2=80=9D).  I'm not sure who's in charge of maintaining either
location, or which (if either) is considered =E2=80=9Ccanonical=E2=80=9D.

I'm also surprised that I couldn't find a more obvious link to the
manual from git-scm.com (I ended up taking a =E2=80=9CSee Also=E2=80=9D lin=
k from
gittutorial(7) [3]).  I'm not sure if this is intentional or not,
since git-scm.com does prominently link Pro Git, and that overlaps
fairly significantly with the manual.

Folks with Git installed will generally have man pages, so it's not a
big deal, but having current docs somewhere online to link against
would be nice.  I'm also curious if I should be linking against a
particular location.

Cheers,
Trevor

[1]: https://www.kernel.org/pub/software/scm/git/docs/user-manual.html
[2]: http://git-scm.com/docs/user-manual.html
[3]: http://git-scm.com/docs/gittutorial

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjUREAAoJEEUbTsx0l5OM86cQAJg7ePbWUMEBuBb7VvRV83Zz
GB9zGfrIta8qEywcIry1PVa6jjyy/QC5FSsMyI2cMvad+ul1vwLbdNz4nyYwrNEQ
rQukClIucPLi41N7FRJ460KoZ81rfaEPbum46s7JGy5+Qd9OuR6hLJ6fOQDOx+bx
ezlaliqGuxG1droC1o7+Hg/EQXWrF//xiUFZhwQyvdhDPy8Z4wJKiNDdWrbifhXq
1NYuyIO68n3WkoQSCvaS4PAsqx+bYmM+2NOdtk09t0ymGhRliVfGZeOjUq4v/XBa
MxoIildL/B6VG1Aa72BgNU61UAYdMyAwU94iZORhC+mJRtCGdmiwHyoQsYetTe/W
1DJlDZNVZhZk4MCtptqRBaY4tPlYa/j1rX9evqMDxLmcVHZKcZEW1O67IflyXwhe
5+Iu+sa3rka+EXDplK5JpsvaB21HW1qV4jzzl0bvkFXWzcW/LzPb6j7k8HaWgo0B
ANLXOAWjGvBepKEUuexTkix7KtOfDAOwS5EWLdApHJX94M4hr7rUOmUaGOCDPIpQ
gcjEUFObv3Gu6dUwQy3+xYi6vIbSrLykJQ8CBYLULluaTvG0fuHchPFtU+aj0tfI
UQwQq9ynyZjailpoGI4+aiqZiMY2Q44QEnfd9oakpJwkj8V9dqBzUKcavOsDXkma
AAgfo4SeEGRd2YqL/ckH
=VMuy
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 02/15] user-manual: Update for
 receive.denyCurrentBranch=refuse
Date: Sun, 10 Feb 2013 16:46:21 -0500
Message-ID: <20130210214621.GA8000@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <ba62167be6df7a6ba666373913bfd235bcc29c9d.1360508415.git.wking@tremily.us>
 <7vd2w7uajk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=5vNYLRcllDrimb99
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:46:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4eja-0001IG-JZ
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 22:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702Ab3BJVq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 16:46:27 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:54230 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756165Ab3BJVq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 16:46:26 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000LC6XTA2100@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 15:46:23 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 18B9F8798E8; Sun,
 10 Feb 2013 16:46:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360532782; bh=SYxJCNOnBQ6SpfgnJJCjPerEPS+QH+70awsBNAE4sxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XKqHY+yF3aEFS4x7ymhbDOXFbGZdjTI6m7ANiBJoY1cVMGGAhzkyQxAEMvIPeSnxO
 HTENZjDUZfdMIe3Oq9Lm27xL6VTq0Hio6jovj9wT+UVWXVEn6aL/0nmf8dxuQ5FX5K
 esqX8+xHZhDjJ0QuCnFEhwDHbWU82yWTYlcM8os0=
Content-disposition: inline
In-reply-to: <7vd2w7uajk.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215939>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 01:24:47PM -0800, Junio C Hamano wrote:
> I would not be surprised if some readers felt as if "then why not
> update it instead of rejecting?" were a valid question, without a
> bit more explanation.
>
> 	You can also push to a repository that has a working tree,
>   =E2=80=A6

Looks good to me :).  Shall I just drop this patch from v3 and leave
it to you?

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGBUsAAoJEEUbTsx0l5OM5tUP/j9N/7slV/nOjuztbPEnNZB2
Ns1jsc6UJCgDNiqwUEJR+MkQ+UGuisMwoO6wKuHkeLsXtPCKBMzWN7E87fNDxjCv
0dWFolV80anwi9qQ4RubFzaJSZU70DTf430NpSXcdi5TdmRcdR6XJMAygevnp/YD
toCLyaesLMdnlHWkRMQjOo3yo1LDHSQCDzR4owILMxlVDO86lD7telcM5ol4lB02
/P2SCUFFwRINCnCYkl/RlKWuo3LWMhpzmsI6Qy13NGLieEb3u8vDC8XkukUo4tth
GfMkKEgwUc0EnPNXlo79IDPgxDA1987GwMedfj62wde+GXX+iCxxx7s8yigunTHs
smllYsLVbGIScrz+pySb5UAUcV11BIjSaF7lTioy8ZzPpwhxmkH1MvHELt9yA2BX
YI1yTHb5tdkfM1kjRXs8ecUV09Cgiixse0UyIVWswC8TDDxmswZ5w5ZJJa1QzI0H
fUMwLVaCbj+tr6iLJVCnF/18uD3G7cxkxjshUGoG+YH/NbzgnHsCG5TDVfcnpKxW
ANXVrlWhLNnJGhrM5mdERtveJ/Xy6850hBdeMyNMTjzeCFptxroGWXgMHKI0WLXv
E/sq2eoAosTc1LP8+V0lJwNwfouM3bHIxe/SzWH9vKT8zCtRA+PiWVyRZ1JbR0xM
g2GBsWM8NQkwWj6sZpCD
=Iy1S
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

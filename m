From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 00/15] User manual updates
Date: Sun, 10 Feb 2013 17:36:32 -0500
Message-ID: <20130210223632.GF8377@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <7v621zsswg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=JSkcQAAxhB1h8DcT
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:36:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fW5-0002CB-Kt
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927Ab3BJWge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:36:34 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:47993 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748Ab3BJWgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:36:33 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI1008HC04W0X00@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 16:36:33 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 38C09879BF0; Sun,
 10 Feb 2013 17:36:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360535792; bh=2YnuAlNe67VfL+e/wno05ovHjydQ0UqPJN3Bc2lHPfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QUaWSxBsSpQ+NhQHgWcXGn7nol2hlUF9A5nAbNOLuf2mf3gE3oOMgRi9N/+p5D2XS
 +i5Lx7zHqmrWn6U/22rymjT+OBbVqZSPck667X8lNPH+kQil3F/FaBFx0UXArbPswb
 W5bgDml46uw1KJIQL0IuP9cp0BBrha885hWKCqZ4=
Content-disposition: inline
In-reply-to: <7v621zsswg.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215959>


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 02:31:11PM -0800, Junio C Hamano wrote:
> Thanks.  I queued 01, 10, 11, 13 directly on 'maint'; they looked
> not just good to me but I wouldn't expect any objection to them.

Ok, I'll drop them from v3.  I based my changes on `master` to avoid
colliding with 2de9b711 (Documentation: the name of the system is
'Git', not 'git', 2013-01-21), but if you shifted them already I
suppose you've fixed any conflicts ;).

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGCDvAAoJEEUbTsx0l5OM/kQP+wUWtSMorYGg34LxRLfnPcG+
0V/7g+GaOPILTfi1eGiz3LzbtqcV4dYRu+N4kZJGkkqpDxFWkhwdifQH9q9APPhb
g5iMBT87KHjcNgxEQaIh81pCnN0rYkyr7CnT7i6MvtOSHZ8ZM9HBXuYwP5GlPBh+
HN06qWjh+g8nDsJLTgoNRxc4tKaZaMY1+hOMYPeKHzn2+8GPrrJ2Ubg9flqK0D/k
103ZePqAfGQgOMF7h9MYeBfoahFfMuQ/W8jb7/QjqxVVqM+Qv6xkWqDP9PgTmYVI
jz3YOzzX6ACEEImEfqhXlHDMsDzBP05m/7fWSJM9y+MKTPi8U7rcCk49Vm46ugu3
cd+DqeaUXe6SIc1QwPmaXJ+fO543StUtfeiZroEAVz8L2CnJ4U8Oq2uUhZTMZJ7b
cBqppE4k1rU10MeOuQCjUN3WlKMv/sw+D/C3O415//kpiBumBNwV3oWYO8JI26lD
EGkIHNJrA951B633kDS921IWjYI9vn8pLzE/ffDAQzo5y0Pi8ogD/GuLa9K3T9Up
aHHxug7o+QdJ+aoewIx9GwzgVL6LaUq5wuW+za1VM4Z0Wu46FXLmou5kujIuDs5m
qRU5C/CLPQaKr1QC5JRNu0AKzIMpUuAwKlyXN3HZYD3o+V9lp1m9wGlgQ/dts9BC
t9R5pTK08va0Gwe7qcbz
=o8nl
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--

From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [PATCH v3 4/9] user-manual: Mention 'git remote add' for
 remote branch config
Date: Sun, 17 Feb 2013 21:41:21 -0500
Message-ID: <20130218024121.GD5936@odin.tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <1ef8fd5d7754ef65a9aaf26250b7b9f0488ff59c.1361146398.git.wking@tremily.us>
 <7vwqu6cq7i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=PHCdUe6m4AxPMzOu
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:41:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Gfw-0001dQ-T6
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 03:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756408Ab3BRCl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 21:41:28 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:41280 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321Ab3BRCl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 21:41:27 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIE0031XA4XPK70@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 20:41:27 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 64F098858B0; Sun,
 17 Feb 2013 21:41:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361155281; bh=u/xIbaVTzH4DTE4alm5J9sXcCPk20pmotM9Q79JpuPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=o3leeEE/Tf1G2UrNUKOrQSOvizwSpJfeiZ7eqra1PJB9cxoENb6bC4EF/QgpVVko0
 0j5u6lyONRMsOE2yaq5nPPS0xgxRwKcUnLCuyyUNNhZ0gjSCmjruzvsJy25DQkUlmW
 fDKtH1ohBlo8X+JYEnyqartAsg80KIEYnqKF2XGI=
Content-disposition: inline
In-reply-to: <7vwqu6cq7i.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216432>


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 17, 2013 at 06:26:25PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> >  -------------------------------------------------
> > +$ git fetch git://example.com/proj.git +refs/heads/*:refs/remotes/exam=
ple/*
> > +$ git fetch example +refs/heads/*:refs/remotes/example/*
> >  $ git fetch example
> >  -------------------------------------------------
>=20
> These _three_ commands will do the same.

Oops.  Feel free to fix this for me, and consider the revised version
signed off by me ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRIZTQAAoJEEUbTsx0l5OMKBwP/1a2QRFlFC1OBXvX7m9aGqO4
/S7bJ00zxRktWy/ARMHDef9poH1753OoTgeZvkdrx6RuVEZKHeD/EqaDoxCh+rtU
lA/QDAJab91fPuqz9fUDrWZAxWDkDY0uIE4xNaWQXRflc32AS6rq0AQtRmjvgQ9d
+NgHjtYGN10JCSBml53lcyaHLYap+YlvBz/0TRlBINI4umBPJkSZu6U+KmZo0B6F
lqpUbmpL+CGoetWhv9DMQPqUiDIuE9NEsGS8d+JJE0fU4JYrFR1DShy5CCBqE+n6
iR900oblRKcGsaXlL5y42ZMMod8uhwTxDcw4rXuI/L4xMNZelujHKV9xuuFNmLql
GOzS2UGMLJ3TXa/QTlbPcX4IEekkx+gTIMCslHrvxJcw4J3/zhkLMA6qnyPSn0Zz
1n470dja1pMth9m/JVJUVq1S0iAUW5qbAo2S4l3OCPv8kvt3/+nY7Q7l6A5jpQi6
tOCYMfcAFDYGL2uuePR1bCdzFDZsYs2CTO+WQReNkaVaH3N8nWmtUQyHX4E8u7u6
ICYDIfEpcapfJHTjfNpnRnQjIR8GUuTASZRwzUq+HwQpwFcXLgHF8rLK7DGk1TNl
f2Bkp1bKZk7/Jhdn+5TxBGZ5OvtKNQ18TyxyMRL3sAuWPRFRMqmuy6REvaeMg1uU
YsQf9+TMrZV4x5CKi5nL
=57Y4
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--

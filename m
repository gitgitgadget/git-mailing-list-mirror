From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Moving (renaming) submodules, recipe/script
Date: Mon, 07 Jan 2013 07:08:48 -0500
Message-ID: <20130107120848.GA28559@odin.tremily.us>
References: <20130107003603.GA25698@odin.tremily.us>
 <20130107013952.GE3823@elie.Belkin> <50EA7269.1080006@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=CE+1k2dSO48ffgeK
Cc: Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 13:09:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsBW8-0002zA-Et
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 13:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351Ab3AGMJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 07:09:04 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:60453 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004Ab3AGMJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 07:09:03 -0500
Received: from odin.tremily.us ([unknown] [72.68.82.220])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MG9001SR8EPCS60@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 07 Jan 2013 06:08:50 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id EE26077BE5D; Mon,
 07 Jan 2013 07:08:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1357560528; bh=Ix9FlZNUP5dYMS2JhJm+JH/+yAhEcDoAAMmeBAw/5UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=s3xSl9CvFaF3Miadkg6XniiVMpUg1dtrI/zaOWiuORK+kHnv1gHM8Gy0mH8AdWLNB
 M0OAePaBeoZyTjiJEoyaGMH0WPLcIumzYmLp6l/glUcXDWFkJxQpQ2KCzIKheJ78X4
 gLa5BbeFmYhUDwcgAeYc+BhSenRsVWHdfQsuYLVg=
Content-disposition: inline
In-reply-to: <50EA7269.1080006@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212892>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2013 at 07:59:53AM +0100, Jens Lehmann wrote:
> I=B4m currently working on teaching mv to move submodules and intend
> to send those patches to the list after finishing submodule deinit.
> Please see
>   https://github.com/jlehmann/git-submod-enhancements/commits/mv-submodul=
es
> for the current state of this series.

Ah, that will be much better :).

It looks like my script tries to do all the right things though, so if
anyone needs to move a submodule before Jens' branch lands, you might
want to give it a try.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ6rrPAAoJEEUbTsx0l5OMGUMP/3lbBosBV4ez7ORcES6noQ0i
Y+CjGaZZZ0D8XJaXHgfKNXrXaEc9wNLVW4hm4Jn0cAOHnCrjC4hUJNdn1ycwisnf
EqwCtfluNCM6gWY6GNwny+uU0pHDz9xJeD4BV4aZcMxRckj5CTTLmFIClKTv/onR
AuYVee7U4lHgx6mEo8SdHWV+KXMFBxrybtCjOrW0mAssRR3Xzd7HBmsH2m6ogXgU
nJyxZy3DJ7SehTC4JC0Rk5JNMdjpvJoucsNq04FVyQ5UgVKLZyImSUzOoeURK52e
2TvfDGtGLyoA05aNHaCuN3/B4oDqGGUxQE+buh4voX4LwTLtRi91o7wc80J/XAci
aUsXrC3R5l13XpzkfxDVwGticZiCbcGkd7xh7ezLdA1OdINyQ4tG/XJdj5mMdRYr
dAR2X7Ule3N96cFCRa2ec8hxiLxIamn6bi1CXf0wAnKczHPgMLhu6npm413VjHXH
CeZqYmmfZOfhEzXmARzUXUWNSczerdRdZlQU49GTRCjKI4cKC+qQywqgco9aE50j
4uCPp6KaQRNUpJB71jR1x2X2Zd2pv+FC1ydffrxZGGenq1lVqvu9tS66QdugY5qC
H1fMkzH+nHxch5LbHfjn7JU3jXnZGPwVP4Jwbn1b58bwdQ6lfdL5952Z9P0CruJx
TFEheDKbiJvRMd67J3yL
=cOcz
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

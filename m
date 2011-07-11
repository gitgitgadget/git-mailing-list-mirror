From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: Strange characters
Date: Mon, 11 Jul 2011 10:51:11 +0200
Message-ID: <20110711085111.GA6594@bee.lab.cmartin.tk>
References: <1310066131287-6559596.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Cc: git@vger.kernel.org
To: bryceadamprescott <bryceadamprescott@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 10:51:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgCD1-0003Cy-6P
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 10:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468Ab1GKIvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 04:51:13 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:59542 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757439Ab1GKIvN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 04:51:13 -0400
Received: from bee.lab.cmartin.tk (z39c5.pia.fu-berlin.de [87.77.57.197])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id DF96B461FA;
	Mon, 11 Jul 2011 10:50:32 +0200 (CEST)
Received: (nullmailer pid 25587 invoked by uid 1000);
	Mon, 11 Jul 2011 08:51:11 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	bryceadamprescott <bryceadamprescott@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1310066131287-6559596.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176836>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Jul 07, 2011 at 12:15:31PM -0700, bryceadamprescott wrote:
> I've used subversion before but I've only used git a handful of times. At my
> new job I am using git and me and my boss (who is also new to git) is having
> a problem with UTF-8 characters. It seems that git is replacing some
> characters here and there with strange UTF-8 characters that display as a
> question mark in a diamond. Strangely enough the code still compiles with
> thousands of warnings about the UTF-8 characters. Any help would be
> appreciated.

Git shouldn't modify the contents of the files at all (except for
line-end if you ask it to). Could you provide a reproducible example
of what's happening?

Cheers,
   cmn
--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOGrl/AAoJEHKRP1jG7ZzTEdoH/3i6gHHk4G8RZhHYEsV+3vov
aG/2qaL3OhDt0L9tRvI8OBYAF9KGEN2O7hKcty8/l8tu0QivNJwMJ/E0FG485Fcw
gv03At2dA6FwI0C4elmXBTeY+sKk0P+C0bA0hTFDPYHPOXvJeclZVWf5Z+H8UYjJ
iGzeBcvuObZaySiY1H75aHtiEDdl2tFC7WWtn4us7KtCNJh+Gf9x+9ASG0CHTRPX
wnGIuX+efEOAUjheG6rgc4/PKNYZfJ510GadbpwN3c4S27Mt1EYesTPZf8atwtNh
MAEguz7KhjHg4ckWsroCw4W+QK6Ipmtv03Dik9ZZ7L/afSaAPO4pKj1BOs3V5DM=
=onUd
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

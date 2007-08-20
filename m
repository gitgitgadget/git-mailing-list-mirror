From: Jan Hudec <bulb@ucw.cz>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 22:08:15 +0200
Message-ID: <20070820200815.GG8542@efreet.light.src>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org> <867inqhyuk.fsf@lola.quinscape.zz> <20070820181357.GA8264@glandium.org> <86zm0mgicy.fsf@lola.quinscape.zz> <20070820184829.GA8617@glandium.org> <20070820194328.GE8542@efreet.light.src> <20070820195037.GA9774@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 22:08:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INDXz-0006w1-F6
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 22:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXHTUIU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 16:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbXHTUIU
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 16:08:20 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:58800 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbXHTUIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 16:08:19 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id B44C457482;
	Mon, 20 Aug 2007 22:08:18 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id IPRoNqOiZxVT; Mon, 20 Aug 2007 22:08:16 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id DE89157407;
	Mon, 20 Aug 2007 22:08:15 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1INDXr-000719-Gq; Mon, 20 Aug 2007 22:08:15 +0200
Content-Disposition: inline
In-Reply-To: <20070820195037.GA9774@glandium.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56249>


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2007 at 21:50:37 +0200, Mike Hommey wrote:
> On Mon, Aug 20, 2007 at 09:43:28PM +0200, Jan Hudec <bulb@ucw.cz> wrote:
> > Git does not have tracking of file's history either.
>=20
> Well, it has ways to track file's history, with blame and log, for
> example. There is nothing similar for directories, though it could be
> possible to do.

Neither of them is file's history. They dig in the global history for
records, that are, by some heuristic, related to something. Blame really
looks for a bunch of lines and log looks for given path (can be whole
subtree).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGyfSvRel1vVwhjGURAozxAJ4o2Cl+hzgwlFcWvEa9sxd1rj35FgCfTmRR
ea62mtglg9klcf7UqYcfcmM=
=axi2
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--

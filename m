From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] bash completion: git rm has grown a --force option
Date: Fri, 8 Aug 2008 21:21:58 -0400
Message-ID: <20080809012158.GI5655@inocybe.teonanacatl.org>
References: <1218235022-33695-1-git-send-email-pdebie@ai.rug.nl>
 <7v8wv7az0z.fsf@gitster.siamese.dyndns.org>
 <20080808234134.GH5655@inocybe.teonanacatl.org>
 <20080809010713.GF7299@neumann>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8SUh+pnhVixfgwb7"
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Lee Marlow <lee.marlow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailinglist <git@vger.kernel.org>
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Aug 09 03:23:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRdAu-0005sV-J5
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 03:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbYHIBWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 21:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753919AbYHIBWP
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 21:22:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbYHIBWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 21:22:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A9484F9B7;
	Fri,  8 Aug 2008 21:22:11 -0400 (EDT)
Received: from inocybe.teonanacatl.org (c-69-248-23-23.hsd1.pa.comcast.net
 [69.248.23.23]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix)
 with ESMTPSA id 728884F9B1; Fri,  8 Aug 2008 21:22:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080809010713.GF7299@neumann>
X-Listening-To: The Bad Plus - Keep The Bugs Off Your Glass And The Bears Off
 Your Ass
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Pobox-Relay-ID: 974BD06A-65B1-11DD-A920-CE28B26B55AE-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91738>


--8SUh+pnhVixfgwb7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

SZEDER G=E1bor wrote:
> I disagree here.  '--force' is an option that should be used with
> care, therefore facilitating its usage by completion support is not
> a good idea IMHO.  This is also the status quo:  while there are
> many git commands with a '--force' option, we do not complete any of
> them.

Yes, my apologies for missing that point.  It is a good one.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A word to the wise ain't necessary -- it's the stupid ones who need
the advice.
    -- Bill Cosby


--8SUh+pnhVixfgwb7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBAgAtBQJInPEwJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzj6L0IAJXfOCJHvZbLyxv93KQKog9Kb3Dx3xFClxs/
XiEVZhDLlyCWHb0mhzZTE+jvuiqhs1t+eAjBXmacyBC4JMn37x5q4Ux3yv6LVNCM
cAe7MSTnGw8ISaYolN5I4F/YPuSJyCnAJaZ72ClXeS5vE/Kp+cOZNRjrxTeGDCIu
Q5KpTb4mIHpCNCs9ftpFEnB+AGUVzxDTjItokvoi0ZDBOvJP/U8iNOi6mMjPJRhr
O9Pd19+L1jaVIoPmSgq92NOG0tJ1vQXKSPiiPslpqCrhJrGX2kq4XY/zFk7vZnyF
WDASfOISNCF1BzsfjtybIULWjuSM/9SybQbxK7EumItlfkNSfFk=
=PW/t
-----END PGP SIGNATURE-----

--8SUh+pnhVixfgwb7--

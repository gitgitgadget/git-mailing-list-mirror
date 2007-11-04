From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 04/10] Migrate git-clone to use git-rev-parse --parseopt
Date: Sun, 04 Nov 2007 15:49:18 +0100
Message-ID: <20071104144918.GI26269@artemis.corp>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org> <1194172262-1563-2-git-send-email-madcoder@debian.org> <1194172262-1563-3-git-send-email-madcoder@debian.org> <1194172262-1563-4-git-send-email-madcoder@debian.org> <1194172262-1563-5-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="VkVuOCYP9O7H3CXI";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 04 15:49:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IognD-0005YA-QI
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 15:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbXKDOtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 09:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbXKDOtU
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 09:49:20 -0500
Received: from pan.madism.org ([88.191.52.104]:53686 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755892AbXKDOtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 09:49:20 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 08737285DB;
	Sun,  4 Nov 2007 15:49:18 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7B14A83EF; Sun,  4 Nov 2007 15:49:18 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1194172262-1563-5-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63413>


--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Note: this patch now conflicts with a recent patch to make git clone
grok `--`. As git rev-parse --parseopt does that as a side effect, you
can force the update to the parseopt version without functionality loss.

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLdvuvGr7W6HudhwRAs4mAJsGCFsQG7Imnu82lwBFndF4v/VWuQCgpaML
6BIzNU9ZWdS9YAReRfTu6Qs=
=JOqC
-----END PGP SIGNATURE-----

--VkVuOCYP9O7H3CXI--

From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Make gitk save and restore window pane position on Linux and Cygwin.
Date: Tue, 13 Feb 2007 14:10:37 +0300
Message-ID: <20070213111037.GM23550@master.mivlgu.local>
References: <11713259742627-git-send-email-mdl123@verizon.net> <7vbqjy7t86.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iKKZt69u2Wx/rspf"
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 12:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGvYb-0002Yy-DO
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 12:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbXBMLKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 06:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbXBMLKm
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 06:10:42 -0500
Received: from mivlgu.ru ([81.18.140.87]:45607 "EHLO master.mivlgu.local"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751280AbXBMLKl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 06:10:41 -0500
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id 5EB32180119; Tue, 13 Feb 2007 14:10:37 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <7vbqjy7t86.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39515>


--iKKZt69u2Wx/rspf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2007 at 05:15:53PM -0800, Junio C Hamano wrote:
> This looks sane to me, although a bit twisted (and again it is
> not Mark's fault).  Sergey, Ack?

Yes, current git (85b1f988) works for me.

--iKKZt69u2Wx/rspf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFF0ZytW82GfkQfsqIRAqqKAJ9ZAg/1ZOnqQpjciGpydbARQEQI0gCglDyp
0CSFUrw8981mulvlwhIRI7w=
=cyaU
-----END PGP SIGNATURE-----

--iKKZt69u2Wx/rspf--

From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Mar 2009, #03; Wed, 11)
Date: Wed, 11 Mar 2009 23:37:28 +0100
Message-ID: <200903112337.36799.trast@student.ethz.ch>
References: <7vvdqg5s17.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2935138.1V4og2WDxn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 23:48:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhX5x-00089w-0x
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 23:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310AbZCKWiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 18:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbZCKWiN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 18:38:13 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:27351 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753530AbZCKWiM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 18:38:12 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Mar 2009 23:38:08 +0100
Received: from thomas.localnet ([84.75.148.224]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Mar 2009 23:38:08 +0100
User-Agent: KMail/1.11.1 (Linux/2.6.27.19-3.2-default; KDE/4.2.1; x86_64; ; )
In-Reply-To: <7vvdqg5s17.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 11 Mar 2009 22:38:08.0620 (UTC) FILETIME=[0D28A2C0:01C9A29A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112987>

--nextPart2935138.1V4og2WDxn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> * tr/gcov (Thu Feb 19 12:13:42 2009 +0100) 8 commits
>  + Test git-patch-id
>  + Test rev-list --parents/--children
>  + Test log --decorate
>  + Test fsck a bit harder
>  + Test log --graph
>  + Test diff --dirstat functionality
>  + Test that diff can read from stdin
>  + Support coverage testing with GCC/gcov
>=20
> * tr/maint-1.6.0-send-email-irt (Sun Mar 1 23:45:41 2009 +0100) 1 commit
>  + send-email: respect in-reply-to regardless of threading
>=20
> Tests?

I see you got tired of waiting while I was out drowning in work, so:
thanks, especially for fixing up the fsck test!

I'll follow up with a test for the latter topic shortly.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2935138.1V4og2WDxn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkm4PTAACgkQqUud07tmzP0J7gCfVA/rtbqgKp7TFgJj5Z/Sj4mc
WfwAn1b3JDeWbECFKGH6XCqwSP1ghY/A
=iKiW
-----END PGP SIGNATURE-----

--nextPart2935138.1V4og2WDxn--

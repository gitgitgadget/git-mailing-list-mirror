From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Checking for "diff.color." should come before "diff.color"
Date: Mon, 23 Oct 2006 21:52:48 +0100
Message-ID: <200610232152.48543.andyparkins@gmail.com>
References: <200610232051.17396.andyparkins@gmail.com> <20061023202952.GC31068@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1462915.XGHW7DPcdB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 23 22:55:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc6pX-0004gR-Dm
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 22:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWJWUz2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 16:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWJWUz2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 16:55:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:43318 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751049AbWJWUz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 16:55:27 -0400
Received: by ug-out-1314.google.com with SMTP id q2so1507568uge
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 13:55:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=ssOyV/grzDNdWBsnRYDLkC9fkzAvyXCoPammdxeO1bIc6QoKvE0t7OO/p7dCTJ4W/+eNuyRAUzFLPMqy3lulLY0aPEkaUf1tnU+3T70anxOiaxfUSjqoFy5Q/f3zoIAb9o6wdDFbMmybmmmbaQuB3JSDywvj7vEmWqqeOC/cLtU=
Received: by 10.78.204.20 with SMTP id b20mr8051255hug;
        Mon, 23 Oct 2006 13:55:25 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 30sm13023hub.2006.10.23.13.55.24;
        Mon, 23 Oct 2006 13:55:24 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <20061023202952.GC31068@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29879>

--nextPart1462915.XGHW7DPcdB
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2006, October 23 21:29, Jeff King wrote:

> No, it's a strcmp for "diff.color", so it must match exactly. The code
> is fine.

Oops.  Yep.  So far I'm zero for five on my git patches - not doing too wel=
l=20
am I?  :-)

> Are you experiencing some bug, or was this just from poking through the
> code?

Nah; poking around only.  I'm playing with git using the git repository.  I=
=20
have a feeling it's making me noisy and annoying.


Andy

=2D-=20
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com

--nextPart1462915.XGHW7DPcdB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPSugwQJ9gE9xL20RApsYAJ90bWvgbF5LialJZlMt9ZcYVQse3gCcCzm9
p+ND6IsYriWoMKj16V0Vw88=
=fXaH
-----END PGP SIGNATURE-----

--nextPart1462915.XGHW7DPcdB--

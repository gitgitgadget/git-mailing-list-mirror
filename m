From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [ANNOUNCE] CGIT 0.9.0.1
Date: Mon, 13 Jun 2011 09:49:19 -0400
Message-ID: <20110613134919.GJ14016@inocybe.localdomain>
References: <20110613124954.GA737@hjemli.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="pN9MePJoZbRKbUk1"
Cc: cgit@hjemli.net, git@vger.kernel.org
To: larsh@hjemli.net
X-From: git-owner@vger.kernel.org Mon Jun 13 15:59:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW7fm-0002Td-VB
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 15:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317Ab1FMN7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 09:59:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40512 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802Ab1FMN7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 09:59:17 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jun 2011 09:59:17 EDT
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FDCA35A7;
	Mon, 13 Jun 2011 09:49:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=OJod1satcMWaCUYHWvGbue2b/WE=; b=IX18+dY
	E1wI4SsFYL0lWtniwk+YzsU76S3fKJYgOjxcXPIN0zdjBAuORlz+/3WR2PNDHRdp
	p8z6ILqWf4ONZaZJ1abnm7gYj3OrKx1ts2zbuTwZP7i+tmP5dyCkKZuJPUf++tZS
	1i1fEfgWpaOhyWu/LqW1J6MHppRcjt2KeCI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=fQr89nrytoJBKrwlGpEuguumLGeU+df8+
	cJk4f+CvKuOaT6MnTQJWs0NTTscEfOOKkW54MkfpqVMeGs5mMXm/nTVRm4HheHho
	moidJMiXU4UYczTdAKX+8lZxVvpQnz8Agc/+1bubFHwkUtmZJdxzO70t9isgr4q5
	JUIA0QKAKU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7144535A3;
	Mon, 13 Jun 2011 09:49:23 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.8.104]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F083C35A2; Mon, 13 Jun 2011
 09:49:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110613124954.GA737@hjemli.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Pobox-Relay-ID: F2149938-95C3-11E0-978E-E3BBA763C5D2-09356542!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175706>


--pN9MePJoZbRKbUk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lars,

larsh@hjemli.net wrote:
> A bugfix release of cgit (a web interface to git repositories) is now
> available from http://hjemli.net/git/cgit.

Did the v0.9.0.1 not get pushed yet?

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Once ... in the wilds of Afghanistan, I lost my corkscrew, and we were
forced to live on nothing but food and water for days.
    -- W.C. Fields


--pN9MePJoZbRKbUk1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJN9hVaJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzj9eQH+QG8/s50lJ17hG7EgXIbl+ofAqjhUaJiadgq
pfzDODUTYp/UplLubpUrF5qKs9+lBDvUX+aUXUeozw6CXy+H0ra044WOA4xTQWqy
L4EpvI4/Yz9clNoiGodzIM0s9lFlFAFgXlq/BAGYFLYhm3AmJ2wFrZCZv2N4jGOQ
AjUk8xvkaFXaWhwjJzBxcisZ6DBd+yz+G7N8l77FZaKZXFAV4+8IPhq6AZ4CD4Bh
3rBCG7BVnqKcQZ2Z1DoS4fkfFgq5hDgmpfdcHwxUk+oOKTj+zwmHr2oF3tnqTNps
vVga6gdo6o0g2SgaC72QXFWReij2UpAT15Y48Rrt1lDK+uKUXzo=
=FAdd
-----END PGP SIGNATURE-----

--pN9MePJoZbRKbUk1--

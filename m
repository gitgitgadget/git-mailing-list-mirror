From: Todd Zullinger <tmz@pobox.com>
Subject: Re: installation problems with version 1.6.5.4
Date: Thu, 3 Dec 2009 15:22:41 -0500
Message-ID: <20091203202241.GO23717@inocybe.localdomain>
References: <20091203200921.GA29478@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="9Jdw4pA1x1k2W7MG"
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Thu Dec 03 21:22:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGICT-0004Po-Ho
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 21:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbZLCUWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 15:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753510AbZLCUWk
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 15:22:40 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbZLCUWj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 15:22:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7006685847;
	Thu,  3 Dec 2009 15:22:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=KmAhmrTyCwvnhaQP8wz9EDxrEYc=; b=SgUfDrk
	VXh1l2/BHrHcEHKPnPcxyLqB6yaUU8DVK1uN8OpoS/kRymh7TpmU2HbLctpGJm6S
	OZ6SB9BYxgDsABx7OmM8DleCGdgNoUn15VFJfsRCUSr/nDOhgEWCbici+uLczFrA
	di1Ks+VUM7OgoaZFNxuvOzkr+fhl7GQhdlLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=C3ipFzsnyNKxNyv5Kb2D1dDOW6PRcwh4a
	2fZqj4PY3oL5/3q4dOBRNf5PYlVZjljapmklMptekdBOh3MhpNk0XBY9dnL5K9Uo
	pCHmplEseoO7bJ5+VLe7dkdOjCIeKmTWtw6SsIbNvlwMVu9IIuzrB9LjGXNozqd9
	5P0Nu9c2jQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D822D85846;
	Thu,  3 Dec 2009 15:22:43 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E91785845; Thu,  3 Dec
 2009 15:22:42 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20091203200921.GA29478@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 9CFA1558-E049-11DE-8792-9F3FEE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134473>


--9Jdw4pA1x1k2W7MG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Oliver Kullmann wrote:
> I get when installing 1.6.5.4
>
>     GEN technical/api-index.txt
>     ASCIIDOC technical/api-index.html
>     ASCIIDOC git-add.xml
>     XMLTO git-add.1
> xmlto: unrecognised option `--stringparam'

See http://thread.gmane.org/gmane.linux.kernel/921919/focus=3D134449 and
follow-ups.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Fleas can be taught nearly anything that a Congressman can.
    -- Mark Twain


--9Jdw4pA1x1k2W7MG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJLGB4RJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjCJAH/1NP0qHok759he3tGZcSqeaWapGeXoIxyVVJ
YVJoDS+/F9u3JKXRUoKVcULfeOpSk+NqSagk+3sBogxskpF+uTh7D1Tij6w6+m25
iXS12ebu8amXLGjxbq7KD2XGrw997/FR5WMrNgXJyrcaaDlF1ekUPCBx76AoYuAp
Ck6fIK9LKjVp0TUGNf6DSUxoU8ZHHI4UQswEoTPlolsiZTQ1ZO9xd+/HE8AfH8x3
rknDe3aI8cfYfxb7w+II8RWN9G6Iq8ur7C1ff758nUN4NgF0CwYBMLO7NVEwgdRW
sCu7+btIc9qlO3BnZjIftdxj8T9c2S/lxrYwYG0FKBXGIz/vdPI=
=jGAS
-----END PGP SIGNATURE-----

--9Jdw4pA1x1k2W7MG--

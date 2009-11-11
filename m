From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.5.2
Date: Wed, 11 Nov 2009 18:18:51 -0500
Message-ID: <20091111231851.GT31109@inocybe.localdomain>
References: <7vljiypw9s.fsf@alter.siamese.dyndns.org>
 <m3ljicsrg0.fsf@localhost.localdomain>
 <20091111215952.GR31109@inocybe.localdomain>
 <7vfx8kn1h7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="GTjM2GI4zMe3xHZ5"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:19:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8MSu-0003Hm-IO
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759597AbZKKXSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 18:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759561AbZKKXSy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:18:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759551AbZKKXSx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 18:18:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 90DF87D384;
	Wed, 11 Nov 2009 18:18:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=8/Om6MkQcfs8aZu+4UdooFj5P6w=; b=MEgT9wG
	xeWbmEqdy6qSnYIkMq2HMmmA3IyFjY69I5FxjjKC2FEi8WWZfDNdusv5n7Xee+1B
	8NIWIa1NnTdrsPAp76JUAuwzsc2viT8lrtuqvakg1KY5Us9OslVU4OhHu8J6V5wQ
	2/OG4ytQpoOEWOtxs0VosfxWbHYdGbGw5+oY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=Z1HfqrgWSkeu5bTWRcgArovuREbgYofmb
	Ov9vJw18JPBfBbtjICGCzy1LTHtbA6DI87BDntH+Nc7O9VqhfZOnxM0Rkv3C3F4X
	nlh4rYJ8lFg9cquXtRBDkoMNgyLs5y3VZP8ktMgP2xevMY0S0ltfGB5mZqUX0i+2
	Q92zsbU+kU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CB6F7D380;
	Wed, 11 Nov 2009 18:18:55 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF8A97D37E; Wed, 11 Nov
 2009 18:18:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vfx8kn1h7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 9506BE10-CF18-11DE-BAF8-9F3FEE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132719>


--GTjM2GI4zMe3xHZ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Thanks; will try.  Will that have adverse effect when instsalled to
> FC11 by the way?

None that I am aware of (aside from using a less secure file digest
algorith, of course :).  I've installed packages built that way on
Fedora 12 systems without issue.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Blessed are they who can laugh at themselves for they shall never
cease to be amused.


--GTjM2GI4zMe3xHZ5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJK+0ZWJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzj8RgH/17FnvsibvcyvFP4xUnuHH9lgXEYs0Vpj4mu
CIcgjNGcetqBDBTs2/uNGrYB+mQpV6uL//9nOmcJomWyDZLH9yDyI7an/BRM59yD
d8FHo9zKA8wGAPogxgVr9qrZr9w5IRHXgXjO4cuFxpDx2A3eF3fDjGKgfdGLiPYW
UG+AN8OD42cLXEEFhukb+3Ptn/FUAaduk4l6zDK7xCsFfZe1nRERCBnN62U2XNYv
X0I0Nw0+4LtlN5XNdg4jolzQyK9LeKkP3O+6PCNRBI7bvq5NJR0UFl8BgsXfxImT
NbEDxRl1goMoXqmb7TFIQRusO5QT2lm/SXt9QHx8+onMIwY8Xzo=
=GNtB
-----END PGP SIGNATURE-----

--GTjM2GI4zMe3xHZ5--

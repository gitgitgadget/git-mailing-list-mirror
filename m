From: Lars Kellogg-Stedman <lars@redhat.com>
Subject: Re: [PATCH] add support for specifying an SSL cipher list
Date: Thu, 7 May 2015 12:58:41 -0400
Message-ID: <20150507165841.GD16334@redhat.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
 <xmqq8ud0s7sv.fsf@gitster.dls.corp.google.com>
 <20150507160413.GB16334@redhat.com>
 <xmqqvbg4qreq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 18:58:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqP8M-0000bO-4I
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbbEGQ6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:58:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbbEGQ6o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:58:44 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t47GwgYJ021202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 May 2015 12:58:43 -0400
Received: from lkellogg-pk115wp.redhat.com (ovpn-112-66.phx2.redhat.com [10.3.112.66])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t47GwgRB021131;
	Thu, 7 May 2015 12:58:42 -0400
Received: by lkellogg-pk115wp.redhat.com (Postfix, from userid 1000)
	id 658ACA0E2B; Thu,  7 May 2015 12:58:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqvbg4qreq.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268552>


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2015 at 09:33:01AM -0700, Junio C Hamano wrote:
> If you are changing the behaviour in your reroll, I suspect you
> wouldn't be doing the common "override".  If you are going to do the
> 'reset on empty', then 'You can set the environment variable to an
> empty string to reset to the default cipher list used by libcURL.'
> may be a natural way to describe it.

Thanks for your comments.  I will work on rephrasing things a bit.

--=20
Lars Kellogg-Stedman <lars@redhat.com> | larsks @ {freenode,twitter,github}
Cloud Engineering / OpenStack          | http://blog.oddbit.com/


--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJVS5nBAAoJEOTYsrE/X54psbYP/iG7a5PykshN2eyz6Eam1KRU
IH189PJJJzdkvis1KkA7xv5oQcrrflafO1Stnmz/r9eMMc97fKXDlrYaYUwiyZAi
RCh+xpQbLq7YDJ4s+D97O6u85SHttGTKu95t/zYNP4f8vhp/9rlpkHdB+nVFIOmj
sr8ykubrFcIFYHnkTtOJM/OG04+F+v049O6HrVjbUxcEwgQZhoYzvdDai9LCrqoE
RPCasDZFZcu97/UfyuDCqbXv5Hg/UuzIYjV5QBIBWnUvPs+M2Ebdi7OZrjRUJt2I
BlM9Jp9FQi777txEMRkxtlkaR/mG5w6RSpNb3F0QyzeihFJRXqsKGLOLEc1BHTlW
8X4C9xlHiuKetIjy7Y5q5woE3a0UDmDJo560RMfm786scB9RNJ9VCz+qBaMhwCG2
AoxjuFyaEwYc6eMJ8rahwK5QtyuTtaGNB3XZAMz2UiSKg+BGDtfDXEMpC7Fc1VgJ
IMMxBJM0YrY9s9dKvBZq51LDCyqLU5XHs3XwbDCHaGEXOknadUNeiNGgCbcGxUC4
hhi2vZpolhKObwABxZEVy3lIxXegB5Wp+T+MAgNed03onK21k9C/BJvTV8zlEnTQ
nq+BXtdRAZrMScmQYpmpEOWj0LCJMK04cTL3UK3lOhFADuY+X5b0yymyN8pL1hpn
72ae7v21MGE9+Z9iQLHc
=5P9U
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--

From: "Michael P. Soulier" <msoulier@digitaltorque.ca>
Subject: Re: dumb protocol problems
Date: Fri, 4 Jul 2008 15:19:24 -0400
Message-ID: <20080704191924.GV28001@tigger.digitaltorque.ca>
References: <20080704190007.GU28001@tigger.digitaltorque.ca> <7vbq1dv51e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xYeFQzU4VZLrHqxU"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 21:20:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEqpo-0004hr-5p
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 21:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbYGDTTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 15:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbYGDTTq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 15:19:46 -0400
Received: from mail.storm.ca ([209.87.239.66]:33315 "EHLO mail.storm.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbYGDTTq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 15:19:46 -0400
Received: from kanga.digitaltorque.ca (hs-216-106-102-70.storm.ca [216.106.102.70])
	by mail.storm.ca (8.14.2+Sun/8.14.2) with ESMTP id m64JJUhK010242;
	Fri, 4 Jul 2008 15:19:35 -0400 (EDT)
Received: from tigger.digitaltorque.ca (tigger.digitaltorque.ca [192.168.1.3])
	by kanga.digitaltorque.ca (Postfix) with ESMTP id 7166A6;
	Fri,  4 Jul 2008 15:23:08 -0400 (EDT)
Received: by tigger.digitaltorque.ca (Postfix, from userid 500)
	id E67DF23F8A; Fri,  4 Jul 2008 15:19:24 -0400 (EDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vbq1dv51e.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87412>


--xYeFQzU4VZLrHqxU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04/07/08 Junio C Hamano said:

> That snapshot lacks this fix:
>=20
> 	6eec46b (fix sha1_pack_index_name(), 2008-05-28)

Confirmed, it works now.=20

Thanks,
Mike
--=20
Michael P. Soulier <msoulier@digitaltorque.ca>
"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction." --Albert Einstein

--xYeFQzU4VZLrHqxU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFIbne8KGqCc1vIvggRAryFAJ4yj47FWJi9tLxGzkPSOunzMz3LMQCggyQs
+9EZcmubOxEXmD4tHXhEaBM=
=d2uk
-----END PGP SIGNATURE-----

--xYeFQzU4VZLrHqxU--

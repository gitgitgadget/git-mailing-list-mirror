From: Barry Warsaw <barry@python.org>
Subject: Re: Git's inconsistent command line options
Date: Tue, 1 Sep 2015 13:50:18 -0400
Organization: Damn Crazy Followers of the Horn
Message-ID: <20150901135018.70240193@limelight.wooz.org>
References: <mrh7ck$r0g$1@ger.gmane.org>
	<CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
	<CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
	<CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
	<xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
	<CACsJy8D3J6RhtPPtSvtWfOb8BapaX2-52M5_fE36psQPB_oQsQ@mail.gmail.com>
	<20150831102558.1514e5f7@anarchist.wooz.org>
	<20150901092834.GA10706@gmail.com>
	<20150901101924.6c350012@anarchist.wooz.org>
	<xmqq37yyt7k8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kN.j0rsfIxuy56XAD0Aci.t"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Graeme Geldenhuys <graemeg@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 19:50:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWphS-0008AY-DW
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 19:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbbIARuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 13:50:22 -0400
Received: from mail.wooz.org ([216.15.33.194]:32971 "EHLO mail.wooz.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546AbbIARuW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 13:50:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.wooz.org (Postfix) with ESMTP id 20AEE10803E1;
	Tue,  1 Sep 2015 13:50:21 -0400 (EDT)
Received: from mail.wooz.org ([127.0.0.1])
	by localhost (carnies.wooz.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Z4El5IB7Anf; Tue,  1 Sep 2015 13:50:20 -0400 (EDT)
Received: from limelight.wooz.org (limelight.wooz.org [192.168.11.41])
	by mail.wooz.org (Postfix) with ESMTPSA id E9F87108035F;
	Tue,  1 Sep 2015 13:50:19 -0400 (EDT)
In-Reply-To: <xmqq37yyt7k8.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277003>

--Sig_/kN.j0rsfIxuy56XAD0Aci.t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sep 01, 2015, at 09:42 AM, Junio C Hamano wrote:

>That way, you are forcing all the existing scripts to be updated to
>say "git -c ..." for _all_ invocations of Git they have, aren't you?

No, why?  If the default value enables the current ui, then no scripts need
changing.  Users can enable the new ui for their own benefit at their own
pace.  If you eventually want to make the new ui the default, provide a
sufficient transition period.

Cheers,
-Barry

--Sig_/kN.j0rsfIxuy56XAD0Aci.t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5eVbAAoJEBJutWOnSwa/vokQAKDM/yo3VVPB/I0gTeIaICgW
dRazCZClYOJrh8+cbRAFuHQEKl22EOF1dyJgsG2K6N74y6el0YdAFOeBoBkkJWWv
TQbt4GBtQmNgVKxZkciKLCI1+lOnmxSFI5Lkhk1EuZJ2KEsyVOO2tWW/MU4WkSoL
fsdedJvjPGWQdKFAH9mW3kVN6RLwdvINnqT1CqY9Dty+NnSRvLXyj7q0duhr9qaI
x1BjTjJlw/B2siH2RE3ojI9a5kcyI0U4EiXHz/steg+/nZvE3TCf4VWfsRWjlrxt
5UxZJi2IpPO4oDW2ECf4UIwtmHWL/W7/YbjnVqpjtO+ihsiXbgE/cjoUBzjJL1NQ
0ZNKvJZtHickqf3MaplgwMk+kZYOsDjSdGpaoDPoA6XJV4kPOVF89cdHBEqEMMFq
VkZs/0Hr/AUQQWGbYV+KccAcyZ+ah8n7pfXcPjP/B7yOpms++gv8yXOWpBGhvQL1
jogwbPPRxMoKgvxIlZ9ztVPcp+igubx0h6tcwPOOjOVCriGPYxIstpqeekYLAFT5
eHJXK6t9YZrhA8joemf/S8G9VqLUzrMy4Eotc3V1W47shmpgwqvIFWtGlB3FSJTZ
kYe06xnFR7Sv4sjqHhsJRFh+9bAExUOhNueEBYaaLXRry8KSv12lZCZqMWjtqQl6
HYrL8nTTFho0v7EGOpyZ
=Nw/P
-----END PGP SIGNATURE-----

--Sig_/kN.j0rsfIxuy56XAD0Aci.t--

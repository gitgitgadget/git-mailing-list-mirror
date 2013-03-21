From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH] Documentation: add a README file
Date: Thu, 21 Mar 2013 23:02:10 +0100
Organization: OPTEYA
Message-ID: <1363903330.6289.59.camel@test.quest-ce.net>
References: <1363873555-8274-1-git-send-email-ydroneaud@opteya.com>
	 <7v8v5gbwh6.fsf@alter.siamese.dyndns.org>
	 <64e67681cf5584b51bc84082fe6304c0@meuh.org>
	 <7vzjxwabzv.fsf@alter.siamese.dyndns.org>
	 <7v620ka1y8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 23:03:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UInZh-0003IF-V1
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 23:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932959Ab3CUWCY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Mar 2013 18:02:24 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:44477 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932953Ab3CUWCW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 18:02:22 -0400
Received: from [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a] (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 812A8940011;
	Thu, 21 Mar 2013 23:02:11 +0100 (CET)
In-Reply-To: <7v620ka1y8.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.4 (3.4.4-2.fc17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218767>

Hi,

Le jeudi 21 mars 2013 =C3=A0 14:16 -0700, Junio C Hamano a =C3=A9crit :

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGui=
delines
> index b1bfff6..7e4d571 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -237,6 +237,9 @@ For Python scripts:
> =20
>  Writing Documentation:
> =20
> + Most (if not all) of the documentation pages are written in AsciiDo=
c
> + and processed into HTML output and manpages.
> +
>   Every user-visible change should be reflected in the documentation.
>   The same general rule as for code applies -- imitate the existing
>   conventions.  A few commented examples follow to provide reference
>=20
>=20

Nice, I'm OK with this change.
(But still thinking a README would be useful *too*).

Regards.

--=20
Yann Droneaud
OPTEYA

From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH] Documentation: add a README file
Date: Thu, 21 Mar 2013 22:59:53 +0100
Organization: OPTEYA
Message-ID: <1363903193.6289.57.camel@test.quest-ce.net>
References: <1363873555-8274-1-git-send-email-ydroneaud@opteya.com>
	 <7v8v5gbwh6.fsf@alter.siamese.dyndns.org>
	 <64e67681cf5584b51bc84082fe6304c0@meuh.org>
	 <7vzjxwabzv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 23:00:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UInXJ-0001Xx-D6
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 23:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779Ab3CUWAH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Mar 2013 18:00:07 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:48522 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178Ab3CUWAD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 18:00:03 -0400
Received: from [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a] (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A99FF940105;
	Thu, 21 Mar 2013 22:59:54 +0100 (CET)
In-Reply-To: <7vzjxwabzv.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.4 (3.4.4-2.fc17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218766>

Le jeudi 21 mars 2013 =C3=A0 10:39 -0700, Junio C Hamano a =C3=A9crit :
> Yann Droneaud <ydroneaud@opteya.com> writes:
>=20
> > There were no indication about how to write documentation
> > in SubmittingPatches.
>=20
> I would agree that is probably the right place for it if we were to
> add insns/hints.
>=20

But it will be difficult to find the place to put a note about
how to write the documentation.

Anyway, having a README at the Documentation/ level could also help to
explain what to be found in this directory:
- user-manual
- howto
- technical
- RelNote
- SubmittingPatches
- CodingGuidelines
- etc.

Regards.

--=20
Yann Droneaud
OPTEYA

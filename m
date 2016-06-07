From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: Re: [RFC/PATCHv2] Documentation: triangular workflow
Date: Tue, 7 Jun 2016 10:02:43 +0200
Message-ID: <9DE343E5-99FE-4504-AA62-5647FBD76F27@grenoble-inp.org>
References: <1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org> <1465206518-1780-1-git-send-email-jordan.de-gea@grenoble-inp.org> <xmqqk2i2w288.fsf@gitster.mtv.corp.google.com> <12C5A5F1276946DC99A03F30FEE49559@PhilipOakley> <vpqziqxbi3d.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Samuel GROOT <samuel.groot@grenoble-inp.org>,
	tom.russello@grenoble-inp.org
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 07 10:02:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAByS-0004si-Kh
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 10:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbcFGICw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 04:02:52 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:34242 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbcFGICs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 04:02:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id F0F1920AA;
	Tue,  7 Jun 2016 10:02:44 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id miur55JwVwRI; Tue,  7 Jun 2016 10:02:44 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D8C0120A5;
	Tue,  7 Jun 2016 10:02:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id D0E0C2066;
	Tue,  7 Jun 2016 10:02:44 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TB7gRs8eAX-Y; Tue,  7 Jun 2016 10:02:44 +0200 (CEST)
Received: from eduroam-033178.grenet.fr (eduroam-033178.grenet.fr [130.190.33.178])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id B7A0C2064;
	Tue,  7 Jun 2016 10:02:44 +0200 (CEST)
In-Reply-To: <vpqziqxbi3d.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296612>

> Le 7 juin 2016 =C3=A0 08:58, Matthieu Moy <matthieu.moy@grenoble-inp.=
fr> a =C3=A9crit :
>=20
> "Philip Oakley" <philipoakley@iee.org> writes:
>=20
>> Given that clarification I'd be happier to go with it being one's
>> 'Publish' repo.
>>=20
>> My initial reticence was because of the association of "publish" wit=
h
>> vanity publishing and other forms of over-sharing and self promotion=
=2E
>>=20
>> A clarification/explanation that calling it a 'publish' repo is abou=
t
>> granting access, and possible open access, would make it more
>> acceptable.
>=20
> I think "publish" is the best we found up to now.
>=20

It seems that we choose =E2=80=98publish=E2=80=99.=20
I=E2=80=99ll send the v3 of the patch soon. 
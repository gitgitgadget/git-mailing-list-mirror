From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Signed git-tag doesn't find default key
Date: Sat, 21 Oct 2006 08:44:39 +0100
Message-ID: <200610210844.46184.andyparkins@gmail.com>
References: <200610210052.k9L0q88T005342@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7450382.SWT8IKsfgR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 21 09:47:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbBZl-0005ry-QL
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 09:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992845AbWJUHrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 03:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992868AbWJUHrQ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 03:47:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:48784 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2992845AbWJUHrP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 03:47:15 -0400
Received: by ug-out-1314.google.com with SMTP id o38so906359ugd
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 00:47:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=CnJoSaIEM/Q33Qd7Vce2e0PXkgg68G3ADjELdd7DIkMXQryhQ0adiYHN0bPrgCflHON7u10fhx+/CZa8fR7MkzKf7afFHKbEWUQvpGRhi+1ryFepMGiFGWHiRHqnMddON3dIxueZLudPn+6rEZn8J0va/nG0jUuExvcWTG8qiUA=
Received: by 10.66.216.6 with SMTP id o6mr3442798ugg;
        Sat, 21 Oct 2006 00:47:13 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id o24sm2295979ugd.2006.10.21.00.47.12;
        Sat, 21 Oct 2006 00:47:12 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <200610210052.k9L0q88T005342@laptop13.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29587>

--nextPart7450382.SWT8IKsfgR
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 2006, October 21 01:52, Horst H. von Brand wrote:

> There very well might be... say you have a key for signing git stuff,
> another one for emailing, another one for signing RPMs you create, ... I
> believe that is the idea of the GPG comment field, precisely.

Either way, you're arguing for the fault being with Git - which has no noti=
on=20
of comment fields and so won't find the key anyway.

Andy

=2D-=20
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com

--nextPart7450382.SWT8IKsfgR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFOc/uwQJ9gE9xL20RAjhYAJ9J4LW1bbdA+iaPxzfNfdr+eYxufQCcCee7
YKGXU1JV6cewsr24vnYOpVc=
=s87v
-----END PGP SIGNATURE-----

--nextPart7450382.SWT8IKsfgR--

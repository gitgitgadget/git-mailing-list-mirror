From: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Wed, 13 Apr 2016 21:27:52 +0100
Message-ID: <87d1pt5k53.fsf@freja.aidecoe.name>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com> <1455919074-5683-1-git-send-email-aidecoe@aidecoe.name> <xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com> <87fuwnd4u7.fsf@freja.aidecoe.name> <xmqqbn7aa522.fsf@gitster.mtv.corp.google.com> <877fhwd1g0.fsf@freja.aidecoe.name> <xmqqegc33oal.fsf@gitster.mtv.corp.google.com> <CAE5ih7_vBMsi+zRZRTCaO56VrOYZUR0NQ0CSSE+Do48xkJ_BwA@mail.gmail.com> <871t83cfi7.fsf@freja.aidecoe.name> <CAE5ih7-rBuipoAGEnK60iidi1nYA9xWZQV6jRMHTVQe6f=cQag@mail.gmail.com> <87si0cpnpn.fsf@freja.aidecoe.name> <CAE5ih7-q_PwF-T6nsu=FyyN9wO6o0Jcfkg=gKy5mhOXRGFZ+VA@mail.gmail.com> <xmqqtwj6mmtu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 22:54:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqRnc-000590-6o
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 22:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbcDMUyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 16:54:03 -0400
Received: from jim.zolnowski.name ([188.116.54.122]:42092 "EHLO
	jim.zolnowski.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbcDMUyC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 16:54:02 -0400
X-Greylist: delayed 1557 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Apr 2016 16:54:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aidecoe.name; s=jim;
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From; bh=qdlisQSMB3gWAQ7Ut/PRLwVBcnbEQprbz/Xb1qcg6hg=;
	b=pYN5+AAIwPgFbl2mngSJcxL2kRvYPxHwiQnrRr3zKfhJBnLVAlp5ncWlUM/pxbNmtqIrbz/p2dPkoIfEgyml8dSqNiFpRyHc992G6okNm2u2/NF4K2wmuPhaYbpUpVWf++bQwjBVHB16y35E2R7YhvRuHdMA3lGqNGMFB9MYEBtKU5RWl6PCnidqZoMadO4/Gc3qWmngwEL/gNn1NrWN1OQgAYw31XZ34HafQCDpTcpdtJrkTYBAfLt7fANh8wJlv0RnnAik1cuzhiN49YXp/A4HM6suYBbb2Da9TBlgAnq2c1itmfE6iWVV2XSfBX5dyMqnVgrD9aP3a+gy6hJDdA==;
Received: from cpc92302-cmbg19-2-0-cust189.5-4.cable.virginm.net ([82.1.208.190] helo=localhost)
	by jim.zolnowski.name with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.85)
	(envelope-from <aidecoe@aidecoe.name>)
	id 1aqR5b-0002Wu-RS; Wed, 13 Apr 2016 22:08:40 +0200
In-Reply-To: <xmqqtwj6mmtu.fsf@gitster.mtv.corp.google.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/24.5.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291484>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Junio C Hamano <gitster@pobox.com> writes:
> Has anything happened to this topic after this?  I am wondering if I
> should discard the topic az/p4-bare-no-rebase without prejudice.

Sorry, I haven't got time to take a loot at this, but I'll return to
that soon, OK? I'll prepare a patch with an option to skip rebase rather
than do it only for bare repos.

=2D-=20
Amadeusz =C5=BBo=C5=82nowski

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1

iQJ8BAEBCgBmBQJXDqvIXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCMzcyRTFENjI5NUM1MzYwQTQwODQyRUZD
QkNDODAyM0Y1OUUxNzA0AAoJEMvMgCP1nhcEIaYP/jVxA272pLz5qetw1qbS4Sul
ULZcsKXSamvQZpeGoOoqcl7Mez9bahP5zA+nXLPpWccQdiT2z6231E6ATRwZO43N
Lln+1vvCXWBK7xIMua41oH+FlzScjTdho1vrm6UIRDtZeDsrL5p7Oyu4ze7Mqkec
4djoOnyhYqTnQLTPw7pNwuxOKtkiO2UQ+YDWVjcg0v3J/IKo7jA37lqr1L1WG9rH
wKQWdBwMTd8+vCIUFjQaE7e+iq7oUi1MocO15EKhVa0d9QL8KtKeo3a3Wm/ODupG
yToplcnGwLsLywdnznYJ8XH3GFIQEDWK94wEWJOtGbSHu6S8kKlZJ5CtQV4S4ffO
GYbnawevDUD65e3KzvtVOfNJhfuvID/JnR7J7HyTOHjmEaktDpjf/bp/pNGVGlv+
alNWylV0eQCvkwDQhToc3D7tzKoDQx8/yIAdJqwrYqTGdM5Xxq3o39C3bvJqOk+Q
6sNI1XCKymt/T0YAgU01JmSmdxhAqsNSIX2ac+xvz4Yv+bWNXb8HXd8+Iixwaw4V
tH/kbvWFq50LP9e8A/Odu8sltIbs+E/LpOTfOAUcRmz+XdVTrWdNKa7Z7nPTiwwJ
8J+83BMX08NdbolxSkbRRTt4ct0EJ4Yp1A2GiHCZXB/ZTC7krV/RgE+PFIWZljMA
S1NH5cI11tDMewWiBTDn
=pngI
-----END PGP SIGNATURE-----
--=-=-=--

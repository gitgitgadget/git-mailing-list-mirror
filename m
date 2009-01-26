From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Using the "What's cooking" scripts outside of Git
Date: Mon, 26 Jan 2009 11:25:04 -0800
Organization: Slide, Inc.
Message-ID: <1232997904.22352.4041.camel@starfruit>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-LWQaQvLxyruRe1q6wCFS"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 20:26:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRX6V-0007jm-EK
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbZAZTZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbZAZTZO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:25:14 -0500
Received: from mx0.slide.com ([208.76.68.7]:43292 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbZAZTZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 14:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=E
	eL4EkIxpLYCBnqZiL/mRcZqVKupJ+uda8a/vb95wwI=; b=wVh0B9WtnTyCi2Cwb
	V1MBM7zSjEQgOkfmvzmbfzOt/nUKSSkLE3927yAgrR6VSLz2unG9q1jY4KNChZHa
	wgJd1B7DrGn1fiGvg6JP3ce82EdTjRKU8j5pnTZOfURYyCLlZaKj+N1E4mvhbK+5
	Y5/WMLrANIZlViZGLdjq5gLfdw=
Received: from nat3.slide.com ([208.76.69.126]:55235 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LRX55-0002zP-OH
	for <git@vger.kernel.org>; Mon, 26 Jan 2009 11:25:11 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 9BB0AA6F0006
	for <git@vger.kernel.org>; Mon, 26 Jan 2009 11:25:11 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6L3F0A8zl5bJ for <git@vger.kernel.org>;
	Mon, 26 Jan 2009 11:25:11 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id 70FFBA6F0003
	for <git@vger.kernel.org>; Mon, 26 Jan 2009 11:25:11 -0800 (PST)
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107254>


--=-LWQaQvLxyruRe1q6wCFS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I was toying around with the idea of generating a "What's cooking" email
similar to Junio's for our internal development, and I'm wondering if
anybody has any experience using the scripts outside of the standard Git
repository.

Our repo is laid out slightly different, there's no "next" branch but
there are a number of "in development" branches that get folded down
into master.

Any tips would be appreciated


Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-LWQaQvLxyruRe1q6wCFS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl+DhAACgkQFCbH3D9R4W+2lgCfWnbZ2IrZePfpfYa7KGw5+jYn
D74AnAgQ8HZwfB2lpVkK2utmR8RAtJHg
=o/js
-----END PGP SIGNATURE-----

--=-LWQaQvLxyruRe1q6wCFS--

From: Ben Mezger <me@benmezger.nl>
Subject: Git Smart HTTP using Nginx
Date: Thu, 10 Mar 2016 10:13:49 -0300
Message-ID: <56E1730D.4030603@benmezger.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="J5vIi53xGjUF6nFPjnPdmsxxPOmGW1BVt"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 14:14:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae0Pv-00078V-44
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 14:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbcCJNOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 08:14:10 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:54242 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbcCJNOI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 08:14:08 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx2.mailbox.org (Postfix) with ESMTPS id E99F74353A
	for <git@vger.kernel.org>; Thu, 10 Mar 2016 14:14:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
	with ESMTP id UJePCfXJYbAt for <git@vger.kernel.org>;
	Thu, 10 Mar 2016 14:14:04 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288620>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J5vIi53xGjUF6nFPjnPdmsxxPOmGW1BVt
Content-Type: multipart/mixed; boundary="tOxhO4LwvS3LeHmuSTRLJmbad2emW49p8"
From: Ben Mezger <me@benmezger.nl>
To: git@vger.kernel.org
Message-ID: <56E1730D.4030603@benmezger.nl>
Subject: Git Smart HTTP using Nginx

--tOxhO4LwvS3LeHmuSTRLJmbad2emW49p8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

The git-scm.com only uses apache2 as an example of setting Git's Smart
HTTP, and searching the web for the Nginx's config only gives me old
configs or not-functional configurations. Has anyone managed to get
Smart HTTP to work with Nginx and could give me a sample of the .conf?

Regards,

Ben Mezger


--tOxhO4LwvS3LeHmuSTRLJmbad2emW49p8--

--J5vIi53xGjUF6nFPjnPdmsxxPOmGW1BVt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJW4XMNAAoJENGNPNyhY4OGYjoP/0SkNMwvb4DV1hx7sI+AT8vB
+jAwON57X5YagfNvd2GWQP5jSdRj2iqw+wQKunQCz57UEig5LygxHYiPdQn9XdHR
ahZtX3Fpz7LcDMcc+0/mlmdgaan6T5PAmKiv2CT+KF9eGUWcVU1tKImYOtNDR34h
q4G5eRqYjCAuATeHSI5kgyLZ4q0Xo752TE4PIQMrf6iaUXz0NP4/IPr761Vsv7Ty
TS6O4olPRJpwr3+Q6JCNEdOYNq1mE7zELh9y6fylj2ct9jtFX79WGq82rseQvUkO
biNN/uxi1MqZ8OXAHQI8tjq9kRSolUSAS9TM7P8VR5y2AdeHzYUokGTchYRywveD
eXD+DI0Q7Uz4icMcnFx4zQmHdZfo55s9cQapp/o3EIEIG72JLm4eGbg7d6voC8XC
IKcvJIYqWT03BCRaawx50Ex0sQAO9YdcTPisA674j25qXnC4gDWN5TolmILwlajs
BVWlyG77N75S73WLe6M3wMC0Z1twK6Y1BjIotDUMMBga24X0tZuawIbkZAXgKzmP
OUWVmX5Z+sn7oqUFeI1MM5AEVeVLG/KQKiFrh4tJyobEMvqPM4XqpEXceyBRH/fY
lVqXoucjjlDM+AwewIChzQAfHWLKe+dvuWWzaxsNg19qb2BLQ84fK+wT0H6D1NgO
dpnW+0V2lZSX00e3rLfP
=JuBe
-----END PGP SIGNATURE-----

--J5vIi53xGjUF6nFPjnPdmsxxPOmGW1BVt--

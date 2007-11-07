From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] Fix mistakes in the documentation of git-add --interactive.
Date: Wed, 7 Nov 2007 23:28:49 +0100
Message-ID: <73D3EECD-2164-4D9F-A2AA-91BEC7F34F22@lrde.epita.fr>
References: <200711072150.18751.barra_cuda@katamail.com> <1194472947-8601-1-git-send-email-tsuna@lrde.epita.fr> <Pine.LNX.4.64.0711072224200.4362@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-81--728518488"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 23:29:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IptOk-0007TK-0c
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbXKGW3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757027AbXKGW3G
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:29:06 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:41528 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898AbXKGW3F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:29:05 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IptON-0006B3-DA; Wed, 07 Nov 2007 23:28:59 +0100
In-Reply-To: <Pine.LNX.4.64.0711072224200.4362@racer.site>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63877>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-81--728518488
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 7, 2007, at 11:25 PM, Johannes Schindelin wrote:

> Hi,
>
> On Wed, 7 Nov 2007, Benoit Sigoure wrote:
>
>> -       a - add the change from that hunk and all the rest to index
>> -       d - do not the change from that hunk nor any of the rest  
>> to index
>> +       a - add the change from that hunk and all the remaining ones
>> +       d - do not the add change from that hunk and skip the  
>> remaining ones
>
> This still sounds funny.  How about
>
> 	d - skip this hunk, as well as the remaining ones

Yup, that's better, indeed.  I'll post a v3 (:

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-81--728518488
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHMjwhwwE67wC8PUkRAkzKAKDLibPsP+CCW6GyQehMmRKOjB7FlACg114C
cF4Se62ObyUXxceg1gJfUcI=
=VByf
-----END PGP SIGNATURE-----

--Apple-Mail-81--728518488--

From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Bug tracker (again)
Date: Sat, 8 Feb 2014 18:18:25 +0000
Message-ID: <20140208181825.GL635004@vauxhall.crustytoothpaste.net>
References: <CACsJy8BvEhqBSv2nGG3PTC3aarURAMic0SwMVppeDRkSXiZfCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Aaj1jBvBEV7KRjLi"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 19:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCCUA-0005Ai-1x
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 19:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbaBHSSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 13:18:34 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51718 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751960AbaBHSSd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Feb 2014 13:18:33 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:8c3:70d5:e1c3:271d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6F8D728074;
	Sat,  8 Feb 2014 18:18:29 +0000 (UTC)
Mail-Followup-To: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACsJy8BvEhqBSv2nGG3PTC3aarURAMic0SwMVppeDRkSXiZfCQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241840>


--Aaj1jBvBEV7KRjLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2014 at 02:26:57PM +0700, Duy Nguyen wrote:
> So I wonder if we use debian bug tracker for git upstream. I haven't
> used debian tracker much (or debian for that matter). It's probably
> best just ask instead of searching and guessing.
>=20
> I suppose if debian people (mostly debian git maintainer?) are not
> opposed to us using their tracker for upstream bugs, then it's just a
> matter of associating a mail thread with a bug number for tracking.
> That could be probably be done via email, then reply all to the thread
> in question with a bug email address. After that all email discussions
> are also tracked via this bug email. Anybody can help track bugs. Say
> if 3 weekdays are over and nobody said a thing about something that
> looks a lot like bug, then it should be tracked (problems that can be
> quickly fixed do not need tracking). Hmm?

All interaction with the Debian BTS (except for viewing bugs) is done
over email.  That's what I like about it.  It will automatically insert
an appropriate piece in the subject line (Bug#1393:) and anyone can mail
the control bot to manipulate a bug.  It also has the concept of
usertags, so you can create your own set of tags with user
git@vger.kernel.org (or your personal address, if you desire), and then
sort and display bugs appropriately.

Junio seemed lukewarm on the idea of using a bug tracker; however, I
think debbugs (either the Debian BTS or a separate instance) is probably
the best-suited to an email-based workflow of all the systems I've used.
Of course, it's up to the regulars (and probably ultimately Junio)
whether this is something that Git as a project would benefit from.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Aaj1jBvBEV7KRjLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS9nTxAAoJEL9TXYEfUvaLgNoP/3qTCuJv2zYBSzBeSyCRMy1Q
yHs+v8aD6acS3GObHrw4aSN2N0/yh1wBNAWyyhtqJYLs7bUAvECToE7ymZMqvqR5
Fpb6SqkN+FGM692owYBoaOM8XCt0tIlKfYIDKyHTdMXpskw3wx9DbSLcUg8FrqlV
fQl9Ddn+WBkTN/G5BubtAvq30mm5OtcCYlL2gFENjeRXk+no8g724Pm9U7pYzp1p
o9kvmnMSAZXQSp39B5TcLHWtZ7eGPcDd7COp9bvIN0G0H7yfC2DFpzvWkhe5pHgA
nRzLvZm10rlwxkmxMpumpUpVPSUZcg5NScahbKG9njmoxZKkP8J7cIaAEsv5dXzQ
/I/PcjHPtFjN/MwnxNyHsaWvsw1mu1Mq687qupPQYYqF24oUCCT/W1XU/PKYICpQ
wywgxkypz39QO3X/lSIZXG1/pynAjTimEhKDVwATH7SRmVuCZGyksQhAUdJzuSGR
i8lcJVFzExcpvkncRLjWCmWJIFiN1DDPBXrDFxRFdyjmIPNBCEia2IZCuAChCmTt
969FWcpYuXUUKxY46PLEik2pf1prhhuMCXl93ywmYcrLLoKmE33n6aAUI+l/CsOD
V4JX2XvDmxfjX1nK04+/VK22DWzV6cX04cW4/E8JKOuLJaX0FZQ1OhtTEQBxIWar
ykcYvxBYl96N1hAplofn
=FgKn
-----END PGP SIGNATURE-----

--Aaj1jBvBEV7KRjLi--

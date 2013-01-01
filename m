From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] Documentation: full-ness of a bundle is significant for
 cloning
Date: Tue, 01 Jan 2013 16:08:47 -0500
Message-ID: <20130101210847.GB5362@odin.tremily.us>
References: <1357053973.22772208@f75.mail.ru>
 <7vvcbgaapq.fsf@alter.siamese.dyndns.org>
 <7vehi4a9za.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=b5gNqxB1S1yM7hjW
Cc: git <git@vger.kernel.org>,
	Kirill Brilliantov <brilliantov@inbox.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqA1a-0005jg-Mm
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 23:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab3AAWJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 17:09:03 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:48746 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab3AAWJD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 17:09:03 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jan 2013 17:09:03 EST
Received: from odin.tremily.us ([unknown] [72.68.92.119])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MFY00ETBTENO040@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 01 Jan 2013 15:08:49 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 969DB769F63; Tue,
 01 Jan 2013 16:08:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1357074527; bh=JnHGlC5NREl0mwqYxBqRGn/mgOWY/B64VNp93TkG0ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ifB/NeH6EXlIJAQEN4HjaHYtD9MwHOczD0ZLguPEPKFLjeHzBJqM+edYH8Lk1Oz6R
 WKYvUztCk5yt9IOFibW/SQVRZpR1ZZdr04o3uAx9KBhlTIRwll5CISinFwzsXWLEmR
 S+54KrA84XSvChCzDhrnZm5fVtwaENpNJRc+mnj4=
Content-disposition: inline
In-reply-to: <7vehi4a9za.fsf_-_@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212458>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 01, 2013 at 01:07:05PM -0800, Junio C Hamano wrote:
> critical hint to tell readers why thhis particular bundle can be

s/thhis/this/

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ41BeAAoJEEUbTsx0l5OMlp8P/0vcXXhAUyQroLOVDePgXhdH
gVOMZPgf7xTsnKc5MKZwaTCDIPeuXgBFUjoZsPZzez0JeVs4DNMwi851lT3DorOI
0u0J3zdAqjeAcUnvlIgpi2GXhc80/+KrQAFIcXrt9r6YQKLhjgG9GpbINC32IyPs
B4htW29ORdSBmuwJWkpq6Mpt/x6/7amQQlUQCednn0ldJNCaLGBtp6o5XeMSwxXR
LrqQ+/li1hzo1AmwBdxB+gBNs4VK+y7Tz4H+uJGeOAbSBIAmMTvpgR2k1nnxtWtu
hLi40KasS+rBrNYaM7uWI6sbsVh3ZwdF4s4RkkEKTgyB0pRINLmZT80m6iI3e6L2
SbnShqt/ayHt0qS7qUXcer9G/+JmJDMscyGWdCX7d7aF0VKISTvIJ55XxsZ1xeJU
7e5Yp1caNRmfbaR1Xd2tfrl1/LE6NyFJOqC0BeoKORxC33O5UDZvP1ass0iF02x6
aKnlh1eYpB+BSVaRRjaPsLj8wBII8Nm7A90OizV71qULwffCOps9M7LOfDK3ngK9
vU7/6qeTdFrop4EVtiCNGuTAuOzdIFfU4eSKSRtWWIxdFQwVXEoJm6YVIfzxO2F/
3bfymOyGdxAqkLb+1bkaDHLL813v/nYcNKa4kwGd9HHIzJPdfo6ElW831wsbY1Zu
ZpoffUpWFCpQmuCFFgBt
=cj/A
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--

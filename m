From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 11:02:54 +0200
Message-ID: <DB8BA238-B1E3-48F2-AF90-A81BD0CD6A5F@lrde.epita.fr>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>  <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>  <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net> <Pine.LNX.4.64.0710150217120.25221@racer.site> <u4pgtj9rs.fsf@gnu.org> <Pine.LNX.4.64.0710150932560.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-71--616589665"
Content-Transfer-Encoding: 7bit
Cc: Eli Zaretskii <eliz@gnu.org>, git list <git@vger.kernel.org>,
	Make Windows <make-w32@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 11:04:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhLrT-0006QG-QL
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 11:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbXJOJDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 05:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbXJOJDd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 05:03:33 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:53554 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbXJOJDc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 05:03:32 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IhLrH-0000lR-AZ; Mon, 15 Oct 2007 11:03:31 +0200
In-Reply-To: <Pine.LNX.4.64.0710150932560.25221@racer.site>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60966>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-71--616589665
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 15, 2007, at 10:34 AM, Johannes Schindelin wrote:

> Hi,
>
> On Mon, 15 Oct 2007, Eli Zaretskii wrote:
>
>> No, you need to think in abstractions rather than POSIX-isms, and  
>> then
>> let each platform implement those abstractions as appropriate.
>
> Last time I checked, POSIX was already an abstraction,  
> thankyouverymuch.

But as Eli pointed out, it's not universal, so you need higher  
abstractions on top of them.

> Anyway, this discussion gets out of hand.

Not at all, actually I think some interesting points were made,  
including on the technical side of the thing.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-71--616589665
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHEyy/wwE67wC8PUkRAhueAJ0f6nVel6nuw05ajRt815Wa+V9FdACePP2e
pEqU/hcMt4CYI9bq4CvJ+BY=
=LsaT
-----END PGP SIGNATURE-----

--Apple-Mail-71--616589665--

From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: git log filtering
Date: Fri, 9 Feb 2007 13:15:22 +0300
Message-ID: <20070209131522.2df5d0b2.vsu@altlinux.ru>
References: <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
	<Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64ad7l12.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
	<7vps8l65fh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org>
	<20070208061654.GA8813@coredump.intra.peff.net>
	<Pine.LNX.4.63.0702081905570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070208223336.GA9422@coredump.intra.peff.net>
	<Pine.LNX.4.63.0702090115180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070209002344.GF1556@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__9_Feb_2007_13_15_22_+0300_FP1hfFIhuAEL_as/"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 11:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFSn5-0000NE-5I
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 11:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946279AbXBIKPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 05:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946304AbXBIKPf
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 05:15:35 -0500
Received: from mivlgu.ru ([81.18.140.87]:50355 "EHLO mail.mivlgu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946279AbXBIKPe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 05:15:34 -0500
Received: from center4.mivlgu.local (center4.mivlgu.local [192.168.1.4])
	by mail.mivlgu.ru (Postfix) with SMTP
	id 1E5218053; Fri,  9 Feb 2007 13:15:25 +0300 (MSK)
In-Reply-To: <20070209002344.GF1556@spearce.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39172>

--Signature=_Fri__9_Feb_2007_13_15_22_+0300_FP1hfFIhuAEL_as/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2007 19:23:44 -0500 Shawn O. Pearce wrote:

> pcre is covered by the BSD license.  Can we ship it with git, like
> we ship libxdiff?  I want to say Apache ships with pcre, but they
> use the Apache License so it might be easier for them to do so.

If you do this, please do not forget to add a way to use the system
copy of libpcre instead of the bundled version.

--Signature=_Fri__9_Feb_2007_13_15_22_+0300_FP1hfFIhuAEL_as/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQFFzEm9W82GfkQfsqIRAl8SAJsEGSsx0c+Acmsc0VMiIJWeio0aOgCfXksc
n0+8fTa5Wn331e77I+TamdU=
=HPFt
-----END PGP SIGNATURE-----

--Signature=_Fri__9_Feb_2007_13_15_22_+0300_FP1hfFIhuAEL_as/--

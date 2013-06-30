From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 0/4] Update linux-2.6.git location and related examples
Date: Sat, 29 Jun 2013 21:05:32 -0400
Message-ID: <20130630010532.GB25463@odin.tremily.us>
References: <7vppvhye6s.fsf@alter.siamese.dyndns.org>
 <cover.1371911897.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=p4qYPpj5QlsIQJ0K
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 30 03:05:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ut65N-0002hA-LZ
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 03:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883Ab3F3BFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jun 2013 21:05:34 -0400
Received: from vms173021pub.verizon.net ([206.46.173.21]:56190 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab3F3BFd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jun 2013 21:05:33 -0400
Received: from odin.tremily.us ([unknown] [72.68.81.124])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MP600MXLLP8Q670@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 29 Jun 2013 20:05:33 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 367AFA7849B; Sat,
 29 Jun 2013 21:05:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1372554332; bh=ntggRau11GgT8tA94/fWH6ZuG0DHELXcDZadUkL++Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YQGzaklDMMHDHVNuF501rd5yVNiNIvEJ4F7uog4t36nbej4yBvsN/K3dSpsgG/bJi
 8KC9fj2p6B5Jmx6Od5DutPwEIYRhf0c+UXZX9dx2ug91Sa64VFILbNw40wT9xZWKrW
 drIbg1r/byMai1PiRGj2L5rndGx+w/AuL27V7SLM=
Content-disposition: inline
In-reply-to: <cover.1371911897.git.wking@tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229258>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 22, 2013 at 10:46:23AM -0400, W. Trevor King wrote:
> David and Junio mentioned that I'd missed a few 2.6 references in my
> initial pass.  Here's a second attempt that does some deeper
> reworking of the effected sections.

No comments after a week, so I'm giving this patch series a bump ;).

Thanks,
Trevor

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRz4RbAAoJEKKfehoaNkbtqBkQAIFq9nbgDlSQnBmo94jKlAqG
OumMlEDTUrVGlf6DZLCsK7UiC9KRySJbOAgmfm21LnR2IAl+thR5O9od8F8CFVjJ
0YrVOoiEjw2vrjfXtMyez7gdmOFk/P0pPEVffdn3WNs9miCH/nb5mQurQdXJuEl8
P1FsLB9VtNwfFsIg1JQK9l1/Z7phyxgLj+0gN20NEc3G+xHBgFNxqWUTIqFaaNwL
4tHp8F8wqgbl+6TdRh4ypmxcY2epsPZ3Um5n65PbTkEDHO10nq9SEh41kN+2JndI
QyGpC99qYdB8LFtDEqFor0Q2vzrj1y50RQr2O5p1QfvPE3CRVfjndj6p7n8wfDaR
G0PaYoAXuMVFVgrNonk3oKbCPCjlUL3vFkn9F3lMynt3yi7TQmb2XzXfYpzJVsqk
4lREu0323+53/fdldN1P6TOYs3FK5unqfZ1+MhuLOgpLV2b5YtOsFwmMh+xxXlHT
fbf+A1Pq468CYtfS9dbRV9Jmj8VTVBpWJQy6TL7sQNmAAwyr6uKJALPnYhUPQF2Z
acmuwF6UcCt9HmV4J4AhP7wjU2IwJ3E6Pg0qLfhz5NPKmI2Iq2Og1WiP+j7ZJqWk
sdqq2h/mhVTlKfeCo3Dbz+D/6nfxT2AqnVJUL+QsHFNXG4xSF5XxMqfFbZnhdGUh
ICM+eQTzqi/foKoYg8RF
=B2Mg
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--

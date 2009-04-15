From: Ricky Zhou <ricky@fedoraproject.org>
Subject: Re: [PATCH] Use &#160; instead of &nbsp; for XHTML compliance
Date: Wed, 15 Apr 2009 12:38:29 -0400
Message-ID: <20090415163829.GD3316@sphe.res.cmu.edu>
References: <20090415154012.GX13966@inocybe.teonanacatl.org> <20090415155013.GA15518@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Cc: Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 18:41:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu8AO-0003tE-3z
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 18:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbZDOQjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 12:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbZDOQjR
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 12:39:17 -0400
Received: from mx2.redhat.com ([66.187.237.31]:48859 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699AbZDOQjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 12:39:17 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n3FGcWLI023293;
	Wed, 15 Apr 2009 12:38:33 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n3FGcUtv005099;
	Wed, 15 Apr 2009 12:38:30 -0400
Received: from localhost (vpn-14-120.rdu.redhat.com [10.11.14.120])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n3FGcT1V000447;
	Wed, 15 Apr 2009 12:38:30 -0400
Content-Disposition: inline
In-Reply-To: <20090415155013.GA15518@glandium.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116624>


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2009-04-15 05:50:14 PM, Mike Hommey wrote:
> &nbsp; is very much xhtml compliant, so the problem must lie somewhere
> else, possibly in privoxy.
Sorry for the noise, I've confirmed that this only happens with
torbutton is used. =20

Thanks,
Ricky

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknmDYUACgkQrH1ufGsbJY3CgwCgrVgbt9+/LFqSCfWvFWYzIQml
/REAni3bHvqQc/oa/xC5PPYRHXFO7XO7
=QUOi
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--

From: Erik Colson <eco@ecocode.net>
Subject: merge hook
Date: Fri, 10 Oct 2008 09:21:48 +0200
Message-ID: <20081010072148.GB303@Mac2.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 09:23:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoCLA-00087o-Eh
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 09:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbYJJHVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 03:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbYJJHVx
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 03:21:53 -0400
Received: from 42.mail-out.ovh.net ([213.251.189.42]:36809 "HELO
	42.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751274AbYJJHVx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 03:21:53 -0400
Received: (qmail 6936 invoked by uid 503); 10 Oct 2008 07:21:31 -0000
Received: from b6.ovh.net (HELO mail432.ha.ovh.net) (213.186.33.56)
  by 42.mail-out.ovh.net with SMTP; 10 Oct 2008 07:21:31 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 10 Oct 2008 07:21:49 -0000
Received: from unknown (HELO localhost) (erik.colson@beavernet.be@77.109.104.221)
  by ns0.ovh.net with SMTP; 10 Oct 2008 07:21:48 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Ovh-Tracer-Id: 183521685851586270
X-Ovh-Remote: 77.109.104.221 ()
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97912>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Is it possible to launch a custom script on all files involved in a
merge to master ?=20
If yes, is it then also possible to reject the merge if the script
returns an error ?

Thanks
--
Erik

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI7wKMexs8k4f5tB4RAorCAJ0RvF3gQj0oP2dboOV+AhOrpbu2TgCgomDV
E7q1cv0miypMEPaaPbMeh+A=
=Y/Jt
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

From: Dennis Putnam <dap1@bellsouth.net>
Subject: Using Eclipse git plugin
Date: Sun, 23 Dec 2012 11:16:51 -0500
Message-ID: <50D72E73.8070501@bellsouth.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9A953E2A9ADBD75C56FDB829"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 23 17:17:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmoEi-0004Ou-DV
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 17:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab2LWQQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 11:16:52 -0500
Received: from nm4-vm0.access.bullet.mail.mud.yahoo.com ([66.94.237.138]:41291
	"EHLO nm4-vm0.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751215Ab2LWQQu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Dec 2012 11:16:50 -0500
Received: from [66.94.237.126] by nm4.access.bullet.mail.mud.yahoo.com with NNFMP; 23 Dec 2012 16:16:49 -0000
Received: from [98.139.244.53] by tm1.access.bullet.mail.mud.yahoo.com with NNFMP; 23 Dec 2012 16:16:49 -0000
Received: from [127.0.0.1] by smtp115.sbc.mail.bf1.yahoo.com with NNFMP; 23 Dec 2012 16:16:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bellsouth.net; s=s1024; t=1356279409; bh=C/K1JHxAzQ8GS0rQ9CvHBCFzLb+vHTXLFnqlUy6ooCY=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:X-Enigmail-Version:Content-Type; b=iN2bP+tDkyfEUTXVdEJ62BSVUVPUgjYb4Y8jqUyuiQzU3phPd5B9HRAw91szRjRvz+voblltrNYUmu/vTmy7x4h2aYUGa6JnVUHSjJfyVaSyhBj4KEBzXsvBPnCEXhWMLln11z2WwJ+sfjbSK1FJbiPRWnSDMUfJIHKHLjidfuI=
X-Yahoo-Newman-Id: 824163.9798.bm@smtp115.sbc.mail.bf1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: mlw7un0VM1noqhpjhB3h4bodxhpGNAg2__VFxzHlfhShwyO
 0NnR89e.4lqIDLB_.j2fI0mfPfbtYXII8WQDoeZzhAUEGQWgQb1H8FLvDzOs
 SRVWYkxAzH3kmLucSCnG8mF._nIXlcrXWZzeh7C75Q.LMatlSnvNOuFXmDCq
 e19v9JR6trTqw2ENu.QcPiE2AcgE3xhvI.Zoi4RiD4mOFdckafrw9rrGD8H7
 ROyyuS5I3.auspWkxvBxKwS6L0aMOtbxt.W1PHi18oIKQmTtPCt0NDRRYSSm
 WpY1Pu0aomZg0fKzNqvwUBWpQmdgQYXsqVxnAz5GDkWcJVyt5BMd4edhFl5s
 TmQX8ituU7PPQBDOJig4Zm4PWUpO8PWgU_WdTOONApNQDG5G.DfF7PzNDh7M
 yxSQw3qpbYip2HxWGGEcTd_qbD_Pz9.TpuWpbV5zQqmK8y7U_wcOq6A--
X-Yahoo-SMTP: vUK3UKuswBCE01YQVYEZ1wHCa.HPSVCYhektzgdifA--
Received: from [192.168.0.100] (dap1@74.176.50.42 with plain)
        by smtp115.sbc.mail.bf1.yahoo.com with SMTP; 23 Dec 2012 08:16:49 -0800 PST
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212085>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A953E2A9ADBD75C56FDB829
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This may be more of an Eclipse question than a git question but
hopefully someone on this list knows both. I now have a working git
central repository (on Linux) and a local repository clone (on Windows).
I can see and edit my files in Eclipse, commit them and push them to the
remote repository. The problem I am having now is developing my code in
Eclipse. It seems I can no longer run the code as the 'Run as
Application' menu item is missing. How do I test my code now? TIA.


--------------enig9A953E2A9ADBD75C56FDB829
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDXLnMACgkQ/fiWYqZ2tVTW1ACgnbxqeaix7rXvPUshXe1YKRO0
NAgAoNNKjwWLLEjmzhLzhEtADN9/nds1
=ylPL
-----END PGP SIGNATURE-----

--------------enig9A953E2A9ADBD75C56FDB829--

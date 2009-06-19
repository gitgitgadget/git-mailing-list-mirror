From: "=?utf-8?q?K=C4=81rlis_Repsons?=" <karlis.repsons@gmail.com>
Subject: visualise the output of git-diff?
Date: Fri, 19 Jun 2009 07:32:15 +0000
Message-ID: <200906190732.24455.Karlis.Repsons@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6025063.SWbcycUvtp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 09:32:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHYaY-0003tY-Qd
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 09:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758186AbZFSHc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 03:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757313AbZFSHc1
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 03:32:27 -0400
Received: from mail-fx0-f206.google.com ([209.85.220.206]:42036 "EHLO
	mail-fx0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758329AbZFSHcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 03:32:25 -0400
Received: by fxm2 with SMTP id 2so91185fxm.37
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=LP9cdt800rHNWPDUzG8zM0+qveWtMC+OxmMBa6C+0Ns=;
        b=wMLxjsXtR7UuTaW+dLRP+4cKWPHGnpoXcd+Mps4+rXH8wEw4QJ4P+2P0xhc0l9Rodd
         txOkIhQ/6ffWHNhTl5puhzEu0ue/24aIjJK+X0HhLBCnNuYzxHPlYbJW49SpSdZ7j4TW
         XDVOr7INmnBBfmJPFJbL9osOoRWT+GClWAzUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=s8xcQ21olY1fgFpSNF476IQaHLnl5rVJn1jX3s0kwX5A7d6QFwcPZI3+nC3c6agNH3
         QDYv9OSXzPxEtnsKGj/HmVElyMm7ND0h9WclcDGIxw27ynlshhr477arSJJg17GrdbqI
         4zyp/NmSJZ6nfWCThu76iPwnj6HgarscQu/To=
Received: by 10.204.123.83 with SMTP id o19mr2276864bkr.12.1245396746778;
        Fri, 19 Jun 2009 00:32:26 -0700 (PDT)
Received: from ?192.168.7.93? ([85.15.210.9])
        by mx.google.com with ESMTPS id 5sm4214992bwz.70.2009.06.19.00.32.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 00:32:26 -0700 (PDT)
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121885>

--nextPart6025063.SWbcycUvtp
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
this is about displaying git-diff results:
in case of long text lines, where only a single word may be changed, it wou=
ld=20
be useful, if that single difference would be displayed in a different=20
colour, but is it possible?
And about pager - are you people all using less or there are also some=20
non-console viewers available?

K=C4=81rlis

--nextPart6025063.SWbcycUvtp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAko7PwgACgkQHuSu329e3GExtACgz19xTFn8xWoc3XHbhcp3EPsh
8tEAnRj8aXuQsIbQO2oktUO4BVx+T0P2
=y7K9
-----END PGP SIGNATURE-----

--nextPart6025063.SWbcycUvtp--

From: "Thomas Schittli" <schittli@gmx.ch>
Subject: user.signingkey without gpg? (using s/mime or ssh?)
Date: Fri, 18 Apr 2014 22:04:50 +0200
Message-ID: <trinity-c71c6cb0-0c4f-4283-bca9-ae4aa0f3419c-1397851490695@3capp-gmx-bs08>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 18 22:04:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbF1s-0005bR-T8
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 22:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbaDRUEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2014 16:04:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:62442 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314AbaDRUEw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2014 16:04:52 -0400
Received: from [46.126.169.144] by 3capp-gmx-bs08 with HTTP; Fri, 18 Apr
 2014 22:04:50 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K0:FQxrxnwCPQLXqKa7aWkaa9q2BWaJ//dzmTTCT0Taua0
 vX7HzX7LQx8cNE+Gkkc1X+BolzNA6H6zO3B97zXzyBXtFS3Nt0
 uTBx67fniPnzPQgOvuV+uEK5NBmYhcUqJD+2nY0Om7h3wtjtq7
 GYC+yfy5+L2SEeLLIJqXA/Y3sFhyv707MdCCp02bs5DQQ78Y6G
 X30Xgqv1h2LQxbxsee1ePNBVqJJlkNIVYsvaZv01/tP8NaVmWt
 NhOwiOJdYq00O8mD0qxzfC6hroiLqS3Oy0rcfvjPu3m9u/yeIP BJjdt0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246483>


Dear Git Community
=C2=A0
I've spent almost a day to find an answer to this question:
=C2=A0
We already have trusted Certificates from a CA. Can we use them instead=
 of an additional PGP key?
We already have:
- s/mime certificate
- web server ssl/tls certificate
- XMPP Jabber ssl/tls certificate
- Object Code Signing certificate
=C2=A0
Or if we have to use a new pgp key: can we sign it using any of our cer=
tificates?
=C2=A0
Thanks a lot for any hint in advance!,
kind regards,
Thomas
=C2=A0
=C2=A0
=C2=A0
=C2=A0
=C2=A0

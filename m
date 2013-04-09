From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: Teaching rerere about existing merges
Date: Tue, 9 Apr 2013 17:20:01 +0200 (CEST)
Message-ID: <1905484131.1403079.1365520801804.JavaMail.root@openwide.fr>
References: <87k3ob7ndj.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Tue Apr 09 17:20:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPaLG-0008Iz-Sy
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 17:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761840Ab3DIPUH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 11:20:07 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:36386 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761532Ab3DIPUG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Apr 2013 11:20:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id F361F28065;
	Tue,  9 Apr 2013 17:20:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zp0RtS7+sf9z; Tue,  9 Apr 2013 17:20:02 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 1836C2804A;
	Tue,  9 Apr 2013 17:20:02 +0200 (CEST)
In-Reply-To: <87k3ob7ndj.fsf@mcs.anl.gov>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC26 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220576>

thanks a lot, that solves my problem.

I'm a bit suprised that it's not part of the git-rerere command but tha=
t's good enough for me...

    Cordialement

    J=C3=A9r=C3=A9my Rosen

fight key loggers : write some perl using vim

----- Mail original -----
> Jeremy Rosen <jeremy.rosen@openwide.fr> writes:
>=20
> > is there a way to "teach" rerere about existing merge commits, or
> > do I
> > have to re-solve all the existing merge manually once ?
>=20
> See src/contrib/rerere-train.sh and Junio's blog.
>=20
> http://git-blame.blogspot.com/2012/04/rebuilding-git-integration-envi=
ronment.html
>=20

From: =?ISO-8859-1?B?U+liYXN0aWVu?= Pierre <sebastien@xprima.com>
Subject: Re: Cherry-pick particular object
Date: Tue, 28 Mar 2006 12:23:01 -0500
Organization: XPRima Corp.
Message-ID: <20060328122301.f74ee9c4.sebastien@xprima.com>
References: <20060328113107.20ab4c21.sebastien@xprima.com>
	<BAYC1-PASMTP02B05019F52DE48793CB39AED30@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 29 00:23:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOMbA-0003TQ-OB
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 00:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWC1WXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 28 Mar 2006 17:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWC1WXd
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 17:23:33 -0500
Received: from ritalin.autolinq.com ([207.96.225.42]:59306 "HELO
	ritalin.autolinq.com") by vger.kernel.org with SMTP id S932453AbWC1WXc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 17:23:32 -0500
Received: (qmail-ldap/ctrl 31046 invoked from network); 28 Mar 2006 22:23:32 -0000
Received: from unknown (HELO localhost.localdomain) ([207.96.159.2]) (envelope-sender <sebastien@xprima.com>)
          by ritalin.autolinq.com (qmail-ldap-1.03) with SMTP
          for <seanlkml@sympatico.ca>; 28 Mar 2006 22:23:32 -0000
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP02B05019F52DE48793CB39AED30@CEZ.ICE>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.16; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18132>

On Tue, 28 Mar 2006 16:34:22 -0500
sean <seanlkml@sympatico.ca> wrote:

> If you used:
>=20
> $ git cat-file -t 78132af2643
>=20
> It would tell you that this object is of type "blob".
> To see the contents of blobs you can do something like:
>=20
> $ git cat-file blob 78132af2643

Thanks. That was exactly what I was looking for :)

 -- S=E9bastien

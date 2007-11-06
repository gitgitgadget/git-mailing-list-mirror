From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Git-windows and git-svn?
Date: Tue, 6 Nov 2007 20:27:55 +0100
Message-ID: <200711062027.56519.robin.rosenberg.lists@dewire.com>
References: <fgg6cd$3ep$1@ger.gmane.org> <Pine.LNX.4.64.0711060857140.8577@ds9.cixit.se> <4730A9C3.1090006@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Steffen Prohaska <prohaska@zib.de>,
	Abdelrazak Younes <younes.a@free.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Nov 06 20:26:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpU4R-0001Nm-PC
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 20:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252AbXKFT00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 14:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756224AbXKFT00
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 14:26:26 -0500
Received: from [83.140.172.130] ([83.140.172.130]:27722 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbXKFT0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 14:26:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3A7C614706CC;
	Tue,  6 Nov 2007 20:17:25 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01450-03; Tue,  6 Nov 2007 20:17:24 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id E0BDD802661;
	Tue,  6 Nov 2007 20:17:24 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <4730A9C3.1090006@obry.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63703>

tisdag 06 november 2007 skrev Pascal Obry:
> Peter Karlsson a =E9crit :
> > I got errors almost right away when trying that (I need text mode t=
o
> > interface with some other programs), so Cygwin-git is a no-go for m=
e at
>=20
> Won't it be possible for you to have a specific mount point using
> textmode and one with binmode ? This should allow you to have the bes=
t
> of both world. Note that I've never done that so I don't know if it i=
s
> working fine.

I do that. It works fine. I've set up such paths so I have /cygdrive/c =
for textmode and
/binmode/c for binary mode and some other extra binary paths for conven=
ience.

-- robin

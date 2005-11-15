From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add config variable core.symrefsonly
Date: Tue, 15 Nov 2005 19:54:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511151953001.1427@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511151923120.1103@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0511151028540.3945@g5.osdl.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1799788894-1132080871=:1427"
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Nov 15 20:03:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec5xL-0005U8-Eo
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 19:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVKOSyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 13:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVKOSyj
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 13:54:39 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:24731 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964979AbVKOSyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 13:54:33 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 154E813F759; Tue, 15 Nov 2005 19:54:32 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E5DA5B51E5; Tue, 15 Nov 2005 19:54:31 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BDBCFB51E0; Tue, 15 Nov 2005 19:54:31 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5A2AF13F759; Tue, 15 Nov 2005 19:54:31 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511151028540.3945@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11934>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1799788894-1132080871=:1427
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 15 Nov 2005, Linus Torvalds wrote:

> On Tue, 15 Nov 2005, Johannes Schindelin wrote:
> >=20
> > 	Linus, is there any reason you don=B4t allow spaces, underscores
> > 	and dashes in the config variables?
>=20
> [...]
>
> PrettyCase is for toys [...] And ini files are PC: it's more important=20
> that a config file is human-readable than it is that it's very precise=20
> and strict.

Thanks for the explanation. Makes sense.

Ciao,
Dscho
---1148973799-1799788894-1132080871=:1427--

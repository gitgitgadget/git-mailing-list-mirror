From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Git 1.0 Synopis (Draft v3
Date: Sun, 31 Jul 2005 18:18:23 -0400
Message-ID: <200507312218.j6VMINnV031012@laptop11.inf.utfsm.cl>
References: <sam@ravnborg.org>
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 14:56:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzZqE-00039A-B0
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 14:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVHAM4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 08:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVHAM4S
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 08:56:18 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:46752 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261860AbVHAM4O (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2005 08:56:14 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j71CsTT6011646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Aug 2005 08:55:05 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j6VMINnV031012;
	Sun, 31 Jul 2005 18:18:23 -0400
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: Message from Sam Ravnborg <sam@ravnborg.org> 
   of "Fri, 29 Jul 2005 23:26:21 +0200." <20050729212621.GB8263@mars.ravnborg.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 01 Aug 2005 08:55:05 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Jul 29, 2005 at 04:29:41AM -0400, Ryan Anderson wrote:
> > Source Code Management with Git
> ....

> The article should include a HOWTO part alos.

I'd vote for a separate file.

>                                               So people can see how to
> edit a file, pull from a remote repository etc.

Exactly.

> Since you have introduced core and porcelains it would be most logical
> to use one of the porcelains in these examples, maybe accompanied by the
> raw git commands being executed.

Better leave the Porcelain-HOWTO to individual Porcelain. Perhaps the
Plumbing-HOWTO should include a section on interfacing to Porcelain (or it
should be yet another file).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

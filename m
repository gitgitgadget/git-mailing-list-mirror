From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Sun, 23 Oct 2005 21:22:05 -0300
Message-ID: <200510240022.j9O0M5B0028531@laptop11.inf.utfsm.cl>
References: <pasky@suse.cz>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
	"Martin Langhoff \(CatalystIT\)" <martin@catalyst.net.nz>,
	Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 15:26:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU2JV-0000Dc-SG
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 15:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbVJXNYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 09:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbVJXNYb
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 09:24:31 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63930 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750988AbVJXNYa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 09:24:30 -0400
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j9ODNZiB012475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Oct 2005 10:23:37 -0300
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9O0M5B0028531;
	Sun, 23 Oct 2005 21:22:05 -0300
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: Message from Petr Baudis <pasky@suse.cz> 
   of "Mon, 24 Oct 2005 00:40:22 +0200." <20051023224022.GX30889@pasky.or.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 24 Oct 2005 10:23:37 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10540>

Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Sun, Oct 23, 2005 at 05:33:43PM CEST, I got a letter
> where Horst von Brand <vonbrand@inf.utfsm.cl> told me that...
> > Martin Langhoff (CatalystIT) <martin@catalyst.net.nz> wrote:
> > [...]
> > >     MERGE ERROR: : Not handling case  ->  ->

> > It happens when a new file with the same name appears in both parents. For
> > example, we both see the need for a README file, and then I pull from you
> > and try to merge into my version.

> It certainly shouldn't happen with precisely that error message - there
> should be at least something written between the arrows.

It does now.

>                                                          And yes, there
> are unhandled cases like that, as I wrote in one of my other mails.

Yep, thanks!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

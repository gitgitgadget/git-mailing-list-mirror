From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Tue, 10 Oct 2006 10:25:21 -0400
Message-ID: <200610101425.k9AEPLfD004981@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 16:26:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXIYA-0000ap-OR
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 16:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWJJOZg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 10:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWJJOZf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 10:25:35 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50307 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750804AbWJJOZe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 10:25:34 -0400
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k9AEPMvm008363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Oct 2006 10:25:22 -0400
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9AEPLfD004981;
	Tue, 10 Oct 2006 10:25:21 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Mon, 09 Oct 2006 21:33:54 MST." <7v7iz894ct.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 10 Oct 2006 10:25:22 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28631>

Junio C Hamano <junkio@cox.net> wrote:

[...]

> Also we might want to consider using this file (or description)
> for git-daemon "motd" action if we were to enhance it.  I
> remember that early days of git-daemon some people wanted to
> have motd.

I consider motd to be a system-wide property, not of a particular
project/repository...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

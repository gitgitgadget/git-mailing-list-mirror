From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Thu, 01 Sep 2005 21:50:33 -0400
Message-ID: <200509020150.j821oXXM006699@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 15:16:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBBNo-00016v-In
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 15:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbVIBNOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 09:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbVIBNOh
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 09:14:37 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:46311 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030405AbVIBNOh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 09:14:37 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j82DE8to025303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Sep 2005 09:14:12 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j821oXXM006699;
	Thu, 1 Sep 2005 21:50:33 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Thu, 01 Sep 2005 17:38:39 MST." <7vek88tib4.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 02 Sep 2005 09:14:13 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8023>

Junio C Hamano <junkio@cox.net> wrote:
> Tim Ottinger <tottinge@progeny.com> writes:
> > git-update-cache for instance?
> > I am not sure which 'cache' commands need to be 'index' now.

> Logically you are right, but I suspect that may not fly well in
> practice.  Too many of us have already got our fingers wired to
> type cache, and the glossary is there to describe both cache and
> index.

I'd vote for cleaning it up /now/. Sure, it will hurt, but if you let time
go by and do it later, it will hurt much more.

Pre-1.0 is the last chance, AFAICS.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

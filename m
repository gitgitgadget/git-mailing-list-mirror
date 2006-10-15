From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Recent and near future backward incompatibilities
Date: Sun, 15 Oct 2006 11:52:38 -0300
Message-ID: <200610151452.k9FEqcIN003546@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Stephen Hemminger <shemminger@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 16:53:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ7MK-0004pN-IR
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 16:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWJOOw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 10:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWJOOw4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 10:52:56 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58499 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750799AbWJOOw4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 10:52:56 -0400
Received: from laptop13.inf.utfsm.cl (pc-232-245-83-200.cm.vtr.net [200.83.245.232])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k9FEqcx4025637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 15 Oct 2006 11:52:38 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9FEqcIN003546;
	Sun, 15 Oct 2006 11:52:38 -0300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Sat, 14 Oct 2006 23:29:17 PDT." <7v4pu62ite.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 15 Oct 2006 11:52:38 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28915>

Junio C Hamano <junkio@cox.net> wrote:
> It was brought to my attention that the public git.git
> repository cannot be cloned with older versions of git. [...]

There seem to be a bunch of incompatible changes comming up... how about
scheduling them for a 2.0 version, soon(ish)?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

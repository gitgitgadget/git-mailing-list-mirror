From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Newbie falls at first hurdle
Date: Sat, 17 Sep 2005 21:35:03 -0400
Message-ID: <200509180135.j8I1Z34n023252@inti.inf.utfsm.cl>
References: <alan@chandlerfamily.org.uk>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 04:01:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGoU2-0000kT-Nc
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 04:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVIRCAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 22:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVIRCAF
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 22:00:05 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58572 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751267AbVIRCAC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Sep 2005 22:00:02 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j8I1Z34n023252;
	Sat, 17 Sep 2005 21:35:05 -0400
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: Message from Alan Chandler <alan@chandlerfamily.org.uk> 
   of "Sat, 17 Sep 2005 13:09:46 +0100." <200509171309.46893.alan@chandlerfamily.org.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8773>

Alan Chandler <alan@chandlerfamily.org.uk> wrote:

[...]

> I have already got a working directory (or rather a directory hierarchy)
> of an application with files (combination of html and java), and I need
> to start applying some control to it.  The Tutorial unfortunately does
> not cover this case.  Nevertheless I have proceeded.

The easiest way of doing this is using cogito (near where you found
git). It automates some tasks using git as backendq, in this case it would
only need:

   cg-init
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

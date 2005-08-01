From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Git 1.0 Synopis (Draft v3
Date: Mon, 01 Aug 2005 09:21:59 -0400
Message-ID: <200508011321.j71DLxHO005485@laptop11.inf.utfsm.cl>
References: <vonbrand@inf.utfsm.cl>
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 15:23:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzaFg-0006tC-2M
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 15:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVHANWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 09:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVHANWg
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 09:22:36 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63469 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261976AbVHANWe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2005 09:22:34 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j71DLUH3015055
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Aug 2005 09:21:31 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j71DLxHO005485;
	Mon, 1 Aug 2005 09:21:59 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: Message from Horst von Brand <vonbrand@inf.utfsm.cl> 
   of "Sun, 31 Jul 2005 18:15:40 -0400." <200507312215.j6VMFeqn030963@laptop11.inf.utfsm.cl> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 01 Aug 2005 09:21:31 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[Yes, I know it is considered odd when you speak to yourself in public...]

Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Ryan Anderson <ryan@michonline.com> wrote:
> > Source Code Management with Git

> More bugging...

And then some.

> > To get the 'Porcelain' tools mentioned above:
> > 	SCM Interface layers:
> > 	cogito - http://www.kernel.org/pub/software/scm/cogito/
> > 	StGIT - http://www.procode.org/stgit/
> 
> At least cogito includes a (slightly old) version of git. Dunno about
> StGIT. And git and cogito have a gitk inside too. This should be mentioned,
> i.e., look at the package(s) you are interested and see what else they
> carry or require and keep in mind that (for now?) getting git as part of
> one package is /not/ guaranteed to be compatible with another or standard
> git.

Also note that StGIT is /not/ a SCM (as cogito is), it is a tool to shuffle
patches that uses git as a backend/target.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

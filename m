From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH 0/3] cogito spec file updates
Date: Tue, 03 May 2005 21:00:12 -0400
Message-ID: <200505040100.j4410DYJ004595@laptop11.inf.utfsm.cl>
References: <chrisw@osdl.org>
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 16:02:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTKRU-0004sN-TT
	for gcvg-git@gmane.org; Wed, 04 May 2005 16:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVEDOHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 10:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVEDOHq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 10:07:46 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:9428 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261837AbVEDOHl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 10:07:41 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j44E5Ela005841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 May 2005 10:05:16 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j4410Eo6004598;
	Tue, 3 May 2005 21:00:14 -0400
Received: from laptop11.inf.utfsm.cl (vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.4/8.13.4/Submit) with ESMTP id j4410DYJ004595;
	Tue, 3 May 2005 21:00:13 -0400
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: Message from Chris Wright <chrisw@osdl.org> 
   of "Tue, 03 May 2005 12:35:36 MST." <20050503193536.GE5324@shell0.pdx.osdl.net> 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 04 May 2005 10:05:16 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Chris Wright <chrisw@osdl.org> said:
> * Chris Wright (chrisw@osdl.org) wrote:
> > Here's the outstanding updates for the spec file, up to 0.8-2 which is
> > the latest on kernel.org.
> > 
> > 	http://www.kernel.org/pub/software/scm/cogito/RPMS/
> 
> What's your method for creating a release tarball?  If it were formalized
> (i.e. Makefile rule), then it'd be simple to use VERSION to drive the
> spec file, and it'd only need updating for real content changes (similar
> to what Kay did).

In each case you should add a Changelog entry to the spec file. Said entry
will probably mention the version anyway. Updating the version by hand
while at it is no big deal, now is it? Probably even less hassle than doing
it automatically.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513


From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [ANNOUNCE] Guilt 0.16
Date: Sat, 06 Jan 2007 16:57:31 -0300
Message-ID: <200701061957.l06JvVbP007499@laptop13.inf.utfsm.cl>
References: <jsipek@fsl.cs.sunysb.edu>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 20:58:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3HgA-0008Bk-Ir
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 20:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbXAFT6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 14:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbXAFT6F
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 14:58:05 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42916 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123AbXAFT6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 14:58:04 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l06Jvpw5007128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Jan 2007 16:58:00 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l06JvVbP007499;
	Sat, 6 Jan 2007 16:57:40 -0300
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
In-Reply-To: Message from Josef Sipek <jsipek@fsl.cs.sunysb.edu> 
   of "Sat, 06 Jan 2007 13:46:39 CDT." <20070106184639.GC12543@filer.fsl.cs.sunysb.edu> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 00:00:13 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 06 Jan 2007 16:58:02 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36097>

Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
> queues-like [1] functionality and interface to git.  The one distinguishing
> feature from other quilt-like porcelains, is the format of the patches
> directory. _All_ the information is stored as plain text - a series file and
> the patches (one per file). This easily lends itself to versioning the
> patches using any number of of SCMs.

A installation script/Makefile (or at least instructions) is missing...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

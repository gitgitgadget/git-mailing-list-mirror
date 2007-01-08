From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Test for failing pread() on cygwin.
Date: Sun, 07 Jan 2007 21:19:32 -0300
Message-ID: <200701080019.l080JW10018679@laptop13.inf.utfsm.cl>
References: <stefan.hahn@s-hahn.de>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 08 01:19:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3iEs-0005oq-Ox
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 01:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbXAHATh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 19:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965264AbXAHATh
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 19:19:37 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:44387 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965263AbXAHATg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 19:19:36 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l080JXeq019913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 7 Jan 2007 21:19:34 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l080JW10018679;
	Sun, 7 Jan 2007 21:19:33 -0300
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
In-Reply-To: Message from "Stefan-W. Hahn" <stefan.hahn@s-hahn.de> 
   of "Sun, 07 Jan 2007 12:18:42 BST." <20070107111841.GC9909@scotty.home> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Recipient e-mail whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 07 Jan 2007 21:19:34 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36206>

Stefan-W. Hahn <stefan.hahn@s-hahn.de> wrote:

> Test for failing pread() on cygwin.
> 
> Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
> ---
> 

[...]

> +GIT_AUTHOR_EMAIL=xxxxxxxx@yyyyyyyy.yyyyy.yyyyyyy.yyy

Why not the standard "Random J. User" <rju@example.com>? ;-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

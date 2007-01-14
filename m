From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sun, 14 Jan 2007 20:49:30 -0300
Message-ID: <200701142349.l0ENnUk9009229@laptop13.inf.utfsm.cl>
References: <spearce@spearce.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:59:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vhn-0006SO-N2
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:11 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8T-0003eK-0L
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbXANXuc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 18:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbXANXuc
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 18:50:32 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41819 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbXANXub (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 18:50:31 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0ENnwm2011816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 14 Jan 2007 20:50:14 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0ENnUk9009229;
	Sun, 14 Jan 2007 20:49:38 -0300
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: Message from "Shawn O. Pearce" <spearce@spearce.org> 
   of "Sun, 14 Jan 2007 17:42:04 CDT." <20070114224204.GA10888@spearce.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Sun, 14 Jan 2007 20:50:18 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2441/Sun Jan 14 14:18:02 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36855>

Shawn O. Pearce <spearce@spearce.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > You mean, you _ignored_ the text "git commit -a" gives you? It really 
> > shows you the output of "git status", exactly so you know what you 
> > committed, and sometimes more importantly, what you didn't.

> Because I'm a moron and forgot what files I had created recently.
> Consequently I don't see them missing from the output of git commit.
> Consequently I think the commit is OK.  :-)

That can't be fixed by software... better get the habit of "git add"ing new
files ASAP.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

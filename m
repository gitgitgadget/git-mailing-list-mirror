From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 17:01:50 -0300
Message-ID: <200701212001.l0LK1ofV022758@laptop13.inf.utfsm.cl>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net> <20070121134308.GA24090@1wt.eu> <7v7ivg1a25.fsf@assigned-by-dhcp.cox.net>
Cc: Willy Tarreau <w@1wt.eu>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, hpa@zytor.com
X-From: git-owner@vger.kernel.org Sun Jan 21 21:03:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8iu9-0004dw-2O
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 21:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbXAUUCU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 15:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbXAUUCU
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 15:02:20 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:42137 "EHLO
	pincoya.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbXAUUCT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 15:02:19 -0500
X-Greylist: delayed 919 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 15:02:18 EST
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by pincoya.inf.utfsm.cl (8.14.0.Beta5/8.14.0.Beta5) with ESMTP id l0LK1rT9021744;
	Sun, 21 Jan 2007 17:01:53 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0LK1ofV022758;
	Sun, 21 Jan 2007 17:01:50 -0300
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7v7ivg1a25.fsf@assigned-by-dhcp.cox.net>
Comments: In-reply-to Junio C Hamano <junkio@cox.net>
   message dated "Sun, 21 Jan 2007 10:58:26 -0800."
X-Mailer: MH-E 7.4.2; nmh 1.2-20070115cvs; XEmacs 21.5  (beta27)
X-Virus-Scanned: ClamAV 0.88.7/2476/Sun Jan 21 13:22:33 2007 on pincoya.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY autolearn=ham version=3.1.4
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	pincoya.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37339>

Junio C Hamano <junkio@cox.net> wrote:
> Willy Tarreau <w@1wt.eu> writes:
> > Anything you can do to make tester's life easier will always slightly
> > increase the number of testers.
> > ...
> > Pre-release tar.gz and rpms coupled with a freshmeat announcement should
> > get you a bunch of testers and newcomers. This will give the new doc a
> > real trial, and will help discover traps in which beginners often fall.
> 
> One worry I had about releasing git-1.5.0-rc2-1.rpm and friends
> just like the "official" ones was that people might have scripts
> to automate downloading & updating of packages, and they may not
> like to get "beta" installed for them.

Then put them into a "testing" or "pre-release" directory...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Merge with git-pasky II.
Date: Sat, 16 Apr 2005 17:33:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0504161733110.31775@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050414002902.GU25711@pasky.ji.cz>  <20050413212546.GA17236@64m.dyndns.org>
  <20050414004504.GW25711@pasky.ji.cz>  <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
  <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
  <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
  <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>  <20050414121624.GZ25711@pasky.ji.cz>
  <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
  <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
  <1113559330.12012.292.camel@baythorne.infradead.org> 
 <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
 <1113580881.27227.73.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 17:30:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMpFS-000595-EA
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 17:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVDPPd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 11:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVDPPd4
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 11:33:56 -0400
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:65459 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262682AbVDPPdy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 11:33:54 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A7538E10F3; Sat, 16 Apr 2005 17:33:53 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 84FC5ACF8E; Sat, 16 Apr 2005 17:33:53 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5BB25ACE95; Sat, 16 Apr 2005 17:33:53 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 88F81BB29C; Sat, 16 Apr 2005 17:33:52 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113580881.27227.73.camel@hades.cambridge.redhat.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 15 Apr 2005, David Woodhouse wrote:

> But if it can be done cheaply enough at a later date even though we end
> up repeating ourselves, and if it can be done _well_ enough that we
> shouldn't have just asked the user in the first place, then yes, OK I
> agree.

The repetition could be helped by using a cache.

Ciao,
Dscho

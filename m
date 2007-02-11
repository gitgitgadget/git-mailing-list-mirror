From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Mon, 12 Feb 2007 00:25:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702120025180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070211084030.GE2082@spearce.org> <7vwt2oba8s.fsf@assigned-by-dhcp.cox.net>
 <20070211224158.GA31488@spearce.org> <Pine.LNX.4.63.0702112351270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070211230204.GE31488@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:26:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGO56-0006Hv-IH
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbXBKXZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbXBKXZ6
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:25:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:56526 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932594AbXBKXZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:25:57 -0500
Received: (qmail invoked by alias); 11 Feb 2007 23:25:55 -0000
X-Provags-ID: V01U2FsdGVkX181KA91/rs1EL30T9bZWx3wrzNag9joXYFqe/fYZV
	j7OA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070211230204.GE31488@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39327>

Hi,

On Sun, 11 Feb 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > It may make patching slightly more interesting though, as some
> > > users new to git-gui development may generate a patch in git.git
> > > (using a/git-gui/git-gui.sh as the path) which then would not apply
> > > as-is to the master git-gui development tree.
> > 
> > In this case, a "-p <n>" option to git-am would make sense, no?
> 
> Are you saying we just suddenly found a vaild use for a flag which
> nobody (except the original submitter) thought was useful?  ;-)

That was my plan. But I was too lazy to look up the original poster...

Ciao,
Dscho

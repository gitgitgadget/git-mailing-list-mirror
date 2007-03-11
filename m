From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A tracking tree for the active work space
Date: Mon, 12 Mar 2007 00:18:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703120017450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910703110706m14abae25r2a965b644d8c3bbb@mail.gmail.com> 
 <7vhcsrwn8d.fsf@assigned-by-dhcp.cox.net> <9e4733910703111335j20c0acf4wa12c2d410580898b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 00:18:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQXJC-0004oH-Ps
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 00:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933619AbXCKXSc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 19:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933620AbXCKXSc
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 19:18:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:45148 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933619AbXCKXSb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 19:18:31 -0400
Received: (qmail invoked by alias); 11 Mar 2007 23:18:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 12 Mar 2007 00:18:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YpXEtqGoYrb06DLebPz48zSOqMjsm6I8ftq8/lG
	Snk2UhED+SdwPI
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <9e4733910703111335j20c0acf4wa12c2d410580898b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42001>

Hi,

On Sun, 11 Mar 2007, Jon Smirl wrote:

> On 3/11/07, Junio C Hamano <junkio@cox.net> wrote:
> > "Jon Smirl" <jonsmirl@gmail.com> writes:
> > 
> > > Reading the other thread on tracking temporary changes made me think
> > > of using inotify with git. The basic idea would be to a daemon running
> > > that uses inotify to listen for changes in the working tree. As these
> > > changes happen they get committed to a tracking tree.
> > 
> > I think it is an interesting idea, but can be used with any SCM
> > not just git ;-).

I just stumbled over this:

	http://arcs.unixtreaty.com/

which might or might not do what you want, judging by the description.

Ciao,
Dscho

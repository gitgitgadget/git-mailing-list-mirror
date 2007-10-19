From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sat, 20 Oct 2007 00:37:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710200035020.25221@racer.site>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> 
 <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail .com> 
 <Pine.LNX.4.64.0710130130380.25221@racer.site> <1192827476.4522.93.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Federico Mena Quintero <federico@novell.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 01:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij1PK-0005Xy-Fr
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 01:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762470AbXJSXhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 19:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762405AbXJSXhW
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 19:37:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:59292 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760441AbXJSXhV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 19:37:21 -0400
Received: (qmail invoked by alias); 19 Oct 2007 23:37:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 20 Oct 2007 01:37:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18VExF4mrIVD7OR6rMk2phEa6N9G1M5CSIxp0Rbl+
	NBsIvBmvWEKY0P
X-X-Sender: gene099@racer.site
In-Reply-To: <1192827476.4522.93.camel@cacharro.xalalinux.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61775>

Hi,

On Fri, 19 Oct 2007, Federico Mena Quintero wrote:

>   Bash: Display all 150 possibilities?
> 
>   Beijing hacker: "oh, shit..."
> 
> It's hard to know where to begin :)  Do I need "git-cherry-pick" or 
> "git-cherry"?  Why is the "apply a patch" command called "git-am"?  Why 
> is it different from "git-apply"?  From "git-applypatch"?  Etc.

Yeah, I was arguing a bit about obsoleting the "git-*" programs.  But it 
seems that we are not getting it anytime soon.

FWIW try this:

	git<Space><Tab>

or even better:

	git<Enter>

Ciao,
Dscho

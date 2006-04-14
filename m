From: Nicolas Pitre <nico@cam.org>
Subject: Re: git log is a bit antisocial
Date: Fri, 14 Apr 2006 17:20:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604141719290.2215@localhost.localdomain>
References: <Pine.LNX.4.64.0604141647360.2215@localhost.localdomain>
 <7vlku7q3k7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 23:22:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUVjx-0000gp-DG
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 23:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWDNVU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 17:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWDNVUb
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 17:20:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16556 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965174AbWDNVUO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 17:20:14 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IXQ007V8DXPXLB0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 14 Apr 2006 17:20:13 -0400 (EDT)
In-reply-to: <7vlku7q3k7.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18702>

On Fri, 14 Apr 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > $  git log -h
> > fatal: unrecognized argument: -h
> > $ git log --help
> > fatal: unrecognized argument: --help
> >
> > Maybe the usage string could be printed in those cases?
> 
> Perhaps.  Alternatively, "git help log", perhaps.

What about git-log then?


Nicolas

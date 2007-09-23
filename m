From: in-call@gmx.net
Subject: Uninstalling Git
Date: Sun, 23 Sep 2007 20:30:36 +0200
Message-ID: <46F6B0CC.3040000@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 20:30:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZWEA-0004DJ-Sn
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 20:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbXIWSak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 14:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754905AbXIWSak
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 14:30:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:37636 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754187AbXIWSaj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 14:30:39 -0400
Received: (qmail invoked by alias); 23 Sep 2007 18:30:38 -0000
Received: from unknown (EHLO [192.168.1.3]) [89.128.218.41]
  by mail.gmx.net (mp028) with SMTP; 23 Sep 2007 20:30:38 +0200
X-Authenticated: #11018450
X-Provags-ID: V01U2FsdGVkX1/cCc9jhXHcUSAkBhsw+tk4PACejA7Ndoi1vw8Qyt
	cZVUXZbaHFQB3u
User-Agent: Thunderbird 1.5.0.13 (X11/20070824)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58974>

Hello!

This must be a stupid-obvious-newbie question but...

Well, the point is that I installed the git version 1.5.2.1 in an ubuntu 
box.  That was done following the INSTALL instructions in the 
corresponding tarball.  I typed:

$ make configure
$ ./configure --prefix=/usr/local
$ make all doc
$ sudo make install install-doc

First, I'd like to uninstall the thing completely, how do I do that?

Second, what would be the correct procedure to follow if I would like 
just to upgrade to a newer version? install over the older perhaps? Is 
that always safe in the sense that there won't be any dangling piece of 
bin nor doc?

Thanks in advance!

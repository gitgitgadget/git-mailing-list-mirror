From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Thu, 03 Aug 2006 11:03:45 +0200
Organization: At home
Message-ID: <ease4h$fv2$1@sea.gmane.org>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net> <20060802192922.GA30539@prophet.net-ronin.org> <7virlas9ol.fsf@assigned-by-dhcp.cox.net> <20060803053004.GA10413@prophet.net-ronin.org> <20060803054831.GB10413@prophet.net-ronin.org> <20060803073636.GA12755@prophet.net-ronin.org> <7vvepaqkki.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 03 11:04:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Z89-0005cn-2B
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 11:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWHCJEa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 05:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWHCJEa
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 05:04:30 -0400
Received: from main.gmane.org ([80.91.229.2]:42984 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932403AbWHCJE3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 05:04:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G8Z7C-0005QZ-Q0
	for git@vger.kernel.org; Thu, 03 Aug 2006 11:03:38 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 11:03:38 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 11:03:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24715>

Junio C Hamano wrote:

> The following _might_ have a better chance of success...

Doesn't clobber ~/.gitk, but doesn't correct error either (i.e. I still
cannot see bottommost part of gitk window in subsequent invocations).

* Aurox Linux 11.1 (Zeus), based on Fedora Core 4
* Linux 2.6.14-11.1.aur.2
* tcl-8.4.9-3
* xorg-x11-6.8.2-37.FC4.49.2
* windowmaker-0.91.0-1.1.fc3.rf
* git v1.4.2-rc2-geb10b37 + your patch

# grep geometry ~/.gitk 
set geometry(width) 890
set geometry(height) 868
set geometry(canv1) 405
set geometry(canv2) 270
set geometry(canv3) 174
set geometry(canvh) 354
set geometry(ctextw) 80
set geometry(ctexth) 34
set geometry(cflistw) 35

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

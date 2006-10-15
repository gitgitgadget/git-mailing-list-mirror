From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Sun, 15 Oct 2006 11:09:46 +0200
Organization: At home
Message-ID: <egsts6$a1o$1@sea.gmane.org>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net> <7virim10rb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Oct 15 11:09:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ20D-0002Bg-0J
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 11:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWJOJJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 05:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWJOJJp
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 05:09:45 -0400
Received: from main.gmane.org ([80.91.229.2]:41430 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932365AbWJOJJo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 05:09:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZ202-0002AZ-Q7
	for git@vger.kernel.org; Sun, 15 Oct 2006 11:09:38 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 11:09:38 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 11:09:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28909>

Junio C Hamano wrote:

> This introduces a new configuration item, pack.deltaversion, to
> control whether pack-objects is allowed to use version 3 delta.

Documentation, please?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

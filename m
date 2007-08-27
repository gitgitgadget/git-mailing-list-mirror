From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: Lift any characters restriction on searched strings
Date: Mon, 27 Aug 2007 03:02:59 +0200
Organization: At home
Message-ID: <fat7s1$t4a$1@sea.gmane.org>
References: <20070825221847.11739.46741.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 03:03:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPT16-0001gh-Go
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 03:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbXH0BDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 21:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbXH0BDO
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 21:03:14 -0400
Received: from main.gmane.org ([80.91.229.2]:46041 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbXH0BDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 21:03:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPT0V-0001xA-Qp
	for git@vger.kernel.org; Mon, 27 Aug 2007 03:03:07 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 03:03:07 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 03:03:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56753>

Petr Baudis wrote:

> Everything is already fully quoted along the way so I believe this to be
> unnecessary at this point. It would pose trouble for regexp searches.

Ack. It looks correct.
 
> Cc: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Petr Baudis <pasky@suse.cz>

Actually I have not received it by the mail, so "Cc:" in the body didn't
work. Did you use git-send-mail?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

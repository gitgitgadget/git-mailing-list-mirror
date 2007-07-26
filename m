From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix error in generating snapshot
Date: Thu, 26 Jul 2007 11:17:54 +0200
Organization: At home
Message-ID: <f89os3$arg$1@sea.gmane.org>
References: <30e4a070707250627l29ce4794x97d03b8232352cae@mail.gmail.com> <11854018464134-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 11:18:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDzU2-0008A0-6R
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 11:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbXGZJSG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 05:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277AbXGZJSE
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 05:18:04 -0400
Received: from main.gmane.org ([80.91.229.2]:53508 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142AbXGZJSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 05:18:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IDzTt-0001sT-M2
	for git@vger.kernel.org; Thu, 26 Jul 2007 11:18:01 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 11:18:01 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 11:18:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53811>

Jakub Narebski wrote:

> There was an error while generating cmmandline to run git-archive:
> there were no whitespace between two options.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Noticed-by: Mark Levedahl <mlevedahl@gmail.com>

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

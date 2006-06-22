From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [WORKAROUND] gitk lower pane scrollbar extends past gitk window
Date: Thu, 22 Jun 2006 15:19:14 +0200
Organization: At home
Message-ID: <e7e5ci$ath$1@sea.gmane.org>
References: <e7ber7$qh9$1@sea.gmane.org> <20060622023546.28cb4291.froese@gmx.de> <81b0412b0606220010p6c2e62ffv3914abafd95e4bb2@mail.gmail.com> <e7di0n$7hh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 22 15:20:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtP6g-0005o8-BA
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 15:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWFVNUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 09:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWFVNUF
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 09:20:05 -0400
Received: from main.gmane.org ([80.91.229.2]:39346 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161106AbWFVNUD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 09:20:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtP65-0005fa-Tc
	for git@vger.kernel.org; Thu, 22 Jun 2006 15:19:50 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 15:19:49 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 15:19:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22335>

It looks like gitk incorrectly saves the geometry in ~/.gitk
I have to remove it before running gitk (well, it would be 
enough to remove geometry section).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

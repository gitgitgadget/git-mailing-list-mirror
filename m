From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Skip nonmatching lines in difftree output, consistently
Date: Sun, 06 Aug 2006 18:01:38 +0200
Organization: At home
Message-ID: <eb53p1$1eg$1@sea.gmane.org>
References: <20060806155505.GA9548@moooo.ath.cx> <11548799921728-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Aug 06 18:02:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9l4s-0005Xg-S5
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 18:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWHFQCH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 12:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbWHFQCH
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 12:02:07 -0400
Received: from main.gmane.org ([80.91.229.2]:54943 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932593AbWHFQCF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 12:02:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G9l4h-0005VE-0a
	for git@vger.kernel.org; Sun, 06 Aug 2006 18:01:59 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 18:01:59 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 18:01:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24983>

Jakub Narebski wrote:

> This fixes error for commitdiff on root commit (without parents).
> 
> Noticed-by: Matthias Lederhofer (matled)
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

This is an alternate patch.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] hooks--update: new, required, config variable: hooks.envelopesender,
Date: Fri, 23 Mar 2007 15:05:57 +0100
Organization: At home
Message-ID: <eu0mmf$hln$2@sea.gmane.org>
References: <874poc88ix.fsf@rho.meyering.net> <200703231258.34339.andyparkins@gmail.com> <87wt186qcd.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 15:03:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUkMY-0001ja-DD
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 15:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422931AbXCWODX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 10:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422936AbXCWODX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 10:03:23 -0400
Received: from main.gmane.org ([80.91.229.2]:35051 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422931AbXCWODW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 10:03:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HUkMF-0003tS-Kz
	for git@vger.kernel.org; Fri, 23 Mar 2007 15:03:07 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 15:03:07 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 15:03:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42932>

Jim Meyering wrote:

> If we can't do this portably via the sendmail program, then
> perhaps it's a good time to switch to using a module like Net::SMTP.

Perhaps taking some code from contrib/continuous/
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

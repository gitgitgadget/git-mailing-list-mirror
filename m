From: Randy Brandenburg <randy.brandenburg@woh.rr.com>
Subject: Re: error 'cannot create thread' doing clone or fetch
Date: Fri, 27 May 2011 16:21:56 +0000 (UTC)
Message-ID: <loom.20110527T182027-800@post.gmane.org>
References: <BANLkTi=p3CbQD_EzJATenGsxz5m3=KLtMA@mail.gmail.com> <20110517114754.GA13176@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 18:50:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ0Er-00011v-4A
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 18:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291Ab1E0QuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 12:50:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:60342 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754725Ab1E0QuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 12:50:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QQ0Ee-0000sZ-Hs
	for git@vger.kernel.org; Fri, 27 May 2011 18:50:07 +0200
Received: from pm2-users.caci.com ([204.194.77.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 May 2011 18:50:04 +0200
Received: from randy.brandenburg by pm2-users.caci.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 May 2011 18:50:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 204.194.77.3 (Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; MS-RTC LM 8))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174629>

I am experiencing this exact error while trying to clone a remote repository. 
Did you figure out what the cause was and how to fix it?

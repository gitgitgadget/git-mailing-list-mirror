From: Randy Brandenburg <randy.brandenburg@woh.rr.com>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Fri, 3 Jun 2011 12:29:21 +0000 (UTC)
Message-ID: <loom.20110603T142235-877@post.gmane.org>
References: <loom.20110601T161508-689@post.gmane.org> <1307043315-sup-5292@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 14:29:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSTVW-0003Jx-6v
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 14:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628Ab1FCM3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 08:29:37 -0400
Received: from lo.gmane.org ([80.91.229.12]:41402 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950Ab1FCM3g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 08:29:36 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QSTVM-0003FI-MU
	for git@vger.kernel.org; Fri, 03 Jun 2011 14:29:35 +0200
Received: from pm2-users.caci.com ([204.194.77.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 14:29:32 +0200
Received: from randy.brandenburg by pm2-users.caci.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 14:29:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 204.194.77.3 (Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; MS-RTC LM 8))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175006>

Ben Walton <bwalton <at> artsci.utoronto.ca> writes:

Hey Ben,

> 
> Have you considered the OpenCSW git[1] packages?  I'm a little stale
> at 1.7.3 right now but I have 1.7.5 ready to go...
> 

I did download the 1.7.3.2 version using pkg-get as the next option if I 
couldnt get the 1.7.5 to build and install. I would be all for a working 
package install if available, since we will have to install Git on a developer 
machine each time one is upgraded from a standard install of Solaris 9. I would 
like to add a package to our install instead of actually building from source 
each time.

Please keep me posted when the package is available for download!

Thanks,
Randy Brandenburg

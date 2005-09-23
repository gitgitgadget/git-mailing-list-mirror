From: walt <wa1ter@myrealbox.com>
Subject: Re: [ANNOUNCE] GIT 0.99.7b
Date: Fri, 23 Sep 2005 06:11:54 -0700
Organization: none
Message-ID: <dh0uur$h4g$1@sea.gmane.org>
References: <7voe6ki9x7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 23 15:17:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EInOE-0002fd-QF
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 15:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVIWNO4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 09:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbVIWNO4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 09:14:56 -0400
Received: from main.gmane.org ([80.91.229.2]:11243 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750970AbVIWNOz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 09:14:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EInMl-0002M9-LL
	for git@vger.kernel.org; Fri, 23 Sep 2005 15:13:27 +0200
Received: from adsl-69-234-234-116.dsl.irvnca.pacbell.net ([69.234.234.116])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Sep 2005 15:13:27 +0200
Received: from wa1ter by adsl-69-234-234-116.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Sep 2005 15:13:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-234-116.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20050923)
In-Reply-To: <7voe6ki9x7.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9190>

Junio C Hamano wrote:
> GIT 0.99.7b
[...]
> Or, if you use git already:
> 
> 	{http,rsync}://kernel.org/pub/scm/git/git.git/

I did it that way and now I see this:

$git --version
git version 0.99.7

This is a bit confusing.  Did I upgrade or downgrade?
Maybe the version string should contain the same kind
of hexadecimal string that Linus is appending to his
kernel version?

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Introduce ~/.gitconfig
Date: Thu, 08 Jun 2006 20:32:03 +0200
Organization: At home
Message-ID: <e69qev$nnl$1@sea.gmane.org>
References: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de> <1149775348.23938.236.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 08 20:32:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoPIv-0002H4-Um
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 20:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWFHScX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 14:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWFHScX
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 14:32:23 -0400
Received: from main.gmane.org ([80.91.229.2]:42660 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964927AbWFHScW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jun 2006 14:32:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FoPIc-0002Cm-L2
	for git@vger.kernel.org; Thu, 08 Jun 2006 20:32:07 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 20:32:06 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 20:32:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21504>

Jon Loeliger wrote:

> On Thu, 2006-06-08 at 06:30, Johannes Schindelin wrote:

>> - The --no-local flag [...]
> 
> Could we have multiple levels, and have names that call out
> where it applies?  Perhaps something like:
> 
> --repo   into $GIT_DIR/.gitconfig  <- current default, right?
> --home   into ~/.gitconfig
> --site   into /etc/gitconfig
> --share  into /usr/share/git/config

I like that too, wlthough --home might be named --user, and --share be named
--predefined or --library.

-- 
Jakub Narebski
Warsaw, Poland

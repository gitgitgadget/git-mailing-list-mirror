From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Converted git-merge-ours.sh -> builtin-merge-ours.c
Date: Fri, 23 Nov 2007 10:42:25 +0100
Organization: At home
Message-ID: <fi67a2$6jh$1@ger.gmane.org>
References: <4745E45C.7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 10:43:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvV3s-00017j-VH
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 10:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbXKWJml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 04:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753078AbXKWJml
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 04:42:41 -0500
Received: from main.gmane.org ([80.91.229.2]:59202 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbXKWJml (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 04:42:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IvV3T-00033j-2h
	for git@vger.kernel.org; Fri, 23 Nov 2007 09:42:35 +0000
Received: from abwz172.neoplus.adsl.tpnet.pl ([83.8.249.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 09:42:35 +0000
Received: from jnareb by abwz172.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 09:42:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwz172.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65883>

Thomas Harning wrote:

> diff --git a/git-merge-ours.sh b/git-merge-ours.sh
> deleted file mode 100755
> index c81a790..0000000
> --- a/git-merge-ours.sh
> +++ /dev/null

Shouldn't script version be moved to contrib/examples/ as is git.git
policy, or is it too simple script?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

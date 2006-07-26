From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: Wed, 26 Jul 2006 15:35:57 +0200
Organization: At home
Message-ID: <ea7r3s$ta2$1@sea.gmane.org>
References: <Pine.LNX.4.63.0607251809340.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060726010358.20964.80443.stgit@machine> <Pine.LNX.4.63.0607260356480.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060726021058.GV13776@pasky.or.cz> <Pine.LNX.4.63.0607260416070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jul 26 15:36:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5jYy-00020d-71
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 15:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWGZNgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 09:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWGZNgd
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 09:36:33 -0400
Received: from main.gmane.org ([80.91.229.2]:31368 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750713AbWGZNgc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 09:36:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G5jYh-0001wm-O9
	for git@vger.kernel.org; Wed, 26 Jul 2006 15:36:20 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Jul 2006 15:36:19 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Jul 2006 15:36:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24211>

Johannes Schindelin wrote:

> Seriously, I still believe that proof-of-concepts in Bash or Perl or even 
> Python are fine. But they are not for real work, so one of my long-term 
> goals for git is to get rid of them.

I don't think that we would want to rewrite gitweb in C, for example.
And Perl for porcelanish commands is all right, IMVVHO.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

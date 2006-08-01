From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Diff format in packs
Date: Tue, 01 Aug 2006 14:01:03 +0200
Organization: At home
Message-ID: <eanfp9$37c$1@sea.gmane.org>
References: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com> <ealruh$sq9$1@sea.gmane.org> <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com> <46a038f90607311747j947c786s6af2fe637dbde89d@mail.gmail.com> <9e4733910607311813l78791e40l1234cf0e458db66f@mail.gmail.com> <46a038f90607311916k5d130f70gc0ac26eb8f15fec0@mail.gmail.com> <9e4733910607311929j189eb6b9r6a804cc744290fdc@mail.gmail.com> <Pine.LNX.4.63.0608011248530.17230@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 01 14:02:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7swh-0003nK-A5
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 14:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWHAMB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 08:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWHAMB4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 08:01:56 -0400
Received: from main.gmane.org ([80.91.229.2]:21441 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751133AbWHAMB4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 08:01:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7sw9-0003bi-DN
	for git@vger.kernel.org; Tue, 01 Aug 2006 14:01:25 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 14:01:25 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 14:01:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24594>

Johannes Schindelin wrote:

> In another mail, you asked for a solution for the initial 700MB download. 
> How about doing it like Linux-2.6, namely have a clean cut, and for those 
> who want, they can load the historical repo, too, and graft it onto the 
> current one?

Perhaps that would be incentive to finally make "lazy clone"/"shallow clone"
support in git.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

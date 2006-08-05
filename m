From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7/5] Merge changes in "split patch 1" series
Date: Sat, 05 Aug 2006 17:05:09 +0200
Organization: At home
Message-ID: <eb2c1o$9d9$1@sea.gmane.org>
References: <200608050036.06490.jnareb@gmail.com> <eb2068$cm7$1@sea.gmane.org> <Pine.LNX.4.63.0608051654390.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 05 17:04:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Nhr-0005Jm-EC
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 17:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWHEPEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 11:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWHEPEn
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 11:04:43 -0400
Received: from main.gmane.org ([80.91.229.2]:64141 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751067AbWHEPEm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 11:04:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G9NhZ-0005H6-RC
	for git@vger.kernel.org; Sat, 05 Aug 2006 17:04:34 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 17:04:33 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 17:04:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24917>

Johannes Schindelin wrote:
 
> On Sat, 5 Aug 2006, Jakub Narebski wrote:
> 
>> Strange that git-format-patch does not output merges...
> 
> And what exactly should it output? patch against commit^1 or commit^2, 
> etc.? Both? Combined diff?

In my case, commit^1. But I'd be satisfied if it would warn me about missing
commit (the merge was topmost commit).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

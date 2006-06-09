From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 09 Jun 2006 09:17:02 +0200
Organization: At home
Message-ID: <e6b798$td3$1@sea.gmane.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> <9e4733910606082028k37f6d915m26009e0d5011808b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 09 09:17:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FobFX-0006zA-NS
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 09:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWFIHRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 03:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWFIHRc
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 03:17:32 -0400
Received: from main.gmane.org ([80.91.229.2]:6797 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751392AbWFIHRb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 03:17:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FobF2-0006vn-5t
	for git@vger.kernel.org; Fri, 09 Jun 2006 09:17:12 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 09:17:12 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 09:17:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21528>

Jon Smirl wrote:


>> git-repack -a -d but it OOMs on my 2GB+2GBswap machine :(
> 
> We are all having problems getting this to run on 32 bit machines with
> the 3-4GB process size limitations.

Is that expected (for 10GB repository if I remember correctly), or is there
some way to avoid this OOM?

-- 
Jakub Narebski
Warsaw, Poland

From: David Lang <dlang@digitalinsight.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 13:55:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0610201355260.5248@qynat.qvtvafvgr.pbz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> 
 <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> 
 <200610201821.34712.jnareb@gmail.com> <45390168.6020502@utoronto.ca> 
 <20061020172125.GF18019@spearce.org>  <Pine.LNX.4.64.0610201045550.3962@g5.osdl.org>
  <20061020202318.GJ20017@pasky.or.cz>  <Pine.LNX.4.63.0610201345440.5248@qynat.qvtvafvgr.pbz>
 <20061020205330.GK20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>,
	Shawn Pearce <spearce@spearce.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 22:56:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb1PQ-00058K-4T
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 22:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946481AbWJTUz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 16:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWJTUz7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 16:55:59 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:41972 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1030334AbWJTUz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 16:55:58 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Fri, 20 Oct 2006 13:55:57 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Fri, 20 Oct 2006 13:55:44 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061020205330.GK20017@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29539>

On Fri, 20 Oct 2006, Petr Baudis wrote:

>>> I've talked to some people who really didn't mind (or even liked) Git's
>>> heuristics when it came to _inspecting_ movement of content, but were
>>> really nervous about merge following such heuristics.
>>
>> remember, git only stores the results. so when you are merging it doesn't
>> even look for renames.
>
> Of course it does look for renames; when you use the recursive strategy,
> it will try to merge across renames.

sorry, missed that.

David Lang

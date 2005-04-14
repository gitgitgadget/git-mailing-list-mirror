From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Yet another base64 patch
Date: Thu, 14 Apr 2005 12:25:40 -0700
Message-ID: <425EC3B4.6090908@zytor.com>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org> <425E0174.4080404@zytor.com> <20050414024228.GC18655@64m.dyndns.org> <425E0D62.9000401@zytor.com> <Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org> <425EA152.4090506@zytor.com> <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org> <20050414191157.GA27696@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Christopher Li <git@chrisli.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 21:24:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM9wF-0007kY-Ok
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVDNT0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVDNT0v
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:26:51 -0400
Received: from terminus.zytor.com ([209.128.68.124]:49041 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261601AbVDNTZ5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 15:25:57 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3EJPfBN011190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Apr 2005 12:25:42 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: bert hubert <ahu@ds9a.nl>
In-Reply-To: <20050414191157.GA27696@outpost.ds9a.nl>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

bert hubert wrote:
> 
> That may be true :-), but from the "front lines" I can report that
> directories with > 32000 or > 65000 entries is *asking* for trouble. There
> is a whole chain of systems that need to get things right for huge
> directories to work well, and it often is not that way.
> 

Specifics, please?

	-hpa

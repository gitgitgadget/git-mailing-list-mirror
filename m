From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 13:59:19 -0700
Message-ID: <426FFD27.4030604@zytor.com>
References: <200504272049.NAA14598@emf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 22:57:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQtar-0001K5-Ba
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 22:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVD0VB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 17:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVD0U77
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 16:59:59 -0400
Received: from terminus.zytor.com ([209.128.68.124]:51133 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262019AbVD0U72
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 16:59:28 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3RKxPaS012001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Apr 2005 13:59:25 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Tom Lord <lord@emf.net>
In-Reply-To: <200504272049.NAA14598@emf.net>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Tom Lord wrote:
> 
> I think one has to understand Linus' posts as coming from the
> "head-down, steaming ahead for *MY* project cause you all suck"
> perspective and impose corresponding filters on his declarations of
> "LAW".  At least that's the only way *I* can make sense of his latest
> contributions.
> 
> If you get git, just do the right thing -- Linus be damned.
> 

It's fair for Linus to want to make things behave a certain way in a 
project.  There are design decisions which have tradeoffs both ways -- 
robust (but subject to partial information issues) versus brittle (but 
safe.)

That's part of why I prefer to ask first.

	-hpa

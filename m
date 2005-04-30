From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 16:14:23 -0700
Message-ID: <4274114F.20706@zytor.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE5C@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Edgar Toernig <froese@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 04:00:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS3jE-0001qL-Sr
	for gcvg-git@gmane.org; Sun, 01 May 2005 03:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVD3XOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 19:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVD3XOh
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 19:14:37 -0400
Received: from terminus.zytor.com ([209.128.68.124]:39120 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261456AbVD3XOd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 19:14:33 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3UNEOkU000948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 30 Apr 2005 16:14:24 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE5C@scsmsx401.amr.corp.intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Luck, Tony wrote:
>>Fixed version below.
> 
> 
> Yup ... that fixes it for my initial test cases.  Thanks.
> 
> -Tony
> 
> P.S. The libcurl that I found (curl-7.12.1-3.src.rpm) has curl_getdate()
> implemented as >1000 lines of yacc.  Which seems like overkill (unless
> I really need to set AUTHOR_DATE="a week ago last tuesday" :-)

That one is obsolete.

	-hpa

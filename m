From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: cg-update (cogito-0.13) bug: changed heads
Date: Tue, 06 Sep 2005 18:36:09 -0700
Message-ID: <431E4409.50307@zytor.com>
References: <431E03A5.6060709@zytor.com> <20050906231756.GC26934@pasky.ji.cz> <431E24FF.2000700@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 03:37:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECorZ-0001wJ-9w
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 03:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVIGBgR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 21:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVIGBgQ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 21:36:16 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:24227 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1751170AbVIGBgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 21:36:16 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j871aAJv014765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Sep 2005 18:36:11 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <431E24FF.2000700@zytor.com>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8160>

H. Peter Anvin wrote:
>>
>> So, C surely has its head updated? Does cg-update "fail" silently, or
>> does it utter anything?
> 
> C has its head updated, yes.  cg-update says "Branches already fully 
> merged."
> 

OK, now later in the day I could not reproduce this on another box. 
Either the situation was different enough, or I did something else wrong.

	-hpa

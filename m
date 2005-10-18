From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb.cgi
Date: Tue, 18 Oct 2005 09:52:13 -0700
Message-ID: <4355283D.2000908@zytor.com>
References: <43546492.3020401@zytor.com> <20051018110725.GB6929@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 18 18:53:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERuhI-0001vt-B1
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 18:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVJRQwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 12:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVJRQwR
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 12:52:17 -0400
Received: from terminus.zytor.com ([192.83.249.54]:30681 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751037AbVJRQwQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 12:52:16 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9IGqDD8025062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Oct 2005 09:52:14 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20051018110725.GB6929@vrfy.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10216>

Kay Sievers wrote:
> 
>>This has become particularly painful during the current one-server outage.
>>
>>Kay, gitweb really needs to be able to do caching, or be run behind a 
>>caching proxy.  Otherwise I will have to turn it off until we can come 
>>up with a dedicated piece of server hardware for it.
> 
> How about Apache's mod_cache? Worked nicely for me several times in other
> setups.
> 

I will look at it and see if I can make it work properly.

	-hpa

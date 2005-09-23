From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 0.99.7b
Date: Fri, 23 Sep 2005 12:44:17 -0700
Message-ID: <43345B11.4000009@zytor.com>
References: <7voe6ki9x7.fsf@assigned-by-dhcp.cox.net> <dh0uur$h4g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 21:46:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EItTO-0005zl-VL
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 21:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVIWToi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 15:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVIWToh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 15:44:37 -0400
Received: from terminus.zytor.com ([209.128.68.124]:2256 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751180AbVIWToh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 15:44:37 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8NJiJ9p025634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 Sep 2005 12:44:20 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dh0uur$h4g$1@sea.gmane.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9196>

walt wrote:
> Junio C Hamano wrote:
> 
>> GIT 0.99.7b
> 
> [...]
> 
>> Or, if you use git already:
>>
>>     {http,rsync}://kernel.org/pub/scm/git/git.git/
> 
> 
> I did it that way and now I see this:
> 
> $git --version
> git version 0.99.7
> 
> This is a bit confusing.  Did I upgrade or downgrade?
> Maybe the version string should contain the same kind
> of hexadecimal string that Linus is appending to his
> kernel version?
> 

Or just call it 0.99.7.1 and .2 or 0.99.8 and .9.

	-hpa

From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 17:22:06 -0800
Message-ID: <437E7E3E.4040303@zytor.com>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr> <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr> <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org> <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org> <437E51EB.7050100@zytor.com> <Pine.LNX.4.64.0511181519100.13959@g5.osdl.org> <437E6505.8000201@zytor.com> <437E697C.7090307@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 02:23:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdHQx-0005M0-Dv
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 02:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVKSBWY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 20:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVKSBWY
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 20:22:24 -0500
Received: from terminus.zytor.com ([192.83.249.54]:37253 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932166AbVKSBWX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 20:22:23 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAJ1MBUt018566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Nov 2005 17:22:18 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437E697C.7090307@op5.se>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12317>

Andreas Ericsson wrote:
>>
>> You're assuming there *IS* an original (and initially main) project.
>>
>> There is another usage mode: "we're dumping CVS and switching to this 
>> new-fangled git thing."  I have myself done this with several projects 
>> by now.
> 
> I'm guessing Linus' scenario is more common. I do it myself and I'd like 
> it to keep working.
> 

I'm not arguing that.  I'm arguing that the *option* might be useful.

	-hpa

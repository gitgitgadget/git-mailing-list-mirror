From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Does git belong in root's $PATH?
Date: Sat, 07 Jan 2006 16:39:40 -0800
Message-ID: <43C05F4C.8050908@zytor.com>
References: <Pine.LNX.4.64.0601070838470.6317@x2.ybpnyarg> <43C0025A.9080406@op5.se> <43C02725.2020702@zytor.com> <43C05ED5.1090603@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 01:40:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvObs-00084f-0x
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWAHAjr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWAHAjr
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:39:47 -0500
Received: from terminus.zytor.com ([192.83.249.54]:39631 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161109AbWAHAjp
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 19:39:45 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k080deOm013328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 Jan 2006 16:39:41 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C05ED5.1090603@op5.se>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14298>

Andreas Ericsson wrote:
> 
> I've been told that it's '/usr' simply because that's where user 
> interface tools that have nothing to do with boot-strapping resides. A 
> point emphasized by the fact that /bin, /sbin and /lib must not reside 
> on network-mounted media, while /usr may.
> 
> It seems so logical I never bothered to look in to find out for myself 
> though, so I may well be wrong, or at least younger. ;)
> 

/usr used to be what is now called /home.  What you're describing above 
is the current usage.

	-hpa

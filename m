From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: www.kernel.org/git is slow...
Date: Sat, 14 Jan 2006 13:47:05 -0800
Message-ID: <43C97159.5050907@zytor.com>
References: <20060114203654.GA10314@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ftpadmin@kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 22:47:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExtF3-0004k2-MJ
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 22:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWANVrR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 16:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWANVrR
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 16:47:17 -0500
Received: from terminus.zytor.com ([192.83.249.54]:22930 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751302AbWANVrR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 16:47:17 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0ELl5ne007873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 14 Jan 2006 13:47:07 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20060114203654.GA10314@mars.ravnborg.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14686>

Sam Ravnborg wrote:
> During the last couple of days http://www.kernel.org/git has
> been very slow.
> 
> The www.kernel.org frontpage is quick, so it looks like a gitweb
> problem, but ftpadmin put on cc: just in case.
> 

Wonder if the caching is broken, or if it's gitweb itself...

	-hpa

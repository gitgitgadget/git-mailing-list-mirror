From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: First cut at git port to Cygwin
Date: Thu, 29 Sep 2005 09:11:23 -0700
Message-ID: <433C122B.3050509@zytor.com>
References: <433B3B10.5050407@zytor.com> <Pine.LNX.4.63.0509291043580.20717@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 18:13:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL10Y-0000Ul-4J
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 18:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVI2QLi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 12:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVI2QLi
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 12:11:38 -0400
Received: from terminus.mzytor.com ([192.83.249.54]:46040 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932223AbVI2QLi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 12:11:38 -0400
Received: from [172.27.3.248] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8TGBNN1005265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Sep 2005 09:11:26 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509291043580.20717@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9490>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 28 Sep 2005, H. Peter Anvin wrote:
> 
>>Another funny which I haven't been able to figure out yet is that 'gitk'
>>scrunches all its output up into a few pixels at the top of the window.
> 
> See my mail about rootless X11. I went about working around that 
> particular Tk bug by specifying the dimensions of the panes explicitely. 
> However, I was not especially happy with my workaround, since it did not 
> reproduce the layout exactly after a restart. Maybe you can figure it out 
> how to do that.
> 

Unlikely, since I'm a complete Tcl/Tk illiterate.

	-hpa

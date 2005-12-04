From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitk - ewww
Date: Sat, 03 Dec 2005 22:05:15 -0800
Message-ID: <4392871B.1030300@zytor.com>
References: <6CC092B0-101F-4D98-9761-B4E24A7CA35A@hawaga.org.uk> <Pine.LNX.4.64.0512032040240.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ben Clifford <benc@hawaga.org.uk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 04 07:06:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ein0X-0006if-B5
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 07:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVLDGFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 01:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVLDGFy
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 01:05:54 -0500
Received: from terminus.zytor.com ([192.83.249.54]:45542 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751317AbVLDGFx
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Dec 2005 01:05:53 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB465Ggi024050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Dec 2005 22:05:17 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512032040240.3099@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13176>

Linus Torvalds wrote:
> 
> On Sun, 4 Dec 2005, Ben Clifford wrote:
> 
>>Screen shot is at:
>>http://www/hawaga.org.uk/ben/tech/gitk-eww-1.png
> 
> 
> Yes. gitk doesn't look wonderful with octopus merges, the lines start 
> crossing. Oh well. I think you have to live with it, it's done this for a 
> long time.
> 
> What makes _me_ go "eww" in that screenshot is that tcl/tk doesn't do 
> anti-aliased fonts, but maybe that's just me, and that's apparently 8.5 
> has that fixed (at a horrible performance impact, I'm sure, but hey, one 
> look at your screenshot and I'm saying "bring it on").
> 

It usually work OK for me, running on Fedora Core 4.

Clearly, though, it's Tcl/Tk version dependent; especially since it 
looks absolutely *awful* on Cygwin.

	-hpa

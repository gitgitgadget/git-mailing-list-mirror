From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Census] So who uses git?
Date: Wed, 01 Feb 2006 11:30:16 -0800
Message-ID: <43E10C48.3030405@zytor.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>  <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>  <1138446030.9919.112.camel@evo.keithp.com>  <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>  <1138529385.9919.185.camel@evo.keithp.com>  <43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home>  <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>  <20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com> <46a038f90601311852ie8cfac0rbe92779edea4da1b@mail.gmail.com> <Pine.LNX.4.64.0601311943290.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Ray Lehtiniemi <rayl@mail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 20:32:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4NiP-0006H3-JA
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 20:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422888AbWBATc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 14:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWBATc1
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 14:32:27 -0500
Received: from terminus.zytor.com ([192.83.249.54]:6855 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1422888AbWBATc0
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 14:32:26 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k11JUGpE011158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Feb 2006 11:30:17 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601311943290.7301@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15433>

Linus Torvalds wrote:
> 
> It's not magic, and it's not all that recent. Linux FS ops have always 
> been pretty good, and the dentry cache was introduced in 2.0.x, I think, 
> so you'd be hard-pressed to find a Linux system that doesn't have it.
> 

2.1.14, I seem to remember -- it was definitely 2.1.1x-ish.  I mostly 
recall because autofs didn't just break horribly, it took adding several 
dcache hooks to make it work again :)

	-hpa

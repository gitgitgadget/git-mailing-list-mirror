From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git.kernel.org move (finally)... estimated week of Feb 5
Date: Sat, 27 Jan 2007 10:59:38 -0800
Message-ID: <45BBA11A.3050407@zytor.com>
References: <45BAA82B.6000105@zytor.com> <625fc13d0701270846n710e833cnb1926e9fd51d8b59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Josh Boyer <jwboyer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 20:00:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAsmP-0006eT-Dp
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 20:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbXA0S7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 13:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbXA0S7s
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 13:59:48 -0500
Received: from terminus.zytor.com ([192.83.249.54]:38224 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbXA0S7r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 13:59:47 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l0RIxch2009842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 27 Jan 2007 10:59:40 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <625fc13d0701270846n710e833cnb1926e9fd51d8b59@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.88.7/2493/Fri Jan 26 04:00:46 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.8 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_24_48,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37982>

Josh Boyer wrote:
> On 1/26/07, H. Peter Anvin <hpa@zytor.com> wrote:
>> Just for everyone's information...
>>
>> The git performance issues (especially) on kernel.org has been very
>> frustrating, obviously.  We're putting a dedicated git server in place
>> hopefully the week of February 5.
> 
> For the hardware geeks out there, do you know what kind of machine it 
> will be?
> 

Sure... it's the DL380 G2 that used to be zeus.kernel.org.  It's not 
ideal (in particular, I would have preferred a 64-bit machine), but it 
has the advantage that it's proven itself rock-solid over the years, it 
has all the hands-off management features, we have it, and it has 6 GB RAM.

As far as filesystem is concerned, we might decide to use this machine 
to test out XFS.  Haven't made the formal decision yet.

	-hpa

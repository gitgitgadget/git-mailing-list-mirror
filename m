From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "git-send-pack"
Date: Fri, 01 Jul 2005 17:07:23 -0700
Message-ID: <42C5DABB.1020505@zytor.com>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org> <42C46A3C.1070104@zytor.com> <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org> <42C482ED.1010306@zytor.com> <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org> <42C5D553.80905@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 02:00:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoVQx-00015p-IC
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 02:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVGBAIC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 20:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVGBAIC
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 20:08:02 -0400
Received: from terminus.zytor.com ([209.128.68.124]:27332 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261638AbVGBAHw
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 20:07:52 -0400
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j6207Nkb032105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jul 2005 17:07:27 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Mike Taht <mike.taht@timesys.com>
In-Reply-To: <42C5D553.80905@timesys.com>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Mike Taht wrote:
> 
> You are getting closer and closer to where something like bitTorrent or 
> a multicast protocol makes sense. The problem isn't just the number of 
> outstanding commit objects but the number of machines and developers 
> that want to grab those commits at the same time.
> 

Not really.

	-hpa

From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Ship our own copy of subprocess.py
Date: Tue, 20 Sep 2005 10:58:31 -0700
Message-ID: <43304DC7.50604@zytor.com>
References: <432F0C66.7060402@zytor.com> <20050919200222.GA11322@c165.ib.student.liu.se> <7vslw0lqvd.fsf@assigned-by-dhcp.cox.net> <432F26E9.9090707@zytor.com> <7v7jdclpme.fsf@assigned-by-dhcp.cox.net> <432F3253.3070201@zytor.com> <20050919231704.GA19276@unpythonic.net> <432F48C7.8070405@zytor.com> <7v8xxsebsc.fsf@assigned-by-dhcp.cox.net> <7vfys0cpyj.fsf_-_@assigned-by-dhcp.cox.net> <20050920053024.GA12979@c165.ib.student.liu.se> <Pine.LNX.4.58.0509200753570.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 19:59:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHmOS-0004WN-HC
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 19:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVITR66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 13:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVITR66
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 13:58:58 -0400
Received: from terminus.zytor.com ([209.128.68.124]:15535 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964773AbVITR65
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 13:58:57 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8KHwZW4004290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Sep 2005 10:58:36 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509200753570.2553@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9011>

Linus Torvalds wrote:
> 
> Quick issue: the subprocess.py thing seems to be the old-style BSD license 
> with the anti-advertizing clause. It's not compatible with the GPL.
> 
> Now, it's arguable that this is "mere aggregation" (git is bulding a 
> mini-distribution), but still..
> 

If it's a problem, we could ask Mr. Astrand for permission:

# Copyright (c) 2003-2004 by Peter Astrand <astrand@lysator.liu.se>

	-hpa

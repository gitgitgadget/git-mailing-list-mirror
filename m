From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Email patch -> git commit?
Date: Tue, 02 Aug 2005 15:32:47 -0700
Message-ID: <42EFF48F.2050007@zytor.com>
References: <42EFF077.6080606@zytor.com> <20050802222718.GA19107@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 00:34:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E05K5-0007Z8-SB
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 00:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVHBWdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 18:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVHBWdI
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 18:33:08 -0400
Received: from terminus.zytor.com ([209.128.68.124]:4761 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261460AbVHBWdG
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 18:33:06 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j72MWvbK025521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Aug 2005 15:32:58 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050802222718.GA19107@mars.ravnborg.org>
X-Virus-Scanned: ClamAV version 0.86.1, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sam Ravnborg wrote:
> On Tue, Aug 02, 2005 at 03:15:19PM -0700, H. Peter Anvin wrote:
> 
>>Anyone have any good scripts for taking patches in email and turning 
>>them into git commits, preferrably while preserving the author information?
> 
> 
> git-applymbox seems to be what you are looking for.
> It was named dotest in the old days.
> 

Looks like it's not in cogito-0.12.1, which is why I didn't find it.  I 
guess I'll wait until the layered cogito comes out, hopefully this week.

	-hpa

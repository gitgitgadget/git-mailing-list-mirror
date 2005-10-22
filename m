From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 0.99.9 on Saturday next week.
Date: Sat, 22 Oct 2005 10:54:50 -0700
Message-ID: <435A7CEA.9090201@zytor.com>
References: <7vvezpetpv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 22 19:57:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETNad-0002wl-3l
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 19:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVJVRzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 13:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVJVRzS
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 13:55:18 -0400
Received: from terminus.zytor.com ([192.83.249.54]:23764 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750997AbVJVRzR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 13:55:17 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9MHsopq032445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Oct 2005 10:54:51 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvezpetpv.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10472>

Junio C Hamano wrote:
> 
> Although we had a good proposal for protocol rewrite from HPA
> and discussions that followed, it appeared to me that the change
> might be a bit too backward incompatible while the advantage was
> not obvious enough -- I do not think we have a consensus on it.
> 0.99.9 will not wait for this discussion to conclude.
> 

Not the least since it would be quite a bit of work to make it happen.

	-hpa

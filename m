From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb.cgi in C
Date: Thu, 08 Dec 2005 14:39:50 -0800
Message-ID: <4398B636.3010900@zytor.com>
References: <43988299.4090101@tiscali.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 23:41:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkUQx-0007er-7X
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 23:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbVLHWkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 17:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbVLHWkL
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 17:40:11 -0500
Received: from terminus.zytor.com ([192.83.249.54]:59015 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932671AbVLHWkJ
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 17:40:09 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB8MdtsB002865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Dec 2005 14:39:57 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Majkls <majkls@tiscali.cz>
In-Reply-To: <43988299.4090101@tiscali.cz>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13382>

Majkls wrote:
> What do you think about gitweb.cgi in C?

I guess you could implement and benchmark it and see how much faster it is.

	-hpa

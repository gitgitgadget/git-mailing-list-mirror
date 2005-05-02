From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb.pl on kernel.org non-functional
Date: Mon, 02 May 2005 00:00:08 -0700
Message-ID: <4275CFF8.5000503@zytor.com>
References: <4275C582.7020602@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 08:54:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSUp7-00050b-NR
	for gcvg-git@gmane.org; Mon, 02 May 2005 08:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVEBHAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 03:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVEBHAU
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 03:00:20 -0400
Received: from terminus.zytor.com ([209.128.68.124]:27803 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261249AbVEBHAQ
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2005 03:00:16 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j42708Zb030511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 May 2005 00:00:09 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <4275C582.7020602@lsrfire.ath.cx>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.5 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Rene Scharfe wrote:
> Hi,
> 
> none of the projects linked on http://www.kernel.org/git/ seem to list
> their commits anymore.  The repositories are still there, so it looks
> like a glitch in gitweb.cgi.
> 

Indeed.  I have reverted the update.

	-hpa

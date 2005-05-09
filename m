From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Pointers to CVS 2 GIT imports and gateways
Date: Sun, 08 May 2005 21:48:30 -0700
Message-ID: <427EEB9E.9070701@zytor.com>
References: <46a038f90505081616335c2a61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 06:41:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV058-0005MF-Jh
	for gcvg-git@gmane.org; Mon, 09 May 2005 06:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbVEIEsg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 00:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbVEIEsg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 00:48:36 -0400
Received: from terminus.zytor.com ([209.128.68.124]:8603 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263044AbVEIEsf
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 00:48:35 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j494mRdq011702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 8 May 2005 21:48:29 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90505081616335c2a61@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.3 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff wrote:
> 
> A related question follows: is anyone running git -> cvs gateways, and how? 
> 

What would be the point?  The reason for bkcvs was that bk wasn't 
available to everyone.

	-hpa

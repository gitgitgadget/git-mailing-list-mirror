From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Introduce SHA1_FILE_DIRECTORIES
Date: Mon, 09 May 2005 11:03:41 -0700
Message-ID: <427FA5FD.1050000@zytor.com>
References: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>    <2637.10.10.10.24.1115425225.squirrel@linux1>    <7vis1vc27f.fsf@assigned-by-dhcp.cox.net>    <2721.10.10.10.24.1115425962.squirrel@linux1>    <7vbr7nbl89.fsf@assigned-by-dhcp.cox.net>    <7vacn6ak7r.fsf@assigned-by-dhcp.cox.net> <427F6693.2080707@zytor.com>    <7vll6oz755.fsf@assigned-by-dhcp.cox.net> <3087.10.10.10.24.1115656919.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 20:45:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVCYE-0005QP-Bg
	for gcvg-git@gmane.org; Mon, 09 May 2005 20:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVEISHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 14:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVEISHV
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 14:07:21 -0400
Received: from terminus.zytor.com ([209.128.68.124]:57782 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261474AbVEISHN
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 14:07:13 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j49I3l2e028375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 May 2005 11:03:47 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <3087.10.10.10.24.1115656919.squirrel@linux1>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.6 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sean wrote:
> 
> What about creating a transition plan that uses the GIT_ name if it exists
> and the SHA1_ name if it doesn't.  And mark the SHA1_ name as depreciated.
>  That should be okay to do this week, no?
> 

Should work.

	-hpa

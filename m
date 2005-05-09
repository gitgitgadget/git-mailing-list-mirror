From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: History messup
Date: Mon, 09 May 2005 12:01:59 -0700
Message-ID: <427FB3A7.8050906@zytor.com>
References: <1115657971.19236.33.camel@tglx>	 <1115659677.16187.393.camel@hades.cambridge.redhat.com> <1115660903.19236.39.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 09 21:00:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVDQS-0003IX-8H
	for gcvg-git@gmane.org; Mon, 09 May 2005 20:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVEITDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 15:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVEITDE
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 15:03:04 -0400
Received: from terminus.zytor.com ([209.128.68.124]:12473 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261507AbVEITCy
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 15:02:54 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j49J24Is029813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 May 2005 12:02:04 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: tglx@linutronix.de
In-Reply-To: <1115660903.19236.39.camel@tglx>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.7 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thomas Gleixner wrote:
> 
> That would be really great. A line after "parents" like
> 
> repoid "username/reponame" 
> 
> would be sufficient
> 

Seems like a UUID or a SHA-1 identifier would be better.

However, one can definitely argue that even the meaning of "a 
repository" isn't well-defined in the context of git.

	-hpa

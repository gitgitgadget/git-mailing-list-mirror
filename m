From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 08:20:09 +1000
Message-ID: <4262E119.2000109@zytor.com>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 00:17:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNI4M-0000tF-MF
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 00:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVDQWUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 18:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVDQWUf
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 18:20:35 -0400
Received: from terminus.zytor.com ([209.128.68.124]:48516 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261523AbVDQWUb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 18:20:31 -0400
Received: from [172.18.240.151] ([203.53.50.91])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3HMKB5F001693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 17 Apr 2005 15:20:14 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have set up /pub/scm/linux/kernel/git on kernel.org.  Everyone who had 
directories in /pub/linux/kernel/people now have directories in 
/pub/scm/linux/kernel/git.  For non-kernel trees it would probably be 
better to have different trees, however; I also would like to request 
that git itself is moved to /pub/software/scm/git; I have created that 
directory and made it owned by Linus.

	-hpa

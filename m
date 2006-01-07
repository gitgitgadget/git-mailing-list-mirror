From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Stgit - gitmergeonefile.py: handle removal vs. changes
Date: Sat, 07 Jan 2006 11:23:05 +0000
Message-ID: <43BFA499.3020202@gmail.com>
References: <20051113194225.20447.57910.stgit@zion.home.lan> <b0943d9e0511150154y2d2af24ck@mail.gmail.com> <200512301859.51000.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 12:23:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvCAC-000439-Gy
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 12:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWAGLXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 06:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbWAGLXJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 06:23:09 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:37822 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1030413AbWAGLXI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 06:23:08 -0500
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20060107112307.UGCV17804.mta08-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Sat, 7 Jan 2006 11:23:07 +0000
Received: from [192.168.1.101] (really [81.104.194.137])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20060107112307.FHLN10196.aamta09-winn.ispmail.ntl.com@[192.168.1.101]>;
          Sat, 7 Jan 2006 11:23:07 +0000
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Blaisorblade <blaisorblade@yahoo.it>
In-Reply-To: <200512301859.51000.blaisorblade@yahoo.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14259>

Blaisorblade wrote:

>The original patch hasn't been merged, nor (for what I see) anything else to 
>fix this problem has been done.
>  
>
Indeed, I forgot about it.

>I assume the patch was lost waiting for the discussion to settle down, but the 
>patch can be merged, even changing the default choices in any way (see 
>below).
>  
>
I merged it as it is. I will think about the default options once I get
some time to fix the .local, .older and .remote extensions (give them
some meaningful names).

>Also, another note: I just found Bruce Eckel mentioning pychecker, which is a 
>static code checker for Python (to perform the checks a compiler would 
>normally do). I've not the time to investigate more myself, but I hope it can 
>be useful to you.
>  
>
Thanks. I'll give it a try.

Catalin

From: jeff millar <wa1hco@adelphia.net>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 16:33:49 -0400
Message-ID: <429B78AD.3080109@adelphia.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon May 30 22:32:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcquy-0003M3-Jh
	for gcvg-git@gmane.org; Mon, 30 May 2005 22:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVE3Udz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 16:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVE3Udz
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 16:33:55 -0400
Received: from mta9.adelphia.net ([68.168.78.199]:6386 "EHLO mta9.adelphia.net")
	by vger.kernel.org with ESMTP id S261744AbVE3Udu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 16:33:50 -0400
Received: from [192.168.2.4] (really [24.52.167.181]) by mta9.adelphia.net
          (InterMail vM.6.01.04.01 201-2131-118-101-20041129) with ESMTP
          id <20050530203349.TIBF8952.mta9.adelphia.net@[192.168.2.4]>;
          Mon, 30 May 2005 16:33:49 -0400
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:

>So before I do that, is there something people think is just too hard for
>somebody coming from the CVS world to understand? 
>
I'm a fairly clueless cvs user, trying to use cg/git as a way to track a 
single
user project...using cogito, because that's easier, right?

The usage pattern that causing me problems right now.

cg-init a whole directory tree (trying with /etc and a software project 
directory)
note that too many files got included (*.cache, *.backup, *.o, binaries, 
etc)
want to stop tracking them, cg-rm also removes the file, don't want that.

What's the best way to stop tracking files?

jeff

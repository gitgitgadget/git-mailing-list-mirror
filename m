From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Sat, 1 Oct 2005 00:52:07 +0200
Message-ID: <20050930225207.GC24548@electric-eye.fr.zoreil.com>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com> <433C4B6D.6030701@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net> <433D1E5D.20303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 00:56:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELTnZ-00072Y-HC
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 00:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbVI3W4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 18:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030495AbVI3W4H
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 18:56:07 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:50117 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1030498AbVI3W4F
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 18:56:05 -0400
Received: from electric-eye.fr.zoreil.com (localhost.localdomain [127.0.0.1])
	by fr.zoreil.com (8.13.4/8.12.1) with ESMTP id j8UMq7Ck031293;
	Sat, 1 Oct 2005 00:52:08 +0200
Received: (from romieu@localhost)
	by electric-eye.fr.zoreil.com (8.13.4/8.12.1) id j8UMq78d031292;
	Sat, 1 Oct 2005 00:52:07 +0200
To: Jeff Garzik <jgarzik@pobox.com>
Content-Disposition: inline
In-Reply-To: <433D1E5D.20303@pobox.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9577>

Jeff Garzik <jgarzik@pobox.com> :
[...]
> Thanks for all the comments.  I just updated the KHGtG with the feedback 
> I received.  Go to
> 
> 	http://linux.yyz.us/git-howto.html
> 
> and click reload.  Continued criticism^H^H^Hcomments welcome!

The basic tasks make no use of git-whatchanged.

Even if it is a CVSism, it is quite handful to retrieve the history of
the patchsets by aiming at a specific file.

--
Ueimor

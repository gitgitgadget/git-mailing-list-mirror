From: Kevin Leung <hysoka@gmail.com>
Subject: Re: Edit log message after commit
Date: Thu, 29 Sep 2005 15:45:49 +0800
Message-ID: <dhg5vl$9ac$1@sea.gmane.org>
References: <dhfjcu$36f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 29 09:48:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKt8K-00082n-9z
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 09:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVI2HrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 03:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVI2HrI
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 03:47:08 -0400
Received: from main.gmane.org ([80.91.229.2]:29595 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932097AbVI2HrH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 03:47:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EKt6s-0007kn-2Y
	for git@vger.kernel.org; Thu, 29 Sep 2005 09:45:42 +0200
Received: from cm218-255-247-62.hkcable.com.hk ([218.255.247.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Sep 2005 09:45:42 +0200
Received: from hysoka by cm218-255-247-62.hkcable.com.hk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Sep 2005 09:45:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm218-255-247-62.hkcable.com.hk
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
In-Reply-To: <dhfjcu$36f$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9474>

Thank you all of you. I was able to redo the commit.

But as Tony has pointed out. I would have needed to redo all the subsequent commits if I was to change non-HEAD commit message. What is the proper way of doing that? Is it the same as Documentation/howto/revert-branch-rebase.txt ?

One more question is that, how to use the git commit --reedit-message flag? According to Documentation/howto/rebase-and-edit.txt, I guess the meaning is to re-apply one commit to current HEAD?

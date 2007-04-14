From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: GIT and the current -stable
Date: Sat, 14 Apr 2007 11:15:00 -0400
Message-ID: <5A4D6434-3DF2-4CC7-B363-260E5F945F72@silverinsanity.com>
References: <46206842.80203@gmail.com> <20070414083410.GU6602@sequoia.sous-sol.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rene Herman <rene.herman@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 17:15:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hcjy9-0002RY-F9
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 17:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbXDNPPM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 11:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbXDNPPM
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 11:15:12 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:42014 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbXDNPPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 11:15:11 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id C6CEE1FFC003;
	Sat, 14 Apr 2007 15:15:06 +0000 (UTC)
In-Reply-To: <20070414083410.GU6602@sequoia.sous-sol.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44460>


On Apr 14, 2007, at 4:34 AM, Chris Wright wrote:

> I've already put a tree like this up on kernel.org.  The master branch
> is Linus' tree, and there's branches for each of the stable releases
> called linux-2.6.[12-20].y (I didn't add 2.6.11.y).
>
> http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6- 
> stable.git;a=summary

Is HEAD for that repo the most recent stable branch, or (as gitweb  
makes it look) Linus's head.  I'd expect a "-stable" repo to point at  
the most recent stable commit, not the most recent development  
commit.  And I'd also expect gitweb's summary page to show the  
shortlog for HEAd.  One of my assumptions are being broken and I  
don't like it.  It leaves me all confused...

(I'd just clone your repo and look for myself, but I'm still pulling  
Linus's tree for the first time and I don't have a fast connection.)

~~ Brian

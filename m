From: Martin Coxall <quasi@cream.org>
Subject: Re: What to expect after 0.99.8
Date: Mon, 3 Oct 2005 20:55:58 +0100
Message-ID: <96785d706a5ed4395e234c860bfe2255@cream.org>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031522590.23242@iabervon.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 03 21:57:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMWPy-00055z-HY
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 21:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbVJCT4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 15:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbVJCT4G
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 15:56:06 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:22288 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S932663AbVJCT4E
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 15:56:04 -0400
Received: from [192.168.0.4] (unknown [84.12.75.194])
	by smtp.nildram.co.uk (Postfix) with ESMTP id 44F4924E9CF
	for <git@vger.kernel.org>; Mon,  3 Oct 2005 20:55:55 +0100 (BST)
In-Reply-To: <Pine.LNX.4.63.0510031522590.23242@iabervon.org>
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.623)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9648>

> I'd also like to add:
>
>  * Accept patches to fetch multiple objects by HTTP in parallel.
>

Indeed. As a humble user of git for our inhouse development, I can 
vouch that HTTP pulling on unpacked repositories (i.e. all of them, it 
seems) is appalling. Ship a 1.0 without addressing this, then I imagine 
the Mercurial devs will haemorrage with their Pythonesque mocking. ;p

Martin

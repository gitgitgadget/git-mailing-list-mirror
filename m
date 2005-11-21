From: Andreas Ericsson <ae@op5.se>
Subject: Re: default update hook broken
Date: Mon, 21 Nov 2005 19:08:11 +0100
Message-ID: <43820D0B.6000006@op5.se>
References: <20051121140914.GB1598@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 21 19:12:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeG5S-0000aU-Lr
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 19:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVKUSIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 13:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVKUSIO
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 13:08:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53891 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932442AbVKUSIM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 13:08:12 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 3AB9B6BD08
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 19:08:11 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051121140914.GB1598@parisc-linux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12464>

Matthew Wilcox wrote:
> There's two syntax errors and one good-netizen error in the hooks/update
> file created when cloning Linus' linux-2.6.git repo.  I don't know
> if that file is created fresh or if it gets pulled from Linus' tree.
> Here's a patch to fix it
> 

Good thing I read new list entries before I send things. I did this 
exact same patch too. :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

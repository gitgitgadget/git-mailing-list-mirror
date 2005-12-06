From: Mike McCormack <mike@codeweavers.com>
Subject: Re: Wine + GIT
Date: Wed, 07 Dec 2005 04:06:13 +0900
Message-ID: <4395E125.2050101@codeweavers.com>
References: <4394CD68.8020500@codeweavers.com> <4394F173.6000505@pobox.com> <20051206170803.GD17457@fieldses.org> <4395E01D.4080107@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 20:07:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eji8Y-0006Bm-2o
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 20:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbVLFTFv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 14:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbVLFTFv
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 14:05:51 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:51892 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1030182AbVLFTFu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 14:05:50 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1Eji8H-00013j-Ta; Tue, 06 Dec 2005 13:05:48 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: en-us, en
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <4395E01D.4080107@pobox.com>
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13286>

Jeff Garzik wrote:

> In general, there is not much difference, except that I was admonished 
> to avoid the git-XXX in my howto.  I suppose that makes sense if the 
> git-XXX programs are moved out of $prefix/bin, leaving only 
> $prefix/bin/git.

Using the git-* commands means that tab completion works, which is good 
for impatient people with bad memories, like myself :)

Mike

From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] gitk - Allow specifying tabstop as other than default 8
 characters.
Date: Sun, 20 May 2007 12:14:40 -0400
Message-ID: <465073F0.8030608@verizon.net>
References: <11796759503065-git-send-email-mdl123@verizon.net>
 <11796759513709-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org, git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Sun May 20 18:15:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpo3c-0006SR-2X
	for gcvg-git@gmane.org; Sun, 20 May 2007 18:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757910AbXETQOw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 12:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758124AbXETQOw
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 12:14:52 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:52083 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757820AbXETQOv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 12:14:51 -0400
Received: from [127.0.0.1] ([71.126.129.225])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JIC0043KL4GGNH8@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 20 May 2007 11:14:41 -0500 (CDT)
In-reply-to: <11796759513709-git-send-email-mdl123@verizon.net>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47853>

Mark Levedahl wrote:
> Not all projects use the convention that one tabstop = 8 characters, and...
>   
...except that I forgot to include the first patch in the series to 
allow changing highlight color, that one follows
and must be applied first or this patch will not apply.

Mark

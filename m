From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: Mark Levedahl's gitk patches
Date: Mon, 25 Jun 2007 22:41:51 -0400
Message-ID: <46807CEF.2010109@verizon.net>
References: <467FE7C4.5E421535@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: Johannes Sixt <J.Sixt@eudaptics.com>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 04:42:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I310K-0004Ep-Tt
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 04:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbXFZCl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 22:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbXFZCl7
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 22:41:59 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:49225 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbXFZCl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 22:41:58 -0400
Received: from [127.0.0.1] ([71.126.129.74])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JK8001UO25RA0N1@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 25 Jun 2007 21:41:54 -0500 (CDT)
In-reply-to: <467FE7C4.5E421535@eudaptics.com>
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50941>

Johannes Sixt wrote:
> Is there a chance that we get Mark Levedahl's gitk patches into 1.5.3:
>
>   
I found a bug in the highlight patch (the color picker updated the wrong 
panel in the chooser but did set the correct color), and updated the 
tab-stop patch to use a spin control to enforce entry of small integers 
only. As there is possible interest, I am sending the amended series.

Mark

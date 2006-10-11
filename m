From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Release 1.4.2 build failure
Date: Wed, 11 Oct 2006 11:12:39 -0400
Message-ID: <452D09E7.10709@cfl.rr.com>
References: <452C00FD.1020307@cfl.rr.com> <7vejtfzur8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 17:14:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXfl4-0000ca-09
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 17:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbWJKPMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 11:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbWJKPMa
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 11:12:30 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:8611 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S965223AbWJKPMa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 11:12:30 -0400
Received: from [10.1.1.235] ([10.1.1.235]) by iradimed.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 11 Oct 2006 11:12:38 -0400
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejtfzur8.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 11 Oct 2006 15:12:38.0933 (UTC) FILETIME=[B0AE9450:01C6ED47]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14744.002
X-TM-AS-Result: No--14.026200-5.000000-31
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28719>

Yes, I think the debian build system does that.  I must have missed the 
newer 1.4.2.x releases when scanning the directory.  Thanks.

Junio C Hamano wrote:
> Are you by any chance running the test with the stdin connected
> to </dev/null?
> 
> If so, the fix is in 1.4.2.2.
> 
> BTW, the latest "maint" release is 1.4.2.3 and we have 1.4.3-rc2
> from the "master" branch.
> 

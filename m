From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: gitk - fails to highlight commits
Date: Wed, 04 Jul 2007 09:34:26 -0400
Message-ID: <468BA1E2.5040509@verizon.net>
References: <468AED7C.5040507@verizon.net>
 <18059.35942.150086.936853@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 15:34:32 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6503-00052j-Cj
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 15:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758986AbXGDNe3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 09:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758322AbXGDNe3
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 09:34:29 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:50618 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758207AbXGDNe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 09:34:28 -0400
Received: from [192.168.100.117] ([72.66.70.164])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JKN00B32PPE7RIB@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 04 Jul 2007 08:34:27 -0500 (CDT)
In-reply-to: <18059.35942.150086.936853@cargo.ozlabs.ibm.com>
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51613>

Paul Mackerras wrote:
> This is fixed by a commit I just pushed out ("gitk: Fix the find and
> highlight functions").
>
> Paul.
>   
Thanks - that fixed the problem.

Mark

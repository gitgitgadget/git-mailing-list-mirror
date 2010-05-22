From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Changing indents
Date: Fri, 21 May 2010 22:46:04 -0400
Message-ID: <F19D8C01-CDA8-4381-94EC-4105E70A92CA@kellerfarm.com>
References: <C0CDDC0A-A813-41C3-8CEC-40EFADFB5A4A@kellerfarm.com> <m3vdahqkuw.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 22 04:46:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFejF-0001NS-BW
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 04:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758281Ab0EVCqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 22:46:11 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:47651 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752382Ab0EVCqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 22:46:09 -0400
Received: from c-208-53-115-13.customer.broadstripe.net ([208.53.115.13] helo=[192.168.0.104])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1OFeir-0004cr-JT
	for git@vger.kernel.org; Fri, 21 May 2010 22:45:57 -0400
In-Reply-To: <m3vdahqkuw.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.1078)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147505>

On May 21, 2010, at 12:30 PM, Jakub Narebski wrote:
> Andrew Keller <andrew@kellerfarm.com> writes:
>> Is it possible to change the indent of a line (or multiple lines)
>> without rewriting the whole line?  Or, more specifically, can a
>> commit exist that modifies the leading whitespace of a line but
>> still allows you to trace the origin of the line to a previous
>> commit?
> 
> Whatever for?  Use "git blame -w <file>" (ignore whitespace).

Because I forgot about -w of blame...

Thanks,
~ Andrew Keller

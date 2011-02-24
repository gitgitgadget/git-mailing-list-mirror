From: Chris Friesen <chris.friesen@genband.com>
Subject: Re: [feature request] embed original commit info in cherry-pick
Date: Thu, 24 Feb 2011 13:17:53 -0600
Message-ID: <4D66AEE1.8010809@genband.com>
References: <4D66A3C9.7050001@genband.com> <20110224191214.GC4318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 20:18:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psghb-000734-5b
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 20:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926Ab1BXTSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 14:18:11 -0500
Received: from exprod7og108.obsmtp.com ([64.18.2.169]:56680 "EHLO
	exprod7og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab1BXTSK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 14:18:10 -0500
Received: from source ([63.149.188.88]) (using TLSv1) by exprod7ob108.postini.com ([64.18.6.12]) with SMTP
	ID DSNKTWau7maO4Y85OVfUejoMNRV4ihPPeTYz@postini.com; Thu, 24 Feb 2011 11:18:09 PST
Received: from gbausmail.genband.com ([172.16.21.55]) by mail.genband.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 24 Feb 2011 13:17:55 -0600
Received: from localhost.localdomain ([1.220.17.171]) by gbausmail.genband.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 24 Feb 2011 13:17:55 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc11 Thunderbird/3.0.4
In-Reply-To: <20110224191214.GC4318@sigill.intra.peff.net>
X-OriginalArrivalTime: 24 Feb 2011 19:17:55.0120 (UTC) FILETIME=[89E94300:01CBD457]
X-TM-AS-Product-Ver: SMEX-8.0.0.4160-6.500.1024-17976.001
X-TM-AS-Result: No--8.999900-5.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167852>

On 02/24/2011 01:12 PM, Jeff King wrote:
> On Thu, Feb 24, 2011 at 12:30:33PM -0600, Chris Friesen wrote:
>> If I cherry-pick a  bugfix from a more recent version of a project, it
>> would be useful to have an indication somewhere in the commit
>> information of where it originally came from.
> 
> Have you tried cherry-pick -x?

Okay, I'm an idiot.  Thanks for the pointer, sorry for the noise.

Chris

-- 
Chris Friesen
Software Developer
GENBAND
chris.friesen@genband.com
www.genband.com

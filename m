From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: Clone corruption to G4 MacOSX
Date: Tue, 2 Oct 2007 22:50:23 -0700
Message-ID: <AF1E5F5F-84BF-47DC-B893-23B459B75193@cs.indiana.edu>
References: <82638874-6766-4DCD-BF5B-3893F9B5046F@cs.indiana.edu> <20071003052834.GC13738@fattire.cabal.ca>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
X-From: git-owner@vger.kernel.org Wed Oct 03 07:50:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icx83-00085N-4A
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 07:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbXJCFub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 01:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbXJCFub
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 01:50:31 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:45344 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbXJCFua (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 01:50:30 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.80) with ESMTP id l935oSQZ010990;
	Wed, 3 Oct 2007 01:50:29 -0400
Received: from [192.168.1.65] (pool-71-111-64-33.ptldor.dsl-w.verizon.net [71.111.64.33])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id l935oOx8005302
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 3 Oct 2007 01:50:28 -0400
In-Reply-To: <20071003052834.GC13738@fattire.cabal.ca>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59792>

Yeah, that'd be it.  Thanks!

-- Perry


On Oct 2, 2007, at 10:28 PM, Kyle McMartin wrote:

> On Tue, Oct 02, 2007 at 09:29:07PM -0700, Perry Wagle wrote:
>> If I clone Linus's repository to a x86 machine, I get no corruption.
>>
>> My wild ass guess is that being big-endian is causing trouble.
>>
>
> The problem is MacOSX uses a case-insensitive filesystem by default...
>
> Cheers,
> 	Kyle
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

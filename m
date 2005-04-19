From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: [script] ge: export commits as patches
Date: Tue, 19 Apr 2005 18:56:23 -0400
Message-ID: <42658C97.5090409@dwheeler.com>
References: <20050419134843.GA19146@elte.hu> <20050419170320.GG12757@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:52:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1Zn-0008Mm-8S
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVDSW40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVDSW40
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:56:26 -0400
Received: from cujo.runbox.com ([193.71.199.138]:47010 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261723AbVDSW4Y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 18:56:24 -0400
Received: from [10.9.9.110] (helo=snoopy.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DO1dn-0006d3-17; Wed, 20 Apr 2005 00:56:23 +0200
Received: from [129.246.254.178] (helo=[129.246.80.140])
	by snoopy.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DO1dm-0001wL-OR; Wed, 20 Apr 2005 00:56:22 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419170320.GG12757@pasky.ji.cz>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>Dear diary, on Tue, Apr 19, 2005 at 03:48:43PM CEST, I got a letter
>where Ingo Molnar <mingo@elte.hu> told me that...
>  
>
>>is there any 'export commit as patch' support in git-pasky?
>>    
>>
>
>Nice idea. I will add it, probably as 'git patch'.
>
>  
>
Eek!

It's a nice idea, and it'd be great as a subcommand.  But PLEASE
don't name it "patch".  I already know what "patch" does, "patch"
ACCEPTS a patch... it doesn't create one ;-).

How about naming it "aspatch" or "asdiff" instead?  Or something else
(good names, anyone?).

<soapbox_to_choir>Good externally-viewed names are critical... good
command names that are similar to what people "already know"
can really help make the tool a joy to use.</soapbox_to_choir>

--- David A. Wheeler



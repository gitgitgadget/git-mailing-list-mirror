From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 12:54:56 -0700
Message-ID: <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu>
References: <20080826164526.GM26610@one.firstfloor.org> <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu> <20080827195019.GA9962@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	Andi Kleen <andi@firstfloor.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:57:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYR8k-0005sY-QY
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 21:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbYH0T4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 15:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbYH0T4J
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:56:09 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:34688 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbYH0T4I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 15:56:08 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7RJt2oW005734;
	Wed, 27 Aug 2008 15:55:03 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7RJsvlb020016
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 27 Aug 2008 15:55:01 -0400
In-Reply-To: <20080827195019.GA9962@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93935>


On Aug 27, 2008, at 12:50 PM, Jeff King wrote:

> On Wed, Aug 27, 2008 at 12:43:23PM -0700, Perry Wagle wrote:
>
>> Doing git-<tab> was shocking to me at first, but it also showed me  
>> a list
>> of commands for me to learn.
>>
>> Now I guess that when everything's fixed up, I'll have to put in a  
>> space
>> instead of a dash to get exactly the same thing.
>>
>> What difference did changing the dash to a space make?
>
> Did you miss the part of the thread about how it's not exactly the  
> same
> thing, but rather substantially fewer commands (and there is even
> additional discussion about _which_ commands)?

I guess I did.  Being an optimist, I wouldn't expect the tab  
completion to *lie* and leave things out.

-- Perry

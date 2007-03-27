From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Listing of branch creation time?
Date: Tue, 27 Mar 2007 15:51:36 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703271549210.15345@qynat.qvtvafvgr.pbz>
References: <17929.37382.984339.742025@lisa.zopyra.com><20070327233552.GA718
 6@coredump.intra.peff.net><17929.45060.6228.797279@lisa.zopyra.com><2007032
 8000149.GA12808@coredump.intra.peff.net><17929.45543.421196.935796@lisa.zop
 yra.com><20070328001027.GA13293@coredump.intra.peff.net>
 <17929.45908.803852.973157@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 02:18:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWLrn-0006Tp-4o
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 02:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965380AbXC1ASQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 20:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965393AbXC1ASQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 20:18:16 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:37205 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S965380AbXC1ASP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 20:18:15 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 27 Mar 2007 16:18:15 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 27 Mar 2007 17:18:02 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <17929.45908.803852.973157@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43334>

On Tue, 27 Mar 2007, Bill Lear wrote:

> On Tuesday, March 27, 2007 at 20:10:27 (-0400) Jeff King writes:
>> On Tue, Mar 27, 2007 at 06:08:07PM -0600, Bill Lear wrote:
>>
>>> Queries that help me answer the question of "did I merge this
>>> branch?", "when did I merge it?" (i.e., "Can I delete this branch?"),
>>> along with creation times and last modified times, I think would be
>>> helpful.
>>
>> I find that a nice 'gitk branch...origin' answers most of those for me
>> (it's everything in both branches going back to the last time they
>> merged).
>
> Hmm, perhaps I should learn to use gitk more, though I must admit
> to being somewhat of an anti-GUI bigot (i.e., lazy).

given that we had someone post a tool to the list that creates ascii-art merge 
diagrams, I wonder if it would scratch anyone's itch to make an ascii output 
version of gitk?

the code posted was limited to 26 merges, but it would probably be easy enough 
to do two-letter nodes (although at that point do you _really_ want it on a text 
screen ;-)

David Lang

From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git docs on kernel.org too new?
Date: Thu, 1 Feb 2007 13:21:50 -0600 (CST)
Message-ID: <Pine.LNX.4.62.0702011319590.31498@torch.nrlssc.navy.mil>
References: <Pine.LNX.4.62.0702011051300.31498@torch.nrlssc.navy.mil>
 <20070201191747.GB18608@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 20:22:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HChVQ-0000df-4Z
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 20:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422958AbXBATV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 14:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422959AbXBATV5
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 14:21:57 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50267 "EHLO
	mail1.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422958AbXBATV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 14:21:56 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail1.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l11JLPKt002282
	for <git@vger.kernel.org>; Thu, 1 Feb 2007 13:21:28 -0600
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 1 Feb 2007 13:21:51 -0600
In-Reply-To: <20070201191747.GB18608@spearce.org>
X-OriginalArrivalTime: 01 Feb 2007 19:21:51.0413 (UTC) FILETIME=[39BBB650:01C74636]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-14970000
X-TM-AS-Result: : No
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE0NzAxOC03MDI1?=
	=?us-ascii?B?NzItNzAwMDc1LTEzOTAxMC03MDAxNjAtNzA0NDEwLTEwNTcwMC0x?=
	=?us-ascii?B?Mzk3MDQtMTA2NTgwLTcwMDA0MC03MDQ3MTItNzAwOTA5LTcwNDcw?=
	=?us-ascii?B?OC03MDE0NTUtNzA5MDY1LTcwMzMzNC03MDI3MjYtNzAxNjE4LTcw?=
	=?us-ascii?B?NDg2NC03MDA3NDMtNzAyNjYzLTcwNDQyNS03MDAxMDctMTQ4MDUw?=
	=?us-ascii?B?LTIwMDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38391>

On Thu, 1 Feb 2007, Shawn O. Pearce wrote:

> Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> The git documentation here:
>>
>>   http://www.kernel.org/pub/software/scm/git/docs/
>>
>> does not seem to describe the current stable release of
>> git: git-1.4.4.4 (there is a release candidate of 1.5.0 on kernel.org)
>
> Yes.  The docs on kernel.org roughly track the `master` branch
> of git.git, which is stablizing the 1.5.0 release.  Git 1.5.0-rc3
> was posted last night, and with the exception of a couple of minor
> cleanups for the detached HEAD warning messages, will be the 1.5.0
> final release.

Ah. I thought you might be doing something clever like that.

> Despite being a release candidate I think we would all encourage
> you to try working with 1.5.0-rc3 or later.  It is extremely stable,
> the documentation has been significantly improved and updated since
> 1.4.4.4, and the learning curve should be easier for new users.

will do, thanks.

-brandon

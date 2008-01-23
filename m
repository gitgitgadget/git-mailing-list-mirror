From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git-commit: exit non-zero if we fail to commit the index
Date: Wed, 23 Jan 2008 14:47:26 -0600
Message-ID: <4797A7DE.7000604@nrlssc.navy.mil>
References: <7vfxwpqvfg.fsf@gitster.siamese.dyndns.org>	<47977792.5080001@nrlssc.navy.mil> <7vzluwgvls.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 21:49:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHmWz-0003un-HK
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 21:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbYAWUsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 15:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbYAWUsk
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 15:48:40 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46890 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbYAWUsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 15:48:39 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0NKlQng021303;
	Wed, 23 Jan 2008 14:47:27 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Jan 2008 14:47:26 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vzluwgvls.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 23 Jan 2008 20:47:26.0207 (UTC) FILETIME=[295E18F0:01C85E01]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15680001
X-TM-AS-Result: : Yes--15.431300-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwMTYwLTcwMzczMS03MDE1MDAtNzAwNjU2LTcwMDk0OS03?=
	=?us-ascii?B?MDM3ODgtNzAxNDU1LTE0ODAzOS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71568>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:

>> Oh, I had /ASS/u/ME/d this was simple enough that the one-liner
>> was sufficient.
> 
> I do not get the funny punctuation, sorry.

An old joke. I made an assumption and when you _assume_ you make an

     _ASS_ out of _U_ and _ME_

:)

-brandon

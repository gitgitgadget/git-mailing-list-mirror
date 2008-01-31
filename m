From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 1/2] filter-branch: only print usage information when
 no arguments supplied
Date: Wed, 30 Jan 2008 20:05:37 -0600
Message-ID: <47A12CF1.1010801@nrlssc.navy.mil>
References: <47A109A7.1070502@nrlssc.navy.mil>	<47A112C5.8010903@nrlssc.navy.mil> <7v3asehj5s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 03:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKOp2-0000gM-5Y
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 03:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383AbYAaCGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 21:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754911AbYAaCGB
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 21:06:01 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37586 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbYAaCGA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 21:06:00 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0V25bAZ012849;
	Wed, 30 Jan 2008 20:05:38 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jan 2008 20:05:37 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7v3asehj5s.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 31 Jan 2008 02:05:37.0810 (UTC) FILETIME=[C5BDC720:01C863AD]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--14.168700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwMTYwLTcwMzczMS03MDQwMzQtNzAwNzI2LTcwNDE4Mi03?=
	=?us-ascii?B?MDM0MzctNzA2ODkxLTcwNzIyNS03MDczNjEtNzAzNzEyLTcwMjA2?=
	=?us-ascii?B?Ny03MDE0NTUtNzAxMDk5LTcwNDA0OS0xODgwMTktNzA5NTg0LTE0?=
	=?us-ascii?B?ODAzOS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72090>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>>
>> I prefer my original patch since I think it is consistent
>> with the git interface.
> 
> I'd refrain from commenting on if it is consistent or not with
> "the git interface".

I'm not sure whether you're saying that _I_ should refrain from
making comments about "git interface" consistencies? If that's
the case, I hope you see I stated it as an opinion by saying
"I think" and I don't presume to have contributed anything but
a few minor patches. If I would have thought about it for more
than a split second I would have said "...since I think it is
more consistent with what other git tools do."

or whether you're just saying git is still in flux and there is
no "git interface"...

-brandon

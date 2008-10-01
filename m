From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH 3/9] Docs: send-email: Man page option ordering
Date: Wed, 1 Oct 2008 15:34:47 -0500
Message-ID: <26288097-F87A-4F93-B030-40598D65BEEE@mit.edu>
References: <20080929174445.GA6015@coredump.intra.peff.net> <1222779512-58936-1-git-send-email-mfwitten@mit.edu> <1222779512-58936-2-git-send-email-mfwitten@mit.edu> <1222779512-58936-3-git-send-email-mfwitten@mit.edu> <20081001032701.GC24513@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 01 22:36:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl8Qd-0004BJ-DI
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 22:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbYJAUe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 16:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753938AbYJAUe6
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 16:34:58 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:56191 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753124AbYJAUe6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2008 16:34:58 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m91KYoVm003567;
	Wed, 1 Oct 2008 16:34:50 -0400 (EDT)
Received: from [192.168.0.65] (97-116-104-2.mpls.qwest.net [97.116.104.2])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m91KYlwi020444
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2008 16:34:49 -0400 (EDT)
In-Reply-To: <20081001032701.GC24513@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.929.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97264>


On 30 Sep 2008, at 10:27 PM, Jeff King wrote:

> On Tue, Sep 30, 2008 at 07:58:26AM -0500, Michael Witten wrote:
>
>> Now the man page lists the options in alphabetical
>> order (in terms of the 'main' part of an option's
>> name).
>>
>> Signed-off-by: Michael Witten <mfwitten@mit.edu>
>
> After following this series through a number of revisions,
> it looks good to me now. So
>
> Acked-by: Jeff King <peff@peff.net>
>
> for the whole series.
>
> I believe this particular patch is probably redundant, since
> 8/9 just re-orders the manpage again later. So it could be
> dropped if somebody feels like doing the work to rebase the
> later patches.

I would suggest just leaving it there; it fixes a genuine
problem regardless of what the future patches do.

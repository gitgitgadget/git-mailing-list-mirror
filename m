From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Improve use of lockfile API
Date: Wed, 16 Jan 2008 13:36:19 -0600
Message-ID: <478E5CB3.8050401@nrlssc.navy.mil>
References: <478E572E.3020505@nrlssc.navy.mil> <7v4pddr2jy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:38:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFE5B-0004r5-Tf
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 20:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbYAPThX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 14:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbYAPThW
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 14:37:22 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44165 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbYAPThV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 14:37:21 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0GJaKln027486;
	Wed, 16 Jan 2008 13:36:20 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 13:36:20 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7v4pddr2jy.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 16 Jan 2008 19:36:20.0166 (UTC) FILETIME=[11B7A660:01C85877]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--14.792800-0-4-1
X-TM-AS-Category-Info: : 4:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwNzUyLTcwOTUxMC03MDUxNjctNzAzNDkxLTcwMzQyOC03?=
	=?us-ascii?B?MDIyNzEtNzAyMDE2LTcwNDQyMS0xMDYyMzAtNzAwMTYwLTcwMzc4?=
	=?us-ascii?B?OC03MDE0NTUtMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70732>

Junio C Hamano wrote:
> Ok, our mails crossed.  I'll scrap part of my [2/2] and queue
> this series perhaps to 'next' after review.

Yeah, I received yours while I was readying mine.

Also, I forgot to add signed-off. So please add:

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

when you commit, or I can resend if you like.

-brandon

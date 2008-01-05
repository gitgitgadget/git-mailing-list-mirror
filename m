From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] builtin-reflog.c: typo ref --> argv[i], could cause segfault
Date: Fri, 04 Jan 2008 19:35:55 -0600
Message-ID: <477EDEFB.7020909@nrlssc.navy.mil>
References: <477ED949.1030909@nrlssc.navy.mil> <7vzlvlf4n9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 02:36:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAxxq-0004w0-W5
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 02:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbYAEBgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 20:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbYAEBgM
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 20:36:12 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51143 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbYAEBgL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 20:36:11 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m051ZtwJ002847;
	Fri, 4 Jan 2008 19:35:55 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 4 Jan 2008 19:35:55 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vzlvlf4n9.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 05 Jan 2008 01:35:55.0451 (UTC) FILETIME=[50A1E0B0:01C84F3B]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15638001
X-TM-AS-Result: : Yes--9.203300-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : 
	150567-150657-150675-700075-139010-702187-702057-705388-148039-148051
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69628>

Junio C Hamano wrote:
> Bad Brandon!  Looking at 'next' while everybody is asked to work
> on finding and fixing bugs on 'master' while -rc freeze.

No more, I promise. :)

-brandon

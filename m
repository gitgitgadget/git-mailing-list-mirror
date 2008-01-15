From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Tue, 15 Jan 2008 12:27:11 -0600
Message-ID: <478CFAFF.6010006@nrlssc.navy.mil>
References: <4787E981.7010200@nrlssc.navy.mil> <478C1D7A.6090103@nrlssc.navy.mil> <alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org> <478CECAB.2030906@nrlssc.navy.mil> <alpine.LFD.1.00.0801150931260.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 19:30:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEqY4-0004WW-F3
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 19:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbYAOS32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 13:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbYAOS32
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 13:29:28 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57295 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbYAOS31 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 13:29:27 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0FIRCXf013965;
	Tue, 15 Jan 2008 12:27:14 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 12:27:12 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LFD.1.00.0801150931260.2806@woody.linux-foundation.org>
X-OriginalArrivalTime: 15 Jan 2008 18:27:12.0067 (UTC) FILETIME=[3ED83930:01C857A4]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--11.044900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : 
	150567-157042-700075-139010-707760-711953-701455-186035-148039-148051
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70539>

Linus Torvalds wrote:
> It would obviously be interesting to see the base repository and the 
> commit you are trying to do - is that possibly publicly available?

I wish it was.

-brandon

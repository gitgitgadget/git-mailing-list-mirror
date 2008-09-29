From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/3] Prepare for non-interactive merge-preserving rebase
Date: Mon, 29 Sep 2008 18:04:22 +0200
Message-ID: <48E0FC86.3040001@op5.se>
References: <48D95836.6040200@op5.se> <20080923162211.d4b15373.stephen@exigencecorp.com> <48DE7386.2080808@op5.se> <20080929160153.GK17584@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Haberman <stephen@exigencecorp.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 18:06:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkLFv-0000gH-8Y
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 18:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbYI2QEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 12:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbYI2QEZ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 12:04:25 -0400
Received: from mail.op5.se ([193.201.96.20]:43947 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbYI2QEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 12:04:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A383B24B0D2B;
	Mon, 29 Sep 2008 17:55:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vpx9fJYu0e2O; Mon, 29 Sep 2008 17:55:35 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 5078024B0D2A;
	Mon, 29 Sep 2008 17:55:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080929160153.GK17584@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97029>

Shawn O. Pearce wrote:
> Andreas Ericsson <ae@op5.se> wrote:
>> Shawn, I haven't seen this in any of your branches. Overlooked or
>> dropped? I think 1-2 are probably master material, while I'm not
>> so sure about 3/3. Would you prefer a re-send that turns it into
>> a 2-patch series, adding each test with the functionality it tests?
> 
> Thanks for the reminder.  It just got lost in the shuffle.  I dragged
> them out of the archives and will queue into this morning's update,
> so no need for a resend.
> 

Hold off on that if you haven't already applied them. I just noticed
something strange in passing 15 minutes ago that I need to investigate
a bit more. I need to get home now though, so I won't have time to
test it further until later tonight.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

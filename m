From: Andreas Ericsson <ae@op5.se>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 12:16:12 +0200
Message-ID: <47133DEC.6020600@op5.se>
References: <20071014221446.GC2776@steel.home>	<023101c80eb5$e3b6b310$2e08a8c0@CAM.ARTIMI.COM> <20071015000347.GA13033@old.davidb.org> <E1IhJ7T-0008AC-8b@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Brown <git@davidb.org>, dave.korn@artimi.com,
	raa.lkml@gmail.com, Johannes.Schindelin@gmx.de,
	git@vger.kernel.org, make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 12:16:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhMzx-0001Dm-Hc
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 12:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758252AbXJOKQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 06:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758323AbXJOKQR
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 06:16:17 -0400
Received: from mail.op5.se ([193.201.96.20]:50523 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757944AbXJOKQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 06:16:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 232B117306F0;
	Mon, 15 Oct 2007 12:16:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.155
X-Spam-Level: 
X-Spam-Status: No, score=-2.155 tagged_above=-10 required=6.6
	tests=[AWL=0.344, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rs+w7hCwBtG6; Mon, 15 Oct 2007 12:16:14 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 00C941730693;
	Mon, 15 Oct 2007 12:16:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <E1IhJ7T-0008AC-8b@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60976>

Eli Zaretskii wrote:
> 
>> If you know what the library on the other end is doing to re-parse the
>> arguments back into separate strings, it might be possible to quote things
>> enough to handle names with spaces, but it is hard.
> 
> It's not hard, it's just a bit of work.  And it needs to be done
> exactly once.

Before someone beats me to it: "Patches welcome" ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

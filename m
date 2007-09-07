From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Fri, 7 Sep 2007 11:37:00 -0700
Message-ID: <20070907183700.GC24713@hand.yhbt.net>
References: <20070906075104.GA10192@hand.yhbt.net> <1189096669534-git-send-email-hjemli@gmail.com> <20070906210155.GA20938@soma> <20070906213556.GA21234@soma> <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com> <20070906235516.GC4538@xp.machine.xx> <8c5c35580709061723m7e01c9d4p1b1936dc1d590459@mail.gmail.com> <20070907084352.GD4538@xp.machine.xx> <8c5c35580709070313l4b815ddbg70be8fb0aef4eefd@mail.gmail.com> <20070907115130.GA1547@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 07 20:37:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITiha-0004rJ-0v
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 20:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbXIGShB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 14:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbXIGShB
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 14:37:01 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33952 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283AbXIGShA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 14:37:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 2BC902DC08D;
	Fri,  7 Sep 2007 11:37:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070907115130.GA1547@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58055>

Peter Baumann <waste.manager@gmx.de> wrote:
> On Fri, Sep 07, 2007 at 12:13:23PM +0200, Lars Hjemli wrote:
> > [btw: could you please stop messing with 'Mail-Followup-To:'? When
> > replying to your mail, I don't want everyone _except_ you in the 'To:'
> > header...]
> > 
> 
> Sorry, I wasn't aware of that.
> 
> I had a 'subscribe git@vger.kernel.org' in my muttrc and just pressed 'g'
> for group reply. Reading the docs suggested to 'set followup_to=no' (as
> I did before sending this message). Per default it is set to 'yes'.

I don't have any "subscribe <address>" lines in my muttrc nor do I
have any followup_to settings in it.  It's just default, and 'g' has
always managed to work fine.

> Could anyone more experienced with mutt correct me if this was the wrong
> fix for this problem (or even point me to the right documentation)?

man 5 muttrc

However, whatever you did seems to have worked as replying to this
email didn't drop your name from this.

-- 
Eric Wong

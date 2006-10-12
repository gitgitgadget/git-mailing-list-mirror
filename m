From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Thu, 12 Oct 2006 13:10:07 -0700 (PDT)
Message-ID: <20061012201007.2464.qmail@web31803.mail.mud.yahoo.com>
References: <7viripnyfh.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 23:01:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY6sl-0006XD-2A
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 22:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWJLUKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 16:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWJLUKO
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 16:10:14 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:17337 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750951AbWJLUKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 16:10:12 -0400
Received: (qmail 2466 invoked by uid 60001); 12 Oct 2006 20:10:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ndnPGUIJjPfi2JhWBZLNJHk95u5yQTIl+6wJuw42/ZnGr7LK5YtTdw0GMrmDQBXfMyJJ4/vehvOK+zbEbX1cuh1cBPr7n8ZrtwLEma+LepV8dsiy2IBbycPjJc5XPu9WRl6aU5KKQnJl9hauNHYIR+91uRZjFVab+Aet2qnFwAk=  ;
Received: from [64.215.88.90] by web31803.mail.mud.yahoo.com via HTTP; Thu, 12 Oct 2006 13:10:07 PDT
To: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7viripnyfh.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28796>

--- Junio C Hamano <junkio@cox.net> wrote:
> Side note: I do not intend to keep it named pickaxe -- only
> while it is in "pu".

Yes, I was going to mention something about that, but hesitated
and didn't.

What name is a good name?  Reuse and old one?  "blame", "annotate"?

   Luben

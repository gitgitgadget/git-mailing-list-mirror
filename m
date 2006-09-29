From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Fri, 29 Sep 2006 09:16:19 -0700 (PDT)
Message-ID: <20060929161619.24848.qmail@web31806.mail.mud.yahoo.com>
References: <7vmz8jp5p3.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 18:17:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTL2H-0006Nm-0s
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 18:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWI2QQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 12:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWI2QQV
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 12:16:21 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:29265 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932320AbWI2QQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 12:16:20 -0400
Received: (qmail 24850 invoked by uid 60001); 29 Sep 2006 16:16:19 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LX86Dfw5PaVBFSnV+1wN0MF+m6HHQVJg/j0c7A1EK/CCiF3ZVOPKlrFc8uwuKJ9w9m8Ryt31dB4yPvNInbjdDukAQnUkkmmNZ+h3VuFghgb0gwkqbIsSEyqIdbi4Wnq/NDJpgZg/ndloDgswtiBkON2NshxGQGq1wWnfNEJvmxA=  ;
Received: from [64.215.88.90] by web31806.mail.mud.yahoo.com via HTTP; Fri, 29 Sep 2006 09:16:19 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz8jp5p3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28113>

--- Junio C Hamano <junkio@cox.net> wrote:
> > What are the objections to this patch?
> 
> No objections from me --- rather lack of objections from Jakub ;-)

We haven't heard anything from him, and on our last correspondence
in this thread it seemed we're in agreement.

> But the fragments do not appear to apply anymore.
[...]
> There is no call to create blob_plain link with hash_base
> hardcoded to "HEAD" in git-print-tree-entry.
> 
> Care to re-spin?

Doing it right now.

Thanks,
   Luben

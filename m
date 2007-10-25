From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007	unfinishedsummary
 continued
Date: Thu, 25 Oct 2007 22:19:58 +0200
Message-ID: <4720FA6E.9040805@op5.se>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>	 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de>	 <Pine.LNX.4.64.0710231155321.25221@racer.site>	 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de>	 <20071024194849.GH29830@fieldses.org>	 <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de>	 <20071024212854.GB6069@xp.machine.xx>	 <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>	 <Pine.LNX.4.64.0710242258201.25221@racer.site>	 <1193328386.4522.352.camel@cacharro.xalalinux.org>	 <20071025163835.GB31888@fieldses.org> <1193335562.4522.403.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Federico Mena Quintero <federico@novell.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 22:21:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il9Cr-0001p8-Qa
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 22:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756656AbXJYUVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 16:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbXJYUVQ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 16:21:16 -0400
Received: from mail.op5.se ([193.201.96.20]:52061 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762679AbXJYUUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 16:20:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0F37C1730723;
	Thu, 25 Oct 2007 22:19:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MaORbyZeCItq; Thu, 25 Oct 2007 22:19:23 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id C9B43173071F;
	Thu, 25 Oct 2007 22:19:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <1193335562.4522.403.camel@cacharro.xalalinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62367>

Federico Mena Quintero wrote:
> On Thu, 2007-10-25 at 12:38 -0400, J. Bruce Fields wrote:
> 
>> It's definitely not a simple cut-and-paste--even with permission from
>> the author of "Git for computer scientists", fitting this in would
>> require rethinking the ordering of topics in the manual.
> 
> Oh, that can be done.  It's easier to move text around than to
> rearchitect code :)
> 

It misses the point though. Machines should work while humans are
lounging. If the humans have to read a lot to get the machines to
work, there's less time for lounging ;-)

>> Also, there's
>> the restriction that we'd like to keep it looking good in plain ascii,
>> so diagrams have to be done in ascii somehow.
> 
> Hmm, what's the rationale for this?  I'd assume that most people read
> the user's manual as a web page (or as bedside reading if they can print
> a PDF thereof), where diagrams can be pretty.
> 

man pages.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

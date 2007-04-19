From: Marcin Kasperski <Marcin.Kasperski@softax.com.pl>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 19:49:47 +0200
Message-ID: <4627ABBB.8060709@softax.com.pl>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site> <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org> <Pine.LNX.4.64.0704191118050.8822@racer.site> <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 19:48:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Heak8-0007of-Bo
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 19:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766902AbXDSRsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 13:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766903AbXDSRsY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 13:48:24 -0400
Received: from bozon2.softax.com.pl ([83.238.10.48]:47154 "EHLO
	bozon2.softax.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766902AbXDSRsX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 13:48:23 -0400
Received: from bozon2.softax.pl (localhost.localdomain [127.0.0.1])
	by bozon2.softax.com.pl (Postfix) with ESMTP id 88DEBDC006;
	Thu, 19 Apr 2007 19:48:22 +0200 (CEST)
Received: from 127.0.0.1 (127.0.0.1)
 by bozon2.softax.pl (F-Secure/fsigk_smtp/488/bozon2.softax.pl);
 Thu, 19 Apr 2007 19:48:22 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/488/bozon2.softax.pl)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bozon2.softax.com.pl (Postfix) with ESMTP id 73B06DC007;
	Thu, 19 Apr 2007 19:48:22 +0200 (CEST)
Received: from bozon2.softax.com.pl ([127.0.0.1])
 by localhost (bozon2.softax.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14629-05; Thu, 19 Apr 2007 19:48:21 +0200 (CEST)
Received: from [192.168.1.100] (195-tar-2.acn.waw.pl [212.76.49.195])
	by bozon2.softax.com.pl (Postfix) with ESMTP id 50866DC006;
	Thu, 19 Apr 2007 19:48:21 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
X-Virus-Scanned: amavisd-new at softax.pl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45032>


>> I guess that we should not say that Git is complicated. People tend to 
>> believe that, but it is simply not true. (...)
>
> I agree. And to some degree I suspect that the documentation pushes some 
> of the advanced things a bit *too* eagerly. (...)
As I am among those, who think that git *is* complicated, I decided to 
sit down, and find out why
exactly I think so. Here are the top words/options/concepts, which I 
faced almost immediately while
trying GIT, and which I find confusing:

rebase
index
revtree
reset
ref / refs
rev-list
rev-parse

At the same time, concepts like add, rm, commit, push, pull, merge are 
natural and easily understandable.

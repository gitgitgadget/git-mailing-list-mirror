From: Andreas Ericsson <ae@op5.se>
Subject: Re: Question about "git commit -a"
Date: Fri, 05 Oct 2007 12:14:48 +0200
Message-ID: <47060E98.2090601@op5.se>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>	<545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>	<fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>	<Pine.LNX.4.64.0710042209410.4174@racer.site>	<4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>	<4705FB52.3030208@op5.se>	<4d8e3fd30710050206h7a177472x7c92f91204b15aa4@mail.gmail.com>	<47060BB3.3030208@op5.se> <vpqy7ehj2g8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Oct 05 12:15:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdkD3-00021A-Ki
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 12:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbXJEKO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 06:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbXJEKO5
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 06:14:57 -0400
Received: from mail.op5.se ([193.201.96.20]:33403 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751656AbXJEKO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 06:14:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 869CD194444;
	Fri,  5 Oct 2007 12:14:55 +0200 (CEST)
X-Spam-Score: -4.136
X-Spam-Level: 
X-Spam-Status: No, score=-4.136 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.262, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oADUpTIIy3e2; Fri,  5 Oct 2007 12:14:49 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 4CFC4194449;
	Fri,  5 Oct 2007 12:14:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <vpqy7ehj2g8.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60065>

Matthieu Moy wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> Yes, but it's so enormously powerful once you get a grip on it that I can't
>> for the life of me imagine an scm system without it. You just can't do
>> "scm commit --interactive" without it in a sane way,
> 
> darcs|hg record do a very similar job. The real difference between
> darcs and others here is not "scm commit --interactive", but the fact
> that you can split the work among multiple commands, the index
> maintains a persistant state.
> 
>> or check which merge- conflicts you've already resolved,
> 
> At least bzr and baz have this kind of conflict management. It's just
> a separate file, containing the list of unresolved conflicts.
> 

Can you check them against any revision you want? If so, I'm impressed :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

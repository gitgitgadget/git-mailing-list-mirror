From: Andreas Ericsson <ae@op5.se>
Subject: Re: remote#branch
Date: Thu, 01 Nov 2007 08:29:52 +0100
Message-ID: <47298070.4060500@op5.se>
References: <20071030053732.GA16963@hermes.priv> <fg8h9l$b4n$1@ger.gmane.org> <20071031013856.GA23274@coredump.intra.peff.net> <200710310249.17233.jnareb@gmail.com> <20071031015708.GA24403@coredump.intra.peff.net> <47282A0D.9010400@op5.se> <20071031083506.GA23316@glandium.org> <472844D4.8050306@op5.se> <20071031091529.GA25025@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 08:30:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InUVK-0002RB-5a
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 08:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbXKAHaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 03:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbXKAHaA
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 03:30:00 -0400
Received: from mail.op5.se ([193.201.96.20]:34831 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbXKAH37 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 03:29:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 133D017305BE;
	Thu,  1 Nov 2007 08:29:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 39nGpLzcrIKK; Thu,  1 Nov 2007 08:29:18 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 4DB401730573;
	Thu,  1 Nov 2007 08:29:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071031091529.GA25025@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62926>

Mike Hommey wrote:
> On Wed, Oct 31, 2007 at 10:03:16AM +0100, Andreas Ericsson <ae@op5.se> wrote:
>>> Or copied from gitweb.
>>>
>> Perhaps, but I've never seen that done. Partly because you can't be sure
>> the HTTP url is the same as the git address (perhaps people are used to
>> this from CVS and the likes), and partly because you'd, for most cases,
>> want to use git:// or ssh transport instead of http.
>>
>> It might be nifty to have gitweb print some git-valid locator for a repo
>> though, or even a full copy-pastable "git clone git://host/path/to/repo.git"
>> command-line thingie. I'll look into it when I have leisure.
> 
> Hum... it already does print http and git "Mirror URL"s which are ready to
> be copy/pasted to feed git clone arguments.
> 

True that. I went looking for such an option a long time ago and didn't find
it. I should do my research better.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

From: Petr Sebor <petr@scssoft.com>
Subject: Re: git diff - no newline after @@ ?
Date: Fri, 18 Aug 2006 15:19:28 +0200
Organization: SCS Software
Message-ID: <44E5BE60.5010901@scssoft.com>
References: <44E5AE42.6090506@scssoft.com> <81b0412b0608180525t284d3124j867a9461bf14ed91@mail.gmail.com> <44E5B496.3070901@scssoft.com> <20060818124428.GA22328@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 15:21:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE4G3-00059M-J5
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 15:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWHRNT2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 09:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWHRNT2
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 09:19:28 -0400
Received: from opteron.scssoft.com ([85.207.19.51]:37807 "EHLO
	opteron.scssoft.com") by vger.kernel.org with ESMTP
	id S1751385AbWHRNT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 09:19:27 -0400
Received: from [IPv6:2001:6f8:12f6:1:211:9ff:fec1:49c7] (donkey.scssoft.com [IPv6:2001:6f8:12f6:1:211:9ff:fec1:49c7])
	by opteron.scssoft.com (Postfix) with ESMTP id 2DB7155B6E1;
	Fri, 18 Aug 2006 15:19:24 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Jeff King <peff@peff.net>
In-Reply-To: <20060818124428.GA22328@sigio.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25662>

Jeff King wrote:
> Try diff -p to get a hunk comment.
>
> -Peff
>   

Ouch.... got it. Is there a way to turn the comment generation off btw?

Sorry for the noise...

Petr

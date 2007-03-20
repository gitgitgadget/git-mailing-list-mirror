From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Suspicious of v1.5.0 tag object
Date: Tue, 20 Mar 2007 21:38:58 +0000
Message-ID: <200703202139.01422.andyparkins@gmail.com>
References: <200703201323.15497.andyparkins@gmail.com> <7v7itb7ijv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 22:42:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTm6Q-00083V-Ir
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 22:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbXCTVmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 17:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbXCTVmJ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 17:42:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:1953 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbXCTVmF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 17:42:05 -0400
Received: by ug-out-1314.google.com with SMTP id 44so20643uga
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 14:42:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QAzFxryPbGmarUnWW5EgEob1Lfe0zrSMgkHlrF/fknpcFBQBe/7UI4XG9n5ayayzSYybulfwZKxwvmeL/LkdeKEHwi1dJaysqxmyazkcfElW5v2O3B6bUoa5AOAHRD3ppkN20wG57QeMA+zBndJc4atfmzCd68WBlft7kq1K3lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RptCKbOV3Nqj1av73IgkNSZzAfhCUOXs4PrRKzsd+d1ioL4PYS6zwZGQIf+qwF0BjFybSy4w8vJ6qOhDILU+exxYlRsjTgc0FC0VSLuANoDD/aVu4dr4IK7byEDX2BdEijkvi6Z7GFIJAFBp1FoUR1WKuDxarJvPpiRBTDoYt0A=
Received: by 10.66.219.11 with SMTP id r11mr1903290ugg.1174426923590;
        Tue, 20 Mar 2007 14:42:03 -0700 (PDT)
Received: from dhcp38.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 30sm1129803ugf.2007.03.20.14.42.02;
        Tue, 20 Mar 2007 14:42:03 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7v7itb7ijv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42762>

On Tuesday 2007, March 20, Junio C Hamano wrote:
> >   tagger Junio C Hamano <junkio@cox.net> Wed Feb 14 00:00:00 2007
> > +0000
> >
> > Is it really the case that you tagged v1.5.0 at midnight UTC
>
> Who are you referring to as "you" when your "To:" header reads
> Git Mailing List ;-)?

Ah but the "tagger" reads Junio :-)

> That one and its commit object has that timestamp because the
> release was supposed to be named "Rose scented bamboo".

Fair enough.  Just thought I'd raise it in case it was a bug.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] How to review patches: Documentation/ReviewingPatches?
Date: Sun, 15 Feb 2009 02:14:22 +0100
Message-ID: <200902150214.24146.jnareb@gmail.com>
References: <200902130045.59395.jnareb@gmail.com> <alpine.DEB.1.00.0902130055370.26370@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 02:17:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYVdm-0006Oo-Km
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 02:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbZBOBO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 20:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbZBOBO1
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 20:14:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:39589 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbZBOBO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 20:14:27 -0500
Received: by fg-out-1718.google.com with SMTP id 16so89329fgg.17
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 17:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=g6KGXDiXbJ8iAQidNZNwFinKJ6h88UTH80UnK758nWM=;
        b=vWtSd2wfNrmMez13vBN2Z/VDyl+BA5HqUnClTOqPQnPHY/73D3JZ20tmeBpB59SwoO
         /LbH0fLJ3H6udTqzb0cZg3OwRAg2DmyUvZr7R68jICN+R9Bizjp502Y7wq/4wo9Cbt8L
         JpgLEqGF2Rd+JcteZrbOVTvQR0xhBzn66XLaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Tce9bUNZJxJFKB6x5vfEQNwSnYRzx1PxDIauL5cLAIWKqmrpt8KTIabSKZo+8BS+fT
         ar1UpgjvdbT0l/mXKZkY/8VyKWS9F5N9QJ50bkAHxnZ8EutGI80q9Upyqk0te8l1evFu
         lm4Hl6nueJsYLc24B8rw72dIf7tTRk8LPNUzY=
Received: by 10.86.100.19 with SMTP id x19mr597870fgb.29.1234660465299;
        Sat, 14 Feb 2009 17:14:25 -0800 (PST)
Received: from ?192.168.1.13? (abvc8.neoplus.adsl.tpnet.pl [83.8.200.8])
        by mx.google.com with ESMTPS id l19sm5227088fgb.57.2009.02.14.17.14.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Feb 2009 17:14:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0902130055370.26370@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109952>

On Fri, 13 Feb 2009, Johannes Schindelin wrote:

> There is another reason why I do not want any ReviewingPatches: reviewing 
> is already such a tedious process; let's not make it harder by forcing a 
> potential reviewer to sift through a document (the same could be said 
> about SubmittingPatches; IMHO it just repeats what common sense would do 
> anyway when imitating existing code).
> 
> I'd rather suggest to patch submitters to make such a good case that all 
> the world is interested in their patch, throwing a lot of eyeballs (AKA 
> review) at it.

Well, I thought of ReviewingPatches less as of listing set of rules to
follow, as in the case of SubmittingPatches (because there output is
processed by tools, and preserved), but rather as set of guidelines and
hints.  Something like "rules" of programming :-).

-- 
Jakub Narebski
Poland

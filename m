From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Rebase, please help
Date: Wed, 11 Apr 2007 13:32:08 +0200
Message-ID: <81b0412b0704110432o3f861d4aha68df22f88e59da3@mail.gmail.com>
References: <200704110852.00540.litvinov2004@gmail.com>
	 <81b0412b0704110048j30193650r6a7e7417a9afeaf8@mail.gmail.com>
	 <7vr6qrnszb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:52:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbb48-0004f1-55
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 13:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbXDKLcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 07:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbXDKLcK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 07:32:10 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:48189 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbXDKLcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 07:32:09 -0400
Received: by an-out-0708.google.com with SMTP id b33so155890ana
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 04:32:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aDLG80xrsZDK69qnqjcUz6wHDBKEBHjPn1X/4j0Appy/RaDE7fSPWivChAGY2SYsj37Oh6lm2jYNMx1wrzaZyZnXyXkqrwYr6HLD1X/+6kwSUyPTE6UHIyUtUKneaatmzztjwTsKlzt/gIAJn/1DOTINsw1QjTXxNcYNGNmoD1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qCMgRbM9FNQFIiWFmCPprQnAywrDH29QxqgcU9jt9OdiOkR9SDIx7B2zOq/pxUTLwMJbSnRTGWEnFykVWFiVI08yBfdvIMN8mAgR6Tc3FeBLhuHt164OB7Qt20s9Dgscv9Z8mFfD3S6frZvSqrT9FfP/rLMDCdiHMezieznVT2I=
Received: by 10.100.191.5 with SMTP id o5mr173877anf.1176291128223;
        Wed, 11 Apr 2007 04:32:08 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Wed, 11 Apr 2007 04:32:08 -0700 (PDT)
In-Reply-To: <7vr6qrnszb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44235>

On 4/11/07, Junio C Hamano <junkio@cox.net> wrote:
> Also there is that small D/F conflict problem merge-recursive
> has that I told you about, which does not exist in git-apply ;-)
> Did you have a chance to take a look at it yet?

not yet. I was greatly distracted by subprojects

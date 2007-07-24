From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS keyword expansion
Date: Tue, 24 Jul 2007 09:08:23 -0400
Message-ID: <9e4733910707240608gd201d5bv3d7002d9a9c186f6@mail.gmail.com>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
	 <Pine.LNX.4.64.0707230048570.14781@racer.site>
	 <9e4733910707221711u6e965e6cr29e06fa8fb09165@mail.gmail.com>
	 <Pine.LNX.4.64.0707230136360.14781@racer.site>
	 <9e4733910707230744u2d3a0a31t9f65d5c9e68c9805@mail.gmail.com>
	 <Pine.LNX.4.64.0707231933030.14781@racer.site>
	 <9e4733910707231743w759afabfvd43045ad2e2eba5a@mail.gmail.com>
	 <Pine.LNX.4.64.0707240214500.14781@racer.site>
	 <f84jh8$e27$2@sea.gmane.org>
	 <Pine.LNX.4.64.0707241223440.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:08:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDK7r-0004DE-OA
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 15:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbXGXNI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 09:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbXGXNI1
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 09:08:27 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:41997 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbXGXNI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 09:08:26 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1386180nze
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 06:08:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dWBhIFZ8uGs/0DnMAp6E218McYH3cOCa81aUriM3rfQmT9Rham5/VORoNBvYYAZ+jnMgj8Sxzm92Gkybtrh1tZ9CSONve4qSr6pQLGMU8x/IZ+bykE2FXH3bVsAvH1CVr5YQuC/zHZD0h8avL5StheoKfXuBdHA7GVZ+Ybs+opQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=juCbVbmHuYalvhLkZ8ha+gk63fAv3rBgRPMprsafxoLZEJgQMFfyI4s2wzNTxCGe9D0xAT0WVk0MpGCW5XbEFqI1M02hgX+58lPX9FjxYR9MXo0K2UU8l7sjPCVOVRf6snJtYZDLr39ikh8Rdud/c6+OVMTEeCj1yKVa18nGwW4=
Received: by 10.114.204.7 with SMTP id b7mr4029323wag.1185282504035;
        Tue, 24 Jul 2007 06:08:24 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Tue, 24 Jul 2007 06:08:23 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707241223440.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53583>

On 7/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> The really tedious part is the testing, and the verifying.  Fortunately,
> Jon made up for my incapability in both areas, with an incredible
> patience.

I haven't finished checking every last line yet, if anything is left
it is small. We lost power here all evening last night. That's not
supposed to happen in urban Boston. It was black over a mile from me
in all directions.

>
> Ciao,
> Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com

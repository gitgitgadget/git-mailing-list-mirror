From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Allow fetching references from any namespace
Date: Sun, 13 May 2007 05:48:00 +0200
Message-ID: <e5bfff550705122048s6772db3as63f6fb23fe7e1bd7@mail.gmail.com>
References: <20070511203522.GA2741@steel.home>
	 <7vlkfv9j3c.fsf@assigned-by-dhcp.cox.net>
	 <20070512074049.GA2410@steel.home>
	 <7vveey4gt0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 05:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn54A-0001Kw-39
	for gcvg-git@gmane.org; Sun, 13 May 2007 05:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbXEMDsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 23:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756009AbXEMDsD
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 23:48:03 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:54224 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbXEMDsB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 23:48:01 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1449358nzf
        for <git@vger.kernel.org>; Sat, 12 May 2007 20:48:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PtG6QbEw+Nhiue2Q5++A2/OM4pUrXczLM755VbEsz1rcdst6kP22eG0iGj/jBnvQE3FcA60O5z6bwDfZRvtgfyprWCAkgujDJmFVFKaAQnZZRLFHZWbf+xMAlAowElaN0cT+3msfCF3xaaWFB8IkWgnl8acrwVtzST0SezWcuCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lvhHv6Ys8t0AXJiM4Q1nAxFOJUXL6PMXwp3gsPC1k1jG6KwrKWrjuwKFDYkOvPiSwSLTApZh6gRRdRVETLcG9/w0aBElDuSxuXkyLYTZmpxd3QMzFwjow0LunTcc2yr/ZMS5SHKTFh1nbSXS3OhdAf3mLNLo3dWF4GxVDwXqCLQ=
Received: by 10.114.180.1 with SMTP id c1mr460504waf.1179028080828;
        Sat, 12 May 2007 20:48:00 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 12 May 2007 20:48:00 -0700 (PDT)
In-Reply-To: <7vveey4gt0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47122>

On 5/12/07, Junio C Hamano <junkio@cox.net> wrote:
>
> Sounds like it is not even a regression but just was not
> supposed to work from the beginning.
>
> Not that I think lifting that restriction is a bad idea,
> though.
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Please consider that StGIT put patch names under refs/patches and
probably we don't want to see them.

I'm very sorry but I cannot test my-self because I'm leaving now. I
have just seen the patch applied in git tree and this thing come to my
mind.


 Marco

From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: git adds some text file as binary file by mistake
Date: Fri, 24 Oct 2008 21:30:19 +0800
Message-ID: <46dff0320810240630s5cbfa62esd10a9da45ce37bf8@mail.gmail.com>
References: <46dff0320810240537i4f0d86b9p56def9ef6a69c180@mail.gmail.com>
	 <4901C58D.4010309@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 15:32:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtMm7-0004Go-5h
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 15:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbYJXNaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 09:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbYJXNaW
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 09:30:22 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:27750 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYJXNaV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 09:30:21 -0400
Received: by yw-out-2324.google.com with SMTP id 9so288807ywe.1
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SGzZ+/hd634FSSvjgrz78AYXLl6sF0anNeZ00lWPpV8=;
        b=UUFLLjKbXXPQQlVdzhtCmE5rHowFXyJPMsIqv0ljzB1YQhSHkhQvaqs2V+fPEDtpc3
         cYu6e5fOH08dnfVfDtL2e6AHDGtVOC1cnN4fIPPsL15PGF3KIaSM1vOXibp+ImSRtj9w
         RcuydFvgMjB1cP9kg0chmc+kf8kremx8+jZ/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ix+YBcbxKT0mFEhImAUydNWFMDrvZzASDvMcR4B54lNyguCcrHxdvMAOa2WHZ6s+8g
         b1KIuwdCrLeGK4cDIMDPJOIJqYEPWjWvHHKhp+3/Q5VmybvQi0Gw59DEc0u9j0s1MhRp
         fCEBEWh6BUMQWF+dUhGch7TOARKE78WT8Fu+E=
Received: by 10.151.103.11 with SMTP id f11mr5872266ybm.190.1224855019831;
        Fri, 24 Oct 2008 06:30:19 -0700 (PDT)
Received: by 10.150.140.10 with HTTP; Fri, 24 Oct 2008 06:30:19 -0700 (PDT)
In-Reply-To: <4901C58D.4010309@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99033>

On Fri, Oct 24, 2008 at 8:54 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Ping Yin venit, vidit, dixit 24.10.2008 14:37:
>> So what should i do if i want it added as text file?
>
> You should give us more detail on the file ;)
> What's the extension, what's the typical content? It may be a simple
> matter of specifying attributes.
> Do ordinary diff and grep recognize your files as text?
>
> Michael
>

It's just an xml file. I guess maybe there are some hidden characters
at the beginning. I will figure it out later because i have no access
to that file right now.

I'm just ask this problem in general sense. So is there a general way
to specify whether  a file is text or binary?



-- 
Ping Yin

From: alexandrul <alexandrul.ct@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 22:18:38 +0300
Message-ID: <4ABD178E.8000508@gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>	 <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>	 <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>	 <e5bfff550909250704x724fd4c7lebe7184b4557c7a9@mail.gmail.com>	 <4ABCCFE4.6070202@viscovery.net>	 <e5bfff550909250718y51709692kc8d1e2586017341b@mail.gmail.com>	 <4ABCE167.7060204@viscovery.net>	 <e5bfff550909251125t6ed59b1fv953eee597adc4471@mail.gmail.com>	 <4ABD0E90.5030301@gmail.com>	 <e5bfff550909251144ma9e4dccmb54a64f364b820fa@mail.gmail.com> <e5bfff550909251208v68a561beu2d9f21ae2417fdd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 21:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrGJe-00083w-Py
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 21:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbZIYTSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 15:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbZIYTSl
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 15:18:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:16282 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbZIYTSl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 15:18:41 -0400
Received: by fg-out-1718.google.com with SMTP id 22so976866fge.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 12:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=FVhUTrIgWyu+3f5+LtgqUF1mC2GSkG0igI0V7XleC0k=;
        b=oMl3K2IoZ1iNTo0qQ4Ho6USkO3QJaQ1WrK8RKrS7NgI4iIr0T5LsGm8RBxphKSY/Im
         dIO2CNUsgVlV4yI6mGbecUnHnl3qI6qpusSWrWbjjAY5g2TosbvG6sS3MoBWOr7Bo2RP
         9moMpmBWV0wTz7XRmLh6BeO09lLcPQDD8z/fY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=SUAf6LxtqfAmskIvA6UN2nOMwgac6zno1mplc9A0nLdBQJB1B3KCYp9t+FuQbAZSo6
         j4bIi8yCI0qjY+VyPivMgMMINDzf4qrXhqp4jXaHXz/DBoH3euGSTI/Zd9Y4NJ39bhzT
         QIJonfdic5eXMP3SdSDhnTtkvoA/zOBwi1SYs=
Received: by 10.86.158.5 with SMTP id g5mr1290308fge.32.1253906324472;
        Fri, 25 Sep 2009 12:18:44 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id l12sm539895fgb.24.2009.09.25.12.18.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Sep 2009 12:18:43 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <e5bfff550909251208v68a561beu2d9f21ae2417fdd6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129106>

Marco Costalba wrote:
>> This is a good idea, thanks. I will copy the git folder to a working
>> PC and we will see....
>>
> 
> I have copied the whole Git folder to another PC with windows xp.
> 
> I have moved the Git directory and all its subfolders under program
> files instead of the old that I have renamed.
> 
> And everything worked as expected ! no problem and from git bash I
> verified that the new copied version was running.
> 
> I really don't know what to think....
> 

then check your PATH and the configuration files from your HOME folder 
(as recommended earlier).

Have a nice day,
   A.

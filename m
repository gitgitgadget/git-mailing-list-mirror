From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Git Community Book
Date: Fri, 5 Sep 2008 13:45:51 -0700
Message-ID: <d411cc4a0809051345p1c1b127epa7a186f49414a1fc@mail.gmail.com>
References: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
	 <18071eea0809051215n6a8e1468gfd28876d7d5b0488@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 22:47:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbiCw-0000uO-5z
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 22:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbYIEUpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 16:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbYIEUpx
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 16:45:53 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:31361 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbYIEUpw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 16:45:52 -0400
Received: by wa-out-1112.google.com with SMTP id j37so387316waf.23
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 13:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aO0SHBaK4aC4XIouRDtCZVD5Vx1TRPJmkqCF/8HC7DY=;
        b=lzxKK5AvU8tkjKScqWpA1JYs0PGkIdv1HYyo3S3kPEPx73vb9cTuXLrILZskhaObR9
         Znk48NJ1Kbkef2UH0NxXynpu3GSnLCD8O0o2hMpL5zzleiugeHMKZ/NdMB3Im5W9oDuE
         XbzXigjMEncJF3qo25EGe/xdgPlEEKxNHysDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WTIi+WX5c7/WjfPqFjDRLpMmHvxpireGuTX8pHEzh37rnraRS1ZoQ3RLLKw1ygh5ha
         NWLqX+p8lK8abAwq6QoAi20Dx6PZLcyp1/HIYVMgpmhVlA+QQE10efeVc59qttpp4wLv
         nDwCUBQ0Zo8h7Yfiok5ax9haVTHDx5hy1w8R8=
Received: by 10.115.50.5 with SMTP id c5mr10547135wak.60.1220647551067;
        Fri, 05 Sep 2008 13:45:51 -0700 (PDT)
Received: by 10.114.135.18 with HTTP; Fri, 5 Sep 2008 13:45:51 -0700 (PDT)
In-Reply-To: <18071eea0809051215n6a8e1468gfd28876d7d5b0488@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95040>

On Fri, Sep 5, 2008 at 12:15 PM, Thomas Adam <thomas.adam22@gmail.com> wrote:
> 2008/9/5 Scott Chacon <schacon@gmail.com>:
>> Hey all,
>>
>> I just wanted to let those of you who are interested know that I've
>> been making a lot of progress on the Git Community Book
>> (http://book.git-scm.com)  I was wondering if anyone was interested in
>
> I'm going to bite and ask the obvious questions:

Just for reference, a lot of this was discussed here a while back:

http://thread.gmane.org/gmane.comp.version-control.git/90653

however, I would be happy to answer these for you.

>
> 1.  How does what you're producing differ from the current Git Users' Manual?

I'm going for a different audience with this project.  I'd like for it
to be a lot more user-friendly, easily digestible, and to include
images, diagrams and screencasts.

> 2.  Is this project of yours aiming to obsolete the Git Users' Manual
> with "official" sanctioning from people involved with Git?

I think there will be people who prefer the Users Manual format, who
think screencasts are wussy :)
Also, I'm not sure an "official" sanctioning would do much of anything
- because of the images and screencasts, this will never be included
in the git source like the UM is, but it's also open source so if
people want to take content from it to improve the UM, that's cool.

> 3.  Assuming 2 is a "no", patches to the Users' Guide would be nice.  :)

I would love to do this, but I don't know what exactly the community
thinks is missing/lacking.  My ideas about what is helpful is rarely
the same as the git lists :)  However, if someone pointed to one of
the chapters I wrote and said "that would be great in the UM", I would
happily convert it.

Scott

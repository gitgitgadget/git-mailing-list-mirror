From: Phil Lawrence <prlawrence@gmail.com>
Subject: Re: Alles wurde Git
Date: Wed, 07 Oct 2009 16:26:03 -0500
Message-ID: <4ACD076B.3000902@gmail.com>
References: <alpine.DEB.1.00.0910041310520.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Oct 07 23:26:27 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f204.google.com ([209.85.217.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mve1h-0004iE-Ac
	for gcvm-msysgit@m.gmane.org; Wed, 07 Oct 2009 23:26:25 +0200
Received: by gxk28 with SMTP id 28so1680gxk.6
        for <gcvm-msysgit@m.gmane.org>; Wed, 07 Oct 2009 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=kDdG+/gmfTDumhLXJ6gBRIaDwOg0e5jtj1TqgmsVjxE=;
        b=BIVtUwgaZQVfX10++IxIJppjy0qCpLCd6s3o/2qa5MuQ14toVC4/KF4LTThBjyeNSf
         ICPDJzXo67uMXNGt5cFaduEvAaqbNksRfjg8Gbdp4kj8OIiSv1hp5ryhPsCNWrLtcPSh
         aKKTJWuDjKdwFRsrowrtaxuLxydAE6PCnzA/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=ZmRNn6/7SO+D/a/rv9wc3L/aCh/PmNcH4sC4mKJhWs6iY/rqE0tE8hQOHUPqFV4dpD
         lmqCfj0XWXs2yuN+sO0bCG6GJN/AiTXopwqzNYqtebn02immXDonEFJJSGAzyiWBTett
         ZlQtmrB0jvoX7myUV2rLDZ+wOifnnZqgY2Vn8=
Received: by 10.150.87.2 with SMTP id k2mr47084ybb.26.1254950777230;
        Wed, 07 Oct 2009 14:26:17 -0700 (PDT)
Received: by 10.177.108.35 with SMTP id k35gr7339yqm.0;
	Wed, 07 Oct 2009 14:26:10 -0700 (PDT)
X-Sender: prlawrence@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.223.98.206 with SMTP id r14mr8251fan.19.1254950768170; Wed, 07 Oct 2009 14:26:08 -0700 (PDT)
Received: by 10.223.98.206 with SMTP id r14mr8250fan.19.1254950768151; Wed, 07 Oct 2009 14:26:08 -0700 (PDT)
Received: from mail-fx0-f224.google.com (mail-fx0-f224.google.com [209.85.220.224]) by gmr-mx.google.com with ESMTP id 14si1076311fxm.3.2009.10.07.14.26.07; Wed, 07 Oct 2009 14:26:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of prlawrence@gmail.com designates 209.85.220.224 as permitted sender) client-ip=209.85.220.224;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of prlawrence@gmail.com designates 209.85.220.224 as permitted sender) smtp.mail=prlawrence@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by fxm24 with SMTP id 24so4452827fxm.11 for <msysgit@googlegroups.com>; Wed, 07 Oct 2009 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from :user-agent:mime-version:to:cc:subject:references:in-reply-to :content-type:content-transfer-encoding; bh=jT4i2WSrddwzEXh3VnKm1iJymIP60Seudd4IyXDTnJM=; b=q2liNgNN+TefGbI5iAo26JXz00TSNpWExiJgHvqQHI74jw6BUZafQqVEIGQ2T4Zb9z 2u11OwoldpnUCJy/ufkn3AnnZH8yQJ2javx0yvsy98RG8mieEO/GLSyFooNJKqCtXaVu pNAIvrLmU0Bw/uXHWDT9iGjVrlhgL3dpLiUGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:user-agent:mime-version:to:cc:subject :references:in-reply-to:content-type:content-transfer-encoding; b=iai/V3o33F4bJnmOYOCkjD1LtI87iWolU/VS2hjQCWUvXt/At5LfkpUI8Vm+OvT0qA M67ilFrZroRWeq9IC22xSARzjBS+A8V4uCohCUAYcO9/fQ4U579VO0bc/xLpvXDDM8Gm j17unaO44N56UoI5+yEoLWa5LKh662axNMHBw=
Received: by 10.103.81.2 with SMTP id i2mr168265mul.81.1254950767047; Wed, 07 Oct 2009 14:26:07 -0700 (PDT)
Received: from ?IPv6:::1? (ppp-70-252-138-103.dsl.ksc2mo.swbell.net [70.252.138.103]) by mx.google.com with ESMTPS id w5sm300919mue.7.2009.10.07.14.26.05 (version=TLSv1/SSLv3 cipher=RC4-MD5); Wed, 07 Oct 2009 14:26:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
In-Reply-To: <alpine.DEB.1.00.0910041310520.4985@pacific.mpi-cbg.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129660>


On 10/04/2009 07:09 AM, Johannes Schindelin wrote:
>
> ...Steffen also described some of the issues with
> working on a large number of topic branches that need to be
> integrated/cleaned up/rebased:  Git lacks good tools for working
> collaboratively with topic branches that need to be rebased frequently.
> He also showed a rather complicated script that is necessary to coordinate
> work between 3 different maintainers (at 3 different locations).
> ...

Steffen, any chance you would share that script with the list?  It 
sounds very interesting.

Phil Lawrence

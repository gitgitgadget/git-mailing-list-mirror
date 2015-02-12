From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [ANNOUNCE] Git Merge, April 8-9, Paris
Date: Thu, 12 Feb 2015 21:23:23 +0100
Message-ID: <54DD0BBB.60806@gmail.com>
References: <20150123233755.GA10264@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
To: Jeff King <peff@peff.net>, git@vger.kernel.org, 
 msysGit <msysgit@googlegroups.com>,
 git-win-sdk@googlegroups.com, git-for-windows@googlegroups.com
X-From: msysgit+bncBDZMLEGXWQLBB44X6STAKGQEQP4UMXA@googlegroups.com Thu Feb 12 21:24:21 2015
Return-path: <msysgit+bncBDZMLEGXWQLBB44X6STAKGQEQP4UMXA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBB44X6STAKGQEQP4UMXA@googlegroups.com>)
	id 1YM0JA-000710-Fw
	for gcvm-msysgit@m.gmane.org; Thu, 12 Feb 2015 21:24:20 +0100
Received: by mail-we0-f192.google.com with SMTP id w62sf3020003wes.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Feb 2015 12:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=LiJHsoEKMlGEsqXNaz94rwU7Y1g/gl/LtC+62GqA79E=;
        b=cV3jQH49TBXp0H2/RhkWtseoI06i6guoZXJdi5y6du+aRxlXwQ3si5TJU4Sgh3OhgI
         oREJvwm6fqz+8LeyjyztB2Iln+Hjlri548EjyLosFvfSjMlsWiEZg1ZYXXWNS3PwfWMx
         f2Tia7jgxO/tlNdoJ6WqbLuxGgpq538KdxLv4kvv3IBesfzsNuVts6fh/BcKJGCcodaQ
         +bj/yxagirkSCR03CV1XUU24W+fqwXBcxlc2T35tuqJDexDaGN//VIbta1Exu9n09TZ+
         cZW+BbKOarbQ3vhGVLH3bHx4GbCC5nf6V0xZIbjY03G5GeQGFrlSxyTsKEyCaSb1f+2v
         irEw==
X-Received: by 10.180.10.38 with SMTP id f6mr53405wib.11.1423772660064;
        Thu, 12 Feb 2015 12:24:20 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.80.168 with SMTP id s8ls220191wix.2.canary; Thu, 12 Feb
 2015 12:24:19 -0800 (PST)
X-Received: by 10.180.89.194 with SMTP id bq2mr786616wib.4.1423772659024;
        Thu, 12 Feb 2015 12:24:19 -0800 (PST)
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com. [2a00:1450:400c:c05::232])
        by gmr-mx.google.com with ESMTPS id o9si2611080wiw.0.2015.02.12.12.24.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 12:24:19 -0800 (PST)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:400c:c05::232 as permitted sender) client-ip=2a00:1450:400c:c05::232;
Received: by mail-wi0-f178.google.com with SMTP id em10so7321893wid.5;
        Thu, 12 Feb 2015 12:24:19 -0800 (PST)
X-Received: by 10.180.187.200 with SMTP id fu8mr9894134wic.28.1423772650378;
        Thu, 12 Feb 2015 12:24:10 -0800 (PST)
Received: from [192.168.188.20] (p5B156861.dip0.t-ipconnect.de. [91.21.104.97])
        by mx.google.com with ESMTPSA id ch6sm7116511wjc.3.2015.02.12.12.24.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 12:24:09 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20150123233755.GA10264@peff.net>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:400c:c05::232
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263764>

On 24.01.2015 00:37, Jeff King wrote:

> GitHub is organizing a Git-related conference to be held April 8-9,
> 2015, in Paris.  Details here:
>
>    http://git-merge.com/
>
> The exact schedule is still being worked out, but there is going to be
> some dedicated time/space for Git (and libgit2 and JGit) developers to
> meet and talk to each other.
>
> If you have patches in Git, I'd encourage you to consider attending. If
> travel finances are a problem, please talk to me. GitHub may be able to
> defray the cost of travel.
>
> I hope to see people there!

Forwarding this to the Windows-specific Git lists for people who are 
only subscribed over there ...

-- 
Sebastian Schuberth

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

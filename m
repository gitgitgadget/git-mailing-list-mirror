From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Git for Windows 1.9.4.msysgit.1
Date: Fri, 15 Aug 2014 21:24:38 +0200
Message-ID: <53EE5E76.4060701@gmail.com>
References: <53EE3FEE.5090905@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBB4F4XGPQKGQEQCAMUUY@googlegroups.com Fri Aug 15 21:24:33 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB4F4XGPQKGQEQCAMUUY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB4F4XGPQKGQEQCAMUUY@googlegroups.com>)
	id 1XIN73-0007hz-Gt
	for gcvm-msysgit@m.gmane.org; Fri, 15 Aug 2014 21:24:33 +0200
Received: by mail-wg0-f63.google.com with SMTP id b13sf285107wgh.18
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Aug 2014 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=d3sRgCRqZcX18602iGD6shsdM29ZNO/v0stJtgrMdAs=;
        b=qiebf8tZM/xBsRhzHVehUeP5IDwH+ce9bFIQXxH4lpiQ7o998oi9lV9ftTDem9hm3e
         CCMe1eY6tH4yAcfuGzMkS77NSlPEr+0DSEQlK8bHpwepX6z6zba76EKsbcFjNXnvwDx7
         pDtVbv5amxj9865yMABimdcUpoEM+SoCPk2ED6zfcTuZQuq4tEqmtP8dnYerQqI9Trxr
         +wT4P9/7hZSze/UsG9HjIIYDQUGK4GzU3ZkWyTVkwjw7hIiNRMczQ57Po9iOOANviXMj
         h7ys02Vr43hLgOVTGskcncyI1rjEDSCyOs53Q0+7ZawiAcXZktjMpPEh53TOtBc0w/gp
         Jn9w==
X-Received: by 10.180.105.7 with SMTP id gi7mr229723wib.5.1408130673206;
        Fri, 15 Aug 2014 12:24:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.96.230 with SMTP id dv6ls139422wib.23.gmail; Fri, 15 Aug
 2014 12:24:32 -0700 (PDT)
X-Received: by 10.180.90.18 with SMTP id bs18mr1817419wib.6.1408130672215;
        Fri, 15 Aug 2014 12:24:32 -0700 (PDT)
Received: from mail-lb0-x22d.google.com (mail-lb0-x22d.google.com [2a00:1450:4010:c04::22d])
        by gmr-mx.google.com with ESMTPS id nw2si751302lbb.0.2014.08.15.12.24.32
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Aug 2014 12:24:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4010:c04::22d as permitted sender) client-ip=2a00:1450:4010:c04::22d;
Received: by mail-lb0-f173.google.com with SMTP id u10so2281181lbd.4
        for <msysgit@googlegroups.com>; Fri, 15 Aug 2014 12:24:32 -0700 (PDT)
X-Received: by 10.112.125.105 with SMTP id mp9mr12981488lbb.30.1408130672126;
        Fri, 15 Aug 2014 12:24:32 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id g8sm5481510lam.23.2014.08.15.12.24.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Aug 2014 12:24:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53EE3FEE.5090905@virtuell-zuhause.de>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4010:c04::22d
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255301>

Am 15.08.2014 19:14, schrieb Thomas Braun:
> Hi,
> 
> the Git for Windows team just released the second maintenance release of
> the Windows-specific installers for git 1.9.4.
> 

Thank you so much!

> Regressions
> 
>     git svn is/might be broken. Fixes welcome.


rebase -b 0x64000000 bin/libsvn_repos-1-0.dll
rebase -b 0x64200000 bin/libneon-25.dll


See https://github.com/msysgit/msysgit/pull/245

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

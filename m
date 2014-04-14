From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: GitMinutes about Git for Windows
Date: Mon, 14 Apr 2014 20:15:21 +0200
Message-ID: <CABPQNSYRXrdqp3EDqWBwT=yf95XMjjmm83OZefSLWcBuc_K0UA@mail.gmail.com>
References: <alpine.DEB.1.00.1404141713020.14982@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysGit <msysgit@googlegroups.com>, GIT Mailing-list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDR53PPJ7YHRBYWLWCNAKGQERSXPHDY@googlegroups.com Mon Apr 14 20:16:04 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBYWLWCNAKGQERSXPHDY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f61.google.com ([209.85.220.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBYWLWCNAKGQERSXPHDY@googlegroups.com>)
	id 1WZlQJ-0003AX-N6
	for gcvm-msysgit@m.gmane.org; Mon, 14 Apr 2014 20:16:03 +0200
Received: by mail-pa0-f61.google.com with SMTP id fb1sf1919468pad.6
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Apr 2014 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=RMCjPIWgLRfQQMSX4JabMv4oNbKjJwERpssSKSLzCAg=;
        b=qqN/LDXZB01f9ugei2hVSS1qNbK2cZvuAjQKc+1lD4U2ZpxZedXIZc7J8aAmJLUVlL
         d5SJ2+s+uws1Ap//m8dTcufO3XhQJziA/BBSWw0qxJJGDTpftxidhlh3edkYQ/Ac1diB
         qUqy4r+86kkTNAeyf2Y6d8j2i5BFCAuXCVHx5k+WV+VmLNIFHgjw+ucSeQsNjxx37vei
         ItDL3bwOCKAeOpOTnhla4IlqLUSdBPJz8XPMIkKIz7Y8WtGWTF0Qqf72ykTL/XWk0/oW
         L+/d99ku+TCQW/TC5nCQzU+de7cuSSXlZZ6ihVstqVdWo/Yqq9nC4euOo98vp+3in6tE
         iNgg==
X-Received: by 10.140.94.169 with SMTP id g38mr82937qge.13.1397499362639;
        Mon, 14 Apr 2014 11:16:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.47.45 with SMTP id l42ls2806100qga.50.gmail; Mon, 14 Apr
 2014 11:16:02 -0700 (PDT)
X-Received: by 10.52.143.35 with SMTP id sb3mr11908148vdb.7.1397499362205;
        Mon, 14 Apr 2014 11:16:02 -0700 (PDT)
Received: from mail-ig0-x235.google.com (mail-ig0-x235.google.com [2607:f8b0:4001:c05::235])
        by gmr-mx.google.com with ESMTPS id jf10si3341588igb.0.2014.04.14.11.16.02
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Apr 2014 11:16:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::235 as permitted sender) client-ip=2607:f8b0:4001:c05::235;
Received: by mail-ig0-f181.google.com with SMTP id h18so3720297igc.14
        for <msysgit@googlegroups.com>; Mon, 14 Apr 2014 11:16:02 -0700 (PDT)
X-Received: by 10.42.20.193 with SMTP id h1mr3594472icb.70.1397499362068; Mon,
 14 Apr 2014 11:16:02 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 14 Apr 2014 11:15:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1404141713020.14982@s15462909.onlinehome-server.info>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::235
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246251>

On Mon, Apr 14, 2014 at 5:14 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Dear friends of Git for Windows,
>
> it was very delightful to be on the show, hosted by Thomas Ferris
> Nicolaisen:
>
> http://episodes.gitminutes.com/2014/04/gitminutes-28-johannes-schindelin-on.html

Really enjoyable, thanks!

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

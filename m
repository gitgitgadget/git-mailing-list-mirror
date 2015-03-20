From: Mike Hommey <mh@glandium.org>
Subject: Re: Git for Windows 1.9.5.msysgit.1
Date: Fri, 20 Mar 2015 10:15:31 +0900
Message-ID: <20150320011531.GA20149@glandium.org>
References: <550B55CF.4090701@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysGit <msysgit@googlegroups.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: msysgit+bncBDY3L7WOT4DBBQHJVWUAKGQEW4PFNQI@googlegroups.com Fri Mar 20 02:15:47 2015
Return-path: <msysgit+bncBDY3L7WOT4DBBQHJVWUAKGQEW4PFNQI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f184.google.com ([209.85.213.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDY3L7WOT4DBBQHJVWUAKGQEW4PFNQI@googlegroups.com>)
	id 1YYlXO-0001X3-Pa
	for gcvm-msysgit@m.gmane.org; Fri, 20 Mar 2015 02:15:46 +0100
Received: by igbhn15 with SMTP id hn15sf1993010igb.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 19 Mar 2015 18:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=EPl0RDht66yhs/HnvysiuoaDdBkPpZ2x0pa6CqKhr9I=;
        b=bK05zVphGQBOTLcJu3lJDhn4jIndSdN0VQGvO8olqWvilT2XzZV8iCzUfKahBpdqDk
         LoUokhSMHS2NjSQMAx4YrRUg4wwLvcXxHu8rBNmqhNwRhLEAc9ryXgTtpKOncxrZZQqn
         HWbRVNwAaTNtZtxrLVpLngimrbnaJ99XeLmTV3f04dpDYqxNlYKTkEplMIabio8kfMut
         R1Y0GbvFo2VIt3+nihmurfA5SC45sM7w7UDDPTFE7WDq54yWmHYSb5xkjLWr68UOhqq5
         DaEI3DqUimSLWOGFHgpEAVutksStdWLNbzgoLfC+GS3DwnPaV0RCNsAAM8z1iN3k2mux
         Vg6A==
X-Received: by 10.50.129.98 with SMTP id nv2mr17010igb.1.1426814145987;
        Thu, 19 Mar 2015 18:15:45 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.8.94 with SMTP id 91ls939250ioi.103.gmail; Thu, 19 Mar
 2015 18:15:44 -0700 (PDT)
X-Received: by 10.67.29.201 with SMTP id jy9mr79002419pad.9.1426814144519;
        Thu, 19 Mar 2015 18:15:44 -0700 (PDT)
Received: from glandium.org (ks3293202.kimsufi.com. [5.135.186.141])
        by gmr-mx.google.com with ESMTPS id pc4si567851pac.0.2015.03.19.18.15.43
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2015 18:15:44 -0700 (PDT)
Received-SPF: none (google.com: glandium@glandium.org does not designate permitted sender hosts) client-ip=5.135.186.141;
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YYlX9-0005Hm-IC; Fri, 20 Mar 2015 10:15:31 +0900
Content-Disposition: inline
In-Reply-To: <550B55CF.4090701@virtuell-zuhause.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Original-Sender: mh@glandium.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: glandium@glandium.org does not designate permitted sender hosts) smtp.mail=glandium@glandium.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265854>

On Fri, Mar 20, 2015 at 12:03:43AM +0100, Thomas Braun wrote:
> Hi,
> 
> the Git for Windows team just released the first maintenance release of
> the Windows-specific installers for git 1.9.5.

is it expected that there is no corresponding release on
https://github.com/git-for-windows/git/releases ?

Mike

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

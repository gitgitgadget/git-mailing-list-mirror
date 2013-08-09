From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Git for the Windows 1.8.3, GIT Bash icon issue
Date: Fri, 9 Aug 2013 19:31:16 +0100
Organization: OPDS
Message-ID: <FA03039F4A644EEE8CEEA25BCFDA1994@PhilipOakley>
References: <40631376067651@webcorp2d.yandex-team.ru>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1; reply-type=original
Cc: <git@vger.kernel.org>
To: "Dmitry Kuzminov" <dkuzminov@yandex-team.ru>,
	"Git MsysGit" <msysgit@googlegroups.com>
X-From: msysgit+bncBDSOTWHYX4PBB4XKSSIAKGQEWB4UM5Y@googlegroups.com Fri Aug 09 20:31:15 2013
Return-path: <msysgit+bncBDSOTWHYX4PBB4XKSSIAKGQEWB4UM5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f60.google.com ([74.125.82.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB4XKSSIAKGQEWB4UM5Y@googlegroups.com>)
	id 1V7rT1-0000U7-Iz
	for gcvm-msysgit@m.gmane.org; Fri, 09 Aug 2013 20:31:15 +0200
Received: by mail-wg0-f60.google.com with SMTP id z12sf606111wgg.25
        for <gcvm-msysgit@m.gmane.org>; Fri, 09 Aug 2013 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=fMs1tekWtm6MzPHyeYTBeS7hnV14UbzxAMbEvYGjX/w=;
        b=PceHg7JwAk/L4ZpAm9HUWFlRvJ/V55XnMyrm8VcjdxiTb1UL9Hik+r7WZdEPDykBGc
         ZspPrlnjHl/nzrLXKRIocbFz5pRvt2UMjLihQy7gs5CBeH+gGJL1cshPpQGkT5EMfcjr
         t2WpgKAjX11ZrUuJsD+9vb049mfsexF/eE1ZtBuNdOPKf1OZhbOumcuK6vUfiQLNklgf
         vOpmcIF0mRQeo3XTIUUE1v9leIP4wOGtIEfKF+lMYfV/kbtfQ60FvxV4xb7OAs7RT9Mw
         sce0eTISguMLknkkcWkdECyemMXa7oXQzBKAjMKT6MFUYGPTJ1z/tHjUNPtHziAAGpMP
         2wVw==
X-Received: by 10.180.149.170 with SMTP id ub10mr274585wib.0.1376073075284;
        Fri, 09 Aug 2013 11:31:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.83.66 with SMTP id o2ls347259wiy.14.gmail; Fri, 09 Aug
 2013 11:31:14 -0700 (PDT)
X-Received: by 10.180.80.227 with SMTP id u3mr1812156wix.5.1376073074460;
        Fri, 09 Aug 2013 11:31:14 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id ev4si94524wib.0.2013.08.09.11.31.14
        for <msysgit@googlegroups.com>;
        Fri, 09 Aug 2013 11:31:14 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtgLALo0BVJOl3GZ/2dsb2JhbABbgwaJVrV5BAQBgRoXdIIfBQEBBAEIAQEuHgEBIQUGAgMFAgEDDgcMJRQBBBoGBwkBDQYBEggCAQIDAYd5CrkXkDKDIXUDiHOGDpowgxw7
X-IPAS-Result: AtgLALo0BVJOl3GZ/2dsb2JhbABbgwaJVrV5BAQBgRoXdIIfBQEBBAEIAQEuHgEBIQUGAgMFAgEDDgcMJRQBBBoGBwkBDQYBEggCAQIDAYd5CrkXkDKDIXUDiHOGDpowgxw7
X-IronPort-AV: E=Sophos;i="4.89,847,1367967600"; 
   d="scan'208";a="438462546"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip01ir2.opaltelecom.net with SMTP; 09 Aug 2013 19:31:14 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.237 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232008>

From: "Dmitry Kuzminov" <dkuzminov@yandex-team.ru>

Dmitry,
The Git for Windows development list is at msysgit@googlegroups.com.

Is this "git for Windows" or one of the other git versions on windows, 
and their installers?


> There is a standard command prompt icon in taskbar for GIT Bash 
> instead of GIT icon
>
> Steps to reproduce:
> Select Taskbar Properties, Taskbar buttons, set to "Never combine"
> Run GIT Bash
>
> Best regards,
> Dmitry Kuzminov
> --

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
For more options, visit https://groups.google.com/groups/opt_out.

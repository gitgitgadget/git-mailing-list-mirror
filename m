From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: 4th release candidate of Git for Windows 2.x, was Re:
 3rd release candidate of Git for Windows 2.x
Date: Mon, 29 Jun 2015 18:19:09 +0200
Organization: gmx
Message-ID: <2abf219bf0235717eaa84889f94eb03c@www.dscho.org>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
 <b085dab2e617742b690ccb99ba4a3076@www.dscho.org>
 <8224736a18724f751312d57e67967d69@www.dscho.org>
 <55910AE7.3000206@atlas-elektronik.com>
 <426859781bd04ca4ebb13719350537ed@www.dscho.org>
 <20150629185430.5dfbab069b5dbdf32398d290@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Stefan_N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>, Git
 Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com,
 git-for-windows@googlegroups.com
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: msysgit+bncBCZPH74Q5YNRBF7AYWWAKGQESK37GDI@googlegroups.com Mon Jun 29 18:19:36 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBF7AYWWAKGQESK37GDI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBF7AYWWAKGQESK37GDI@googlegroups.com>)
	id 1Z9bmS-0002dK-1x
	for gcvm-msysgit@m.gmane.org; Mon, 29 Jun 2015 18:19:36 +0200
Received: by lams18 with SMTP id s18sf20239338lam.1
        for <gcvm-msysgit@m.gmane.org>; Mon, 29 Jun 2015 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=zIcTgFmQyK9jxHaIlq4VKj9i2o/U29/AuVh6rSYEJW8=;
        b=RyvdTMWU/BDRq0au2Lffmo/vCtSXRJvuBz4vvqmpG0WYiTV0vZYcwWANrJIvqxxzwC
         jn/EXsHZ7U+d1LA2kUOMEt3L+2NL3LSbFRFGmnvoz/JPtdMgSwmPSlgMEjA3yyA/v805
         55cFacexPo+BhTpwevX/PxRK9wekCkCC3XGthvknUS8WEHWPNWWCAVFLqZESzFvC+4rz
         FfRXgvtDkU6o5FPfKQqdZ+z9iZCeb4P97TKsG5pYQvFitZWG13NRDpkqKLQHdBef5NUa
         vS80VzRmFdvRn7qH27z/c35Vzcnzafo2hS71leh2uDOBFyTlEpkv6FhdIpXbOfeAAPI3
         3zdg==
X-Received: by 10.180.11.139 with SMTP id q11mr66916wib.13.1435594775585;
        Mon, 29 Jun 2015 09:19:35 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.29.67 with SMTP id ju3ls610114wid.46.gmail; Mon, 29 Jun
 2015 09:19:34 -0700 (PDT)
X-Received: by 10.180.37.198 with SMTP id a6mr9059274wik.7.1435594774773;
        Mon, 29 Jun 2015 09:19:34 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id su3si1480246lbb.1.2015.06.29.09.19.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 09:19:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LqQnR-1YVtAV0TL7-00e5m5; Mon, 29 Jun 2015 18:19:10
 +0200
In-Reply-To: <20150629185430.5dfbab069b5dbdf32398d290@domain007.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:ajFIJmIlQt0jxUklO7kgHWZYjAvSO5l/F15j4Z4ohacQ37NXloD
 iYDYtucXsanw5wgnZQ8jKDRN2StctFPudK0gy3gUJcYev5KhVhjVFojJ4pW1rjYI86zDXfd
 pKVLel5PnWjiRruvpPI9MGmWeHQuRa/UbyRGULSM4IgG/P5IQc++L8A8anPIurTYKPlzPdg
 UCfIzy8vtXYsPIRND3lcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uArHOSQsxq8=:G4eEixfrDxZ03I1wMeINMG
 QX8fm0+ZzeCGCOsZPKpDwTqDxESvQWUkeJWWQxkV2GD5L17CLNyLrHt9efZk6lIo+q9OURddu
 4eorC53i1usGbhJYC2N2DvGEALHauHE3IxGdyrYfFPLCSMDphRXiWAi2UVrzfh3KXvx3SI+pp
 JLAB69+zJDBY2dFG3Xe/OKmxL7FIjGgoENVpI6k1/liS4n8zf+2HJxpVWv4bPOEgQJBQXsodz
 GXdmkdh491rzpxCUFwu7eD5koWFPRUckDtyzPvLBXO01GSH8/jftmd7pI1ZwCpes6JdI7PLCP
 U25nOxwnZnWaMEammAkGIwIReUYmrAmhSMntBOJsbh6DS/iVCvn3FPJQQLrqryMBk+p/YHfC6
 4wDLhSGBemMHmKRIXzpSaC4u1nxPzZRNAqqHmI6DjLhtwRNxeo4yrwVuB7vJNYayUfoLIDb3O
 yoXceVWYL3LMYS5u17MrPOCBH93tTGOenRXhXAyVKehzD+PN00Jx5NSoffPpb5IMdNl00Zxx2
 eg6l9ZwESHChbfsiTqOhWgEWEGGpyQMYa6OrqVwY/2uUkK16z+907IMS7icIVBRxpeSOcBpjz
 9YHwYIjanblu03pYcwuw+nSyShXBZsEnb/tzhggs3fxtqKqEeuPHJu1HfmJ4Y/I6ZmQibTtqT
 yYv02P+JR7EmUZrPdRh98EhkLwTYybY1+JfcyyxKRKdl9MdT112UeGB1cRSfdOC0KBII=
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272969>

Hi Konstantin,

On 2015-06-29 17:54, Konstantin Khomoutov wrote:

> I've finally took time to switch from my old "msys1" release to this
> RC4, and immediately got hit by the fact Git is now speaking to me in
> Russian, which is not what I want (previously this behaviour was only
> exhibited by `git gui` and `gitk`).
> 
> Should I make Git see LC_MESSAGES=en (or other thing like LANG) in the
> environment or is there some Git-local method to affect this behaviour?
> I tried to grep the release notes using relevant keywords but was left
> empty-handed.

Personally, I would use LC_ALL=C. Maybe that's good for you, too?

I guess this would also make for a fine opportunity to add an option to the installer to switch the localization off?

Ciao,
Johannes

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

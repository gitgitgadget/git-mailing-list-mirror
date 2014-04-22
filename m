From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Tue, 22 Apr 2014 15:14:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404221512130.14982@s15462909.onlinehome-server.info>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com> <20140419184210.GB3617@book-mint> <alpine.DEB.1.00.1404210003540.14982@s15462909.onlinehome-server.info> <53556579.3050709@gmail.com> <alpine.DEB.1.00.1404212053420.14982@s15462909.onlinehome-server.info>
 <535569e92cbcc_32c48493101f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Sebastian Schuberth <sschuberth@gmail.com>, 
    Heiko Voigt <hvoigt@hvoigt.net>, Marat Radchenko <marat@slonopotamus.org>, 
    git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBMOW3GNAKGQEHKGCF7Y@googlegroups.com Tue Apr 22 15:14:31 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBMOW3GNAKGQEHKGCF7Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f63.google.com ([209.85.161.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBMOW3GNAKGQEHKGCF7Y@googlegroups.com>)
	id 1WcaWo-0004DW-BD
	for gcvm-msysgit@m.gmane.org; Tue, 22 Apr 2014 15:14:26 +0200
Received: by mail-fa0-f63.google.com with SMTP id p1sf423108fad.18
        for <gcvm-msysgit@m.gmane.org>; Tue, 22 Apr 2014 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=hLn+Lg+sfDUdbOY5n9Mltq45qg31dARXWmcy9XAxQFs=;
        b=kjwbmlGbUqZupiQMAFsJIkUQbEwPfSS39e33dQBgDNwcx9IEe0T/60+ypFKSUuhMLP
         P1JACPrFCuXaYLxW0GmvyO1loK4F07cyTjIzoXm5Vu01la2InZxlajXrcQ3xW3/5LvFC
         qp7VDnCWObX/q0XSj7rJFV5tumh2nWn6Wl4HpKYa1m5FUfhSpbeapU7Iv6ZFXWwl5byv
         YKbokVX5iBYL7Q7hQNn/JE7iqb9MAATVkRUdhm2Xf3DtaYSZsnSITUeN3q3oCfbjoLKO
         6PEVeO1kkR/fBigXEm1eRIxoyLEbL8rXVklpxBg5uEkbkQhZwgE/y6fwpjar8DQCAuZA
         bDuw==
X-Received: by 10.180.189.133 with SMTP id gi5mr108795wic.5.1398172466005;
        Tue, 22 Apr 2014 06:14:26 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.92.98 with SMTP id cl2ls518211wib.53.canary; Tue, 22 Apr
 2014 06:14:25 -0700 (PDT)
X-Received: by 10.180.160.231 with SMTP id xn7mr1727222wib.1.1398172465115;
        Tue, 22 Apr 2014 06:14:25 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id u49si325820eeo.1.2014.04.22.06.14.25
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256/256);
        Tue, 22 Apr 2014 06:14:25 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LyEJp-1WxojF0aE1-015YIq;
 Tue, 22 Apr 2014 15:14:24 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <535569e92cbcc_32c48493101f@nysa.notmuch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:tZz+bK1bOXrr7HK0MfpA71laqkweKUehrVhsmejZmS3+hYX2lYm
 +oKbNi+dbtLnQ0swkRqYxOevNqsk4amLB7Hoi9e8u+b8JeBZTLiSE3xuprwNh+NOBZDQxhU
 Fh5V+Ee/yThdtVYlDXPiHabMJyKudSJO5N9qanzc0VzQXStJEmITxVeXAJSwJXLkvCOU/ZD
 jbiLlTDQ7Ha7tQMqAwezQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246735>

Hi,

On Mon, 21 Apr 2014, Felipe Contreras wrote:

> Johannes Schindelin wrote:
> > Now, clearly you have all the motivation that is needed to get 64-bit
> > builds of Git for Windows going, and all the motivation required to make
> > sure that the MSVC support of the msysGit project works.
> 
> s/msysGit/Git/

No. I meant the msysGit project; the project that maintains the current
development environment for Git for Windows. Please do not try to
reinterpret what I am saying.

> Personally I don't see why ideally I shouldn't be able to build upstream
> Git for Windows with mingw without leaving my Linux system.

Maybe because you could not even test it properly, let alone run the test
suite? And maybe because according to the famous "scratch your own itch"
credo, it is actually the duty of Windows users -- i.e. users who do not
even have your Linux system -- to fix the bugs that would never be
encountered anywhere but Windows?

Hth,
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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

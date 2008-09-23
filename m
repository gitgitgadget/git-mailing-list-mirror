From: "Lee Henson" <lee.m.henson@gmail.com>
Subject: Re: [ANNOUNCE] Git-1.6.0.2-preview20080923
Date: Tue, 23 Sep 2008 13:09:14 +0100
Message-ID: <935bb4150809230509r422f32a5wbcf39a6e32281af5@mail.gmail.com>
References: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de> <691F01A6-CA78-46DA-8388-C8339A3F0F04@zib.de> <B463062F-DD48-44A7-B2BB-8E5E0D177616@zib.de>
Reply-To: lee.m.henson@gmail.com
Mime-Version: 1.0
Content-Type: multipart/alternative;  boundary="----=_Part_6189_11666264.1222171754187"
Cc: msysGit <msysgit@googlegroups.com>, "Git Mailing List" <git@vger.kernel.org>
To: prohaska@zib.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 23 14:10:29 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.241])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki6ip-0002Oh-0f
	for gcvm-msysgit@m.gmane.org; Tue, 23 Sep 2008 14:10:27 +0200
Received: by wa-out-0708.google.com with SMTP id n36so4173337wag.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 23 Sep 2008 05:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:to:subject:cc:in-reply-to:mime-version:content-type
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=TT8Nz4PzJq+ZqLNtdEpJQRVuTXEw9EGOR/ziM91mnc8=;
        b=UxNkvAalNWhbUmr28BogqMa5WPy95OU9ofZJMpl2LkRWORW6s4sWCRvsAMEOVtfL0k
         TOzbRTsrRhqQeXaG1HdpqNQnAj56FphglmJuSDus1a2cACVXB4sy6IOEzjgqq3pDn8dU
         sErEpF0ONf6XzP/+CA3APuClGBqF9nd/OVpEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:to:subject
         :cc:in-reply-to:mime-version:content-type:references:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=AcJga0NQNyDETB5H7mVNX/VXqPzUY9GCh9UQ5/ovg+WkJBCF6nvp4VMrZgcuoRIaQ4
         68YSxrjZwsKMHoPYqiyFxWMOvcxphzgSUyw9pm44fObDDE1cl9fSgyAkKtMzzk21C1wq
         oPNrwsQkUYKH6aHzcynnyKoBnshcgdZ5qGU0o=
Received: by 10.141.27.16 with SMTP id e16mr291626rvj.6.1222171755411;
        Tue, 23 Sep 2008 05:09:15 -0700 (PDT)
Received: by 10.107.67.19 with SMTP id u19gr2972prk.0;
	Tue, 23 Sep 2008 05:09:15 -0700 (PDT)
X-Sender: lee.m.henson@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.151.39.2 with SMTP id r2mr2437945ybj.11.1222171755018; Tue, 23 Sep 2008 05:09:15 -0700 (PDT)
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.239]) by mx.google.com with ESMTP id 7si10437660yxg.0.2008.09.23.05.09.14; Tue, 23 Sep 2008 05:09:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of lee.m.henson@gmail.com designates 64.233.184.239 as permitted sender) client-ip=64.233.184.239;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of lee.m.henson@gmail.com designates 64.233.184.239 as permitted sender) smtp.mail=lee.m.henson@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by wr-out-0506.google.com with SMTP id c57so650404wra.4 for <msysgit@googlegroups.com>; Tue, 23 Sep 2008 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to :subject:cc:in-reply-to:mime-version:content-type:references; bh=ATj6gOr3EwzM2QvP+QOPoBunL/HvBhVmgB8JM5Z3RyI=; b=ngaK7JrwxauqgbIh4qmv5nuHtt9gGu87L50kNk6Ap9xm3rOWRxZ0duuI9y2sPfZg2L 4Vf2SYNxq9TYwDrEv330YcScrI1WyOE5AYBLkIrbG91UOpdh4Cw7YV0mY87IXwCI4vfQ W7kwYHsVR8H77BYL6qQO1DCQciXdMEOgwhdyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version :content-type:references; b=iQZJ+4SeCP+md5GSQFuGfdrZ9wrAhfROBscCE5I+s4+zXda3rueRd6Lb/Xn3c5vCIW gB7ku1jKRbxQwG3vQ+KR0SabqA3Lytxbf52ciKiXAQXD262Lw4nnAGPy+kIIpnh6LBCj 4gpIolSX3hKlwtB1iV15DJ5+Dgqnj+9QBBw8A=
Received: by 10.65.93.12 with SMTP id v12mr9709713qbl.78.1222171754146; Tue, 23 Sep 2008 05:09:14 -0700 (PDT)
Received: by 10.64.91.7 with HTTP; Tue, 23 Sep 2008 05:09:14 -0700 (PDT)
In-Reply-To: <B463062F-DD48-44A7-B2BB-8E5E0D177616@zib.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96555>


------=_Part_6189_11666264.1222171754187
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Steffen.

2008/9/23 Steffen Prohaska <prohaska@zib.de>

>
> On Sep 21, 2008, at 7:33 PM, Steffen Prohaska wrote:
>
> > Git-1.6.0.2-preview20080921 for Windows is available at
> >
> >   http://code.google.com/p/msysgit/downloads
>
>
> I updated the installer to Git-1.6.0.2-preview20080923.
> The problems reported on the mailing list during the
> last two days should be fixed.
>
> I apologize for the quality of Git-1.6.0.2-preview20080921.
> It was unacceptable.
>
>        Steffen
>

------=_Part_6189_11666264.1222171754187
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Thanks Steffen.<br><br><div class="gmail_quote">2008/9/23 Steffen Prohaska <span dir="ltr">&lt;<a href="mailto:prohaska@zib.de">prohaska@zib.de</a>&gt;</span><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
On Sep 21, 2008, at 7:33 PM, Steffen Prohaska wrote:<br>
<br>
&gt; Git-1.6.0.2-preview20080921 for Windows is available at<br>
&gt;<br>
&gt; &nbsp; <a href="http://code.google.com/p/msysgit/downloads" target="_blank">http://code.google.com/p/msysgit/downloads</a><br>
<br>
<br>
I updated the installer to Git-1.6.0.2-preview20080923.<br>
The problems reported on the mailing list during the<br>
last two days should be fixed.<br>
<br>
I apologize for the quality of Git-1.6.0.2-preview20080921.<br>
It was unacceptable.<br>
<font color="#888888"><br>
 &nbsp; &nbsp; &nbsp; &nbsp;Steffen<br>
</font></blockquote></div><br></div>

------=_Part_6189_11666264.1222171754187--

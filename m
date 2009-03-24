From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git for Windows 1.6.2.1-preview20090322
Date: Tue, 24 Mar 2009 03:06:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903240304480.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903222149330.10279@pacific.mpi-cbg.de> <4285cd450903231503x5d332bfft17b01e598d11bc09@mail.gmail.com>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-588557393-1237860361=:10279"
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Ludvig Strigeus <strigeus@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Mar 24 03:06:07 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f163.google.com ([209.85.221.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llw1E-0001rq-8I
	for gcvm-msysgit@m.gmane.org; Tue, 24 Mar 2009 03:05:53 +0100
Received: by qyk35 with SMTP id 35so3685463qyk.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 23 Mar 2009 19:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=c2Shw2szZhA5EHg4K0V54BOVx6P7oI+/ZEf1DDchkoY=;
        b=5DZOt+RQpYrQDepCUUCyehUNyFvfrv2cRcIGx8A+meEBtSe/r69Gsn58B+aPCNRxDq
         o/tTrhtldnTgUQY068NoOzjExYHchevylenPw6qkdEKYhEKHqxwyCa8inj28MqF+1mGi
         Pz1gpE9rPrYwTClujzGwIaajzc0rzHmJ/PyDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=R0w5a5dxmb89lNFF0GbrGFyqObiJnOww40n2bilsmSRc48EIQUfGS3jR8g5truYbnY
         OywIL72dBV65d5IOlH4UyLUmiEAtUOyULsDeuYWo2Ka/6LHf/WEbLUVUNwHLrf3chnbk
         TYVMxM+UPeYZ6lLjqo4TJZU4MighbAdQo3hX4=
Received: by 10.224.19.196 with SMTP id c4mr1024726qab.18.1237860237141;
        Mon, 23 Mar 2009 19:03:57 -0700 (PDT)
Received: by 10.230.110.92 with SMTP id m28gr4393vbp.0;
	Mon, 23 Mar 2009 19:03:57 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.76.67 with SMTP id b3mr188119bkk.6.1237860235930; Mon, 23 Mar 2009 19:03:55 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 13si529683bwz.3.2009.03.23.19.03.55; Mon, 23 Mar 2009 19:03:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 24 Mar 2009 02:03:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp069) with SMTP; 24 Mar 2009 03:03:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18itxRiJikiZ/vqX8bpWQuwkkvDEdjxrMHsVRpYUD muwv4//BGcWj5E
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4285cd450903231503x5d332bfft17b01e598d11bc09@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114391>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-588557393-1237860361=:10279
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 23 Mar 2009, Ludvig Strigeus wrote:

> 
> On Sun, Mar 22, 2009 at 10:17 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > - There are a few issues with ssh hanging (Issue 197), permission 
> >   denied  on renaming pack files (mentioned in Issue 194), and 
> >   spurious write  errors during rebase (Issue 200) that seem not to be 
> >   reproducible on  most computers.
> 
> I had this problem with write errors during rebase. I tracked it down
> to having the files open in Visual Studio while doing the rebase.

It seems pretty clear from the original report (or at least from the 
following comments) that the files haven't been opened anywhere.

But thanks for your help!

Ciao,
Dscho
--8323328-588557393-1237860361=:10279--

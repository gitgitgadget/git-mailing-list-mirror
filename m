From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: Release candidate of Git for Windows 2.x is out
Date: Sat, 27 Jun 2015 10:41:16 +0200
Organization: gmx
Message-ID: <f108b551e742eb65f6cb4750e7a082ac@www.dscho.org>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
 <f80886fc-8c51-4af8-9472-23c5b9fbe2a6@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git-for-windows@googlegroups.com, msysgit@googlegroups.com,
 git@vger.kernel.org
To: Ties <thijsbrobbel@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBLODXGWAKGQE2IOSAFI@googlegroups.com Sat Jun 27 10:41:19 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBLODXGWAKGQE2IOSAFI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f57.google.com ([74.125.82.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBLODXGWAKGQE2IOSAFI@googlegroups.com>)
	id 1Z8lfq-0001Tj-1v
	for gcvm-msysgit@m.gmane.org; Sat, 27 Jun 2015 10:41:18 +0200
Received: by wggx12 with SMTP id x12sf35191563wgg.1
        for <gcvm-msysgit@m.gmane.org>; Sat, 27 Jun 2015 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=+4sJ6uW5C2A+xLGr+M+hmK6A3ZaYUYjSG3H+gBrh6fY=;
        b=aFRsiSbNnmA+rpraHITDh52Y5KI5jtUNwQyDFE4fEMnA4fz/00GMzsIA1Sxns8KhLL
         T7P5X4XelUST2sdpNViir4a72psJjNoAz/f3qZH8mFBwDd1mD74NMmEh7ICgM9YMK4IV
         VCupgrOhOlWMybFNyz13vq97vw97KHEYSfs1cRaJNx4zmI7V+0ZrEY0syN2asO1W3WWj
         8w9mNF3QHX6nM6BUdge+e/u7blQ0wzF0p6najUpEpujNO8pI+2XGUgxZar3u24QFX4Pt
         FlKZC3MTVnX2ujBtKWmVmT6l5klbzs07aoLbkRmQEeC1YqqpnYms3+fFDzG0fZAxEw6p
         7MpQ==
X-Received: by 10.180.11.142 with SMTP id q14mr10431wib.21.1435394477704;
        Sat, 27 Jun 2015 01:41:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.29.67 with SMTP id ju3ls285189wid.46.gmail; Sat, 27 Jun
 2015 01:41:17 -0700 (PDT)
X-Received: by 10.180.37.198 with SMTP id a6mr1712764wik.7.1435394477048;
        Sat, 27 Jun 2015 01:41:17 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id ec7si68276wib.3.2015.06.27.01.41.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2015 01:41:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MJk04-1Z7fk82pgS-0016Ni; Sat, 27 Jun 2015 10:41:16
 +0200
In-Reply-To: <f80886fc-8c51-4af8-9472-23c5b9fbe2a6@googlegroups.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Vgq7m7kK5+RCo9xHe+mRJt7qQRScNihu9jLJhDG4CfyHI3OhFe6
 8ctOYtSk3Tp3YO+dvMebd+zPRE+qV3Dkai+lE2BcerS6IaX5A5dkws2/UMHQ6WSjcaY7pxn
 P67gdNMzCS3noXQeWFb26ESYLzX9MJtwlaHAMJKBEWYBIOUZVb5eRLSKPxrp0Soh1Ni69PE
 H3e+T6pz9LtBqt35tG3aA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:chLYwhKispo=:nxr3T6I4Jxj6Xiod4OmeWf
 EBMb/uu/RJ4R6ozqJemByaIsQXig0QLgRPURIKkDNElseHEaiaXvYHLkwuDbrp441xsFZk30V
 BS7uyAQW7+/oL75GdKADiy+jXQVPoOwTUtQgGi0M0tLUX699hMx1yLR47sF6GOuglpzr9x5JD
 aCTy0UEBY8IpazgbmvWGZ6AvIDq2LuAnycpaeFkwr0jj/2zl3KOFdBhgwI4m2vxzL92o9fyPr
 +hUiDpxeBTjvDDPw4/7DBgs4CiA4b+pnn5mT0Uq8ur8TM5gDw3jT/20obEvve5QXXk4VeOiwD
 7qekVAYls+gIyfLOfOeW6O8crBMWv0QinwGYXFzZcmItV225oLb1ftSvGvjA/aagj8m/zDYbb
 bYiJTYNYewJNC1ewRqyPUSMIrV6cYRAdy0IasVdjnVHYFs5HEmYt+1UJTymwzZx2Gk/ZdjVUi
 eiTUuRpaigk03+whZCd0ZHu8xfUN63IbAXQ3Ft6Z5mVM2SthaUCcVTiwuJR1njidMtbx1WVGm
 k6ft91Gxim2G9IRVskMWteP0ur/tKDTxpynv6kwec4b9V8k8E96rrYBR1uCyBBN8VTShkCZaJ
 XRyB3t0Fhjvf670xUB9pN8dj5SR9lknvWdsnEzymBvcDqk3EHLSCmVLrU+oE4+gGdMMtDu8dm
 vKLZ71n/YpxidMjyrIfinkwlDNf1NXwNXY1/rGddagGNn7pm6v8L8zVpnfkvd77lmnGE=
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272855>

On 2015-06-26 13:06, Ties wrote:

> Do you have an ETA on the final release? 

No, sorry, no ETA yet.

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

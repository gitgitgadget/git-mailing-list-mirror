From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: Release candidate of Git for Windows 2.x is out
Date: Tue, 09 Jun 2015 15:07:25 +0200
Organization: gmx
Message-ID: <189934a012439295d3e9748f53395cf6@www.dscho.org>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
 <aa3467c7-bf83-4ccb-be64-929b944806ba@googlegroups.com>
 <56c307e1fd6320e55cc8a62f28f70f8f@www.dscho.org>
 <CAMZY0JP2U58LLLqjzSuqzUVjvYwUcfzZWG0x52WxGP3twD-dqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysgit@googlegroups.com, git-for-windows@googlegroups.com,
 git@vger.kernel.org
To: QbProg <tholag@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBD6K3OVQKGQENECGXAI@googlegroups.com Tue Jun 09 15:07:28 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBD6K3OVQKGQENECGXAI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f64.google.com ([209.85.215.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBD6K3OVQKGQENECGXAI@googlegroups.com>)
	id 1Z2JFX-0007mU-KA
	for gcvm-msysgit@m.gmane.org; Tue, 09 Jun 2015 15:07:27 +0200
Received: by lamq1 with SMTP id q1sf3353879lam.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 09 Jun 2015 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=s5uci9ESV2HrYHJJ3RfpG/M59juxa6JHgupY8q8mOCc=;
        b=zGZHTwc78xWqkvBX4Q20faAEn0rV1TbCNPLyyHdN+mbaueT8SzyPmDDABHyXRq2BQG
         MwJ6WRqRq248zPdPtuS2uYVhRcepM4h0cXxnLmggV9Q+TSd1iBZXp8C3zygWQKO5PP88
         4XjdFc/s5uiDlSMj8+WWQQvT1vIp/XFsQjkK5+RokXn08FccntvYo35iocQmpY0b4Rnm
         qqMb/JJfEdBuDuN80khjkU27CtZy5+Eg3fpdox+ZZXfWT4FGlT3jFr4YivoiP+205ywB
         9SMfQdXC5d68/R2DtaxISecSLvUTbAQe3oYJunlydkr1WQkYLRxmcENXaIMnyrXKfCsH
         QpuQ==
X-Received: by 10.180.23.33 with SMTP id j1mr99476wif.21.1433855247344;
        Tue, 09 Jun 2015 06:07:27 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.8.195 with SMTP id t3ls1163428wia.43.canary; Tue, 09 Jun
 2015 06:07:26 -0700 (PDT)
X-Received: by 10.180.90.106 with SMTP id bv10mr17220240wib.6.1433855246727;
        Tue, 09 Jun 2015 06:07:26 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id ec7si92029wib.3.2015.06.09.06.07.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 06:07:26 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LfC4q-1ZQMXW096W-00on38; Tue, 09 Jun 2015 15:07:26
 +0200
In-Reply-To: <CAMZY0JP2U58LLLqjzSuqzUVjvYwUcfzZWG0x52WxGP3twD-dqg@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:cYiO7BZjxMtsNqyfHCnTCP4iZgVscv4XrUgXXhlaVFu1VMby51p
 s81novIkza+7a4XgmKU2GbjuPVkEl5jrxNYNpK4cl2UIredsQgM5rRSukTWl5v3zhHyhABR
 blt4hlDcnvDCiIS5Up7MYQL6m0VVqrKK/yntTnmiSqSJLQYg6VRibVsRfGrmXhYveWvZoyM
 Ucu/fLbGib/OuXCvTAGFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Nhh0TVYc1XA=:reLSsfRqPaYA47RCY5OKti
 8be1z6M1ytZelkXNRaatSxA3/y0Nso4lQwExJ5fVWWxlJe+pw8xYXban9iWUmSK7gWM/AJfuh
 Tuujq33ZeYvMnEAmyI0lJo5bKxsHcy6zPOe4CzGeFhRjyhLFTRbYxgnV9ZIsxMkVEmCtY1A+t
 G1oHgnatE4+cRDISqgzKxe0AStCPAR3rZkjKBGOlj9KPHsgjOl5susX+unRs4QcxWrU4gPbp3
 qDfxXwEy7CKSGTpatqCxIrAH54K37tTWodyMsirkzyiim2X5svF52LoBxnJCypCvoR0mB70W+
 i+rrI2tD3KHx+pN0fOQkG48Oxz7xCIaXQI41d1fE6AwuD2NKMEtz1/Yn235FOaVtzIDEGZx6S
 vG1guMBcr9g8RDe4YUEVL17ylQ5HtcJdrnfJGvNmR/wUDBcob7JieeO79+tkxYgk0oCeAFB/J
 SFB48tmO0Nn2A1TCqj2tiU9pyZ2aSpRns26CkSSIoLSA5qGBlD6wkHV44SLQdGOfCPjaKebb8
 KkUutyl3mpwLT1ozCchLNcfu7mdBhEdT/xZeEHRYHvwADLcmFkA4ww2Xk+LbFIftwvToImWxl
 E6UeBGQ/qjS1HD0Qnj0OrTdEX3KI1hrdjy+kd+utgTnb6I9EaeQ5jQZfGz1BdKadfr0WiRQkf
 n4bWkFVfOmue6M1RnzF+gGzJqSNWgJUQZi9zkXAfZmVuLPW0pCG2MKFN2ThjmNDcffcU=
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.21 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271175>

Hi,

On 2015-06-09 14:10, QbProg wrote:

> I reproduce it using the windows command prompt (cmd.exe) using any
> repository. I tryed with bash and it works correctly.

Please note that you removed enough context that the mail does not make sense anymore if read individually.

At this point it might be best to open a ticket, as I suggested in my announcement: just log into GitHub (or sign up for free) and direct your web browser to https://github.com/git-for-windows/git/issues/new.

For the record: I tried again, with `Git CMD`, this time I called

```cmd
git clone https://github.com/dscho/images.git octo2
```

... and octo2/ is created correctly and contains the `.git/` subdirectory (which is hidden by default, but you can call `cd octo2/.git`). Read: I still cannot reproduce the issue.

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

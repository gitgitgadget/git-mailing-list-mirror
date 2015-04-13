From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Re: Sneak peek of the upcoming Git for Windows 2.x
Date: Mon, 13 Apr 2015 16:32:37 +0800
Message-ID: <CALUzUxpZk9hpGL6U2c_=SBp2U3nBhQCbj0vvxB6Z7SKxzjZVsA@mail.gmail.com>
References: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
 <39e23864-b75b-4fef-ab90-3413e4e76900@googlegroups.com> <b1cc6ba927238fdaa68f685be42002c7@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>, 
	"msysgit@googlegroups.com" <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: rupert thurner <rupert.thurner@gmail.com>
X-From: msysgit+bncBCEMFWO7QMPRBOP6VWUQKGQEEOQ2PPA@googlegroups.com Mon Apr 13 10:32:59 2015
Return-path: <msysgit+bncBCEMFWO7QMPRBOP6VWUQKGQEEOQ2PPA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qk0-f188.google.com ([209.85.220.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCEMFWO7QMPRBOP6VWUQKGQEEOQ2PPA@googlegroups.com>)
	id 1YhZne-0000CB-SU
	for gcvm-msysgit@m.gmane.org; Mon, 13 Apr 2015 10:32:59 +0200
Received: by qkbx191 with SMTP id x191sf113989884qkb.0
        for <gcvm-msysgit@m.gmane.org>; Mon, 13 Apr 2015 01:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=bUz6ZN6RRPqy22m24gNLH9F6EyWHmwNwtrtjxbeKHgU=;
        b=xkS2G5Eal6XXW+GMmGbxGkLGpnA6Cj+7JEuDiwKtnqIWMMPia76xjpi0q0knl98zj8
         I8uu3ZEVOQPgagTiHU4hxPyZaAicHsEnahZEvAF0Sn5q25iCtVbPfXpSzTBsI1AfY0AE
         hxMSDs48pL6Iw4ZEOUJt8M7R8inc4wnxVOrA5BRlGQdlMlqwoLMU6fhZqajXb3HVcsna
         yQCle6aLViithSBDiET8C+KGr8iDlcs3oiFGu82mfFgxgEnaEZaSDFUNYfRMjABcCmXd
         1l1tgyZLPnFgM8yepnWUSrtSj5FQsZWJXtrJ/+gavCeeVqzHCtHyKZ25bwemYj1m+Mlr
         oejA==
X-Received: by 10.140.21.145 with SMTP id 17mr147018qgl.1.1428913978108;
        Mon, 13 Apr 2015 01:32:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.44.2 with SMTP id f2ls2621774qga.42.gmail; Mon, 13 Apr
 2015 01:32:57 -0700 (PDT)
X-Received: by 10.236.38.8 with SMTP id z8mr18851755yha.21.1428913977665;
        Mon, 13 Apr 2015 01:32:57 -0700 (PDT)
Received: from mail-ig0-x22f.google.com (mail-ig0-x22f.google.com. [2607:f8b0:4001:c05::22f])
        by gmr-mx.google.com with ESMTPS id d4si623561igl.1.2015.04.13.01.32.57
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2015 01:32:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of rctay89@gmail.com designates 2607:f8b0:4001:c05::22f as permitted sender) client-ip=2607:f8b0:4001:c05::22f;
Received: by mail-ig0-x22f.google.com with SMTP id lo3so39497411igb.1
        for <msysgit@googlegroups.com>; Mon, 13 Apr 2015 01:32:57 -0700 (PDT)
X-Received: by 10.42.132.200 with SMTP id e8mr17401157ict.86.1428913977548;
 Mon, 13 Apr 2015 01:32:57 -0700 (PDT)
Received: by 10.64.58.43 with HTTP; Mon, 13 Apr 2015 01:32:37 -0700 (PDT)
In-Reply-To: <b1cc6ba927238fdaa68f685be42002c7@www.dscho.org>
X-Original-Sender: rctay89@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of rctay89@gmail.com designates 2607:f8b0:4001:c05::22f
 as permitted sender) smtp.mail=rctay89@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267069>

Hi Rupert,

On Mon, Apr 13, 2015 at 1:51 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> On 2015-04-11 10:37, rupert thurner wrote:
> > * the prompt is still as slow as before, calculating the branch name on
> > pressing return without option to turn it off
>
> There is no explicit option in the installer to turn it off, but you can =
easily edit `/etc/profile.d/git-prompt.sh` to adjust it to your liking.
>
> If you think that more people would want to have an option in the install=
er to switch it off, you should read https://github.com/git-for-windows/git=
/wiki/Making-an-installer, edit /usr/src/build-extra/installer/install.iss.=
in after having a look at https://github.com/git-for-windows/build-extra/co=
mmit/cbcf69b9 and open a Pull Request.

Personally I edit it away from PS1:
https://github.com/rctay/msysgit/commit/4038833505bc2c088524546e923d64d69c0=
fa37f

--=20
Cheers,
Ray Chuan

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

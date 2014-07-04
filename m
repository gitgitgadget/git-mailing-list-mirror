From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git for Windows no longer on Google Code
Date: Fri, 4 Jul 2014 19:10:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1407041908060.14982@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1407031701540.14982@s15462909.onlinehome-server.info> <53B6DE5A.8060702@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: =?ISO-8859-2?Q?Jakub_Nar=EAbski?= <jnareb@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBJWA3OOQKGQENXB47UY@googlegroups.com Fri Jul 04 19:11:10 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBJWA3OOQKGQENXB47UY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f188.google.com ([209.85.212.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBJWA3OOQKGQENXB47UY@googlegroups.com>)
	id 1X370p-0002yf-3J
	for gcvm-msysgit@m.gmane.org; Fri, 04 Jul 2014 19:11:03 +0200
Received: by mail-wi0-f188.google.com with SMTP id e4sf404486wiv.25
        for <gcvm-msysgit@m.gmane.org>; Fri, 04 Jul 2014 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=6m4/n9/ZWP1htkqOruJc9sSrTXGLK315jTrivVuYBBg=;
        b=DuilSIJO3mHTC7exYmkjVAPw6wLF+/k0x0UNkc8ZMO4Frgx4el2PBFyycPnXoN+R+2
         Btjm+hk2dJhQ0i9b8CeVA0oZVCEqGOtlPDFnIF+QB4u+0UrFCvdOUmn16pRAzUVs/CDK
         oHAzEDRQestCVsX6eBk7uBooDyeP81BG/7U7QdZAsNK2O9u7C7x/bES/lCqsPzzvpBLu
         JIHAnwZfzDo6lBTEix6pIejPYCHKsuZ9U0GVPWs3CCR8MEEo3VCOK9h7nQaD8TWZnDQf
         EblM5ie7+UFn+upt2VGZg8rIV63iIUvGCrVfTPJHz2pZus4AXDDNONjz6yDCpdme4H2J
         v84g==
X-Received: by 10.152.36.37 with SMTP id n5mr144689laj.3.1404493862795;
        Fri, 04 Jul 2014 10:11:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.4.37 with SMTP id h5ls197628lah.89.gmail; Fri, 04 Jul 2014
 10:11:01 -0700 (PDT)
X-Received: by 10.112.171.35 with SMTP id ar3mr1150468lbc.0.1404493861875;
        Fri, 04 Jul 2014 10:11:01 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id cj4si1359174wid.0.2014.07.04.10.11.01
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jul 2014 10:11:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LpKY5-1WOZja0CYf-00fEnN;
 Fri, 04 Jul 2014 19:10:59 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <53B6DE5A.8060702@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:jlB0zNNc1wk77Ww3NPBZA+f+EB5rlwXrBxlCG6zG6QND/Cg02Ac
 NTAA8eRVmfF2QeCTZtM7JMsd/DKV0vEZA9MqZ3WobzjX75RkyioFLvCWjwwolM/uf0cVJCs
 oiQyMuuDB4IGF/7r8KxSTmSDBD4MsHKvFo5lg0LBQst9pvDu5wEZm9v2YPf5cCCnVSJ4bBF
 6wlf/ZYPW2rZYZmnWBeyA==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252899>

Hi Jakub,

On Fri, 4 Jul 2014, Jakub Nar=C4=99bski wrote:

> Shouldn't this message be marked [ANNOUNCE] in subject?

Well, I did not exactly announce something.

> Johannes Schindelin wrote:
>
> > the Git for Windows team, myself included, tried quite a couple of
> > times to mark the old home of Git for Windows on Google Code as
> > obsolete.
> >
> > Unfortunately, it is not possible to disable issue trackers nor
> > downloads (and Google Search helpfully insists on listing them as top
> > hits, still).
> [...]
>=20
> Hmmm... Thrust also moved to GitHub, but didn't disable Google Code page.=
..

Good for them.

We had people who *still* downloaded the now thoroughly obsolete versions
from Google Code. It was not enough to mark all of the downloads as
deprecated, even.

And if things work for Thrust: good for them. Things just happened not to
work for the Git for Windows project, is all.

Ciao,
Johannes

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
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

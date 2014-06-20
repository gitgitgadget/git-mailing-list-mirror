From: Yue Lin Ho <yuelinho777@gmail.com>
Subject: Re: The different EOL behavior between libgit2-based
 software and official Git
Date: Fri, 20 Jun 2014 16:30:52 +0800
Message-ID: <CAO_ghTLq-a3dJGXvmspaCYS19RhTJzT0teWO5XSfVSiRUN7rrQ@mail.gmail.com>
References: <1403146778624-7613670.post@n2.nabble.com>
	<53A285A1.3090804@web.de>
	<53A3DB01.7090904@web.de>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=001a11347e3ec19c8d04fc404fdc
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBCQ6P57Q3EFRBPPCR6OQKGQEOPIMOUQ@googlegroups.com Fri Jun 20 10:30:58 2014
Return-path: <msysgit+bncBCQ6P57Q3EFRBPPCR6OQKGQEOPIMOUQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f61.google.com ([74.125.82.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCQ6P57Q3EFRBPPCR6OQKGQEOPIMOUQ@googlegroups.com>)
	id 1WxuDn-0001Pe-Ex
	for gcvm-msysgit@m.gmane.org; Fri, 20 Jun 2014 10:30:55 +0200
Received: by mail-wg0-f61.google.com with SMTP id l18sf390518wgh.16
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 01:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=kwnwdssEAFHQFbeuFO6MJEWcEwPRlXYYdKQHNerYdds=;
        b=TCN7PhmnRM0ckkrOfWRyq656f4F3REAY4/czD+Tf6oNRdjtD3y/PH+4uqoKo+jc3bO
         y6Ui9GzDS1Zqze/gla3tvutJVdCXkP7qm1xVG5a8ANNA78+47BZMWA1QnyDK16TADVVB
         BG20RLf6nvQtq1LWOPyZe40IQ6U6nTzMO/ZWurfQJkw7VIJL0kLHtZUdS1yYQJ42jELR
         AJ43Gu/mCafUqX0dV/yl6FU3755iwGiYSh5UQSdz2+nrzgsorOfb5JSKra9bJchVGm/2
         7XVFjh+GDHC8LEdlByFi7rzhPKojrnhWte0XVk7+5xO50LmcIkTW3na0NNYmhmjPTPtE
         RR9w==
X-Received: by 10.180.91.107 with SMTP id cd11mr6199wib.12.1403253054133;
        Fri, 20 Jun 2014 01:30:54 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.107.98 with SMTP id hb2ls39816wib.26.canary; Fri, 20 Jun
 2014 01:30:53 -0700 (PDT)
X-Received: by 10.180.89.232 with SMTP id br8mr167490wib.1.1403253053179;
        Fri, 20 Jun 2014 01:30:53 -0700 (PDT)
Received: from mail-la0-x234.google.com (mail-la0-x234.google.com [2a00:1450:4010:c03::234])
        by gmr-mx.google.com with ESMTPS id tf1si958295lbb.1.2014.06.20.01.30.53
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 01:30:53 -0700 (PDT)
Received-SPF: pass (google.com: domain of yuelinho777@gmail.com designates 2a00:1450:4010:c03::234 as permitted sender) client-ip=2a00:1450:4010:c03::234;
Received: by mail-la0-f52.google.com with SMTP id ty20so2112900lab.25
        for <msysgit@googlegroups.com>; Fri, 20 Jun 2014 01:30:53 -0700 (PDT)
X-Received: by 10.152.9.169 with SMTP id a9mr603149lab.71.1403253053035; Fri,
 20 Jun 2014 01:30:53 -0700 (PDT)
Received: by 10.112.19.35 with HTTP; Fri, 20 Jun 2014 01:30:52 -0700 (PDT)
In-Reply-To: <53A3DB01.7090904@web.de>
X-Original-Sender: yuelinho777@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of yuelinho777@gmail.com designates 2a00:1450:4010:c03::234
 as permitted sender) smtp.mail=yuelinho777@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252218>

--001a11347e3ec19c8d04fc404fdc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi:


2014-06-20 14:56 GMT+08:00 Torsten B=C3=B6gershausen <tboegi@web.de>:

> Hm,
> I feeled puzzled here.
> Even if I wouldn't recommend to use core.autocrlf, and prefer to use
> .gitattributes,
> the CRLF conversion should work under Git, but it doensn't seem to do so.
>
> Clone this repo:
> origin  https://github.com/YueLinHo/TestAutoCrlf.git
> Try to see if LF or CRLF can be converted into CRLF,
> when core.autocrlf is true.
>
>
> Neither msysgit nor Git under Linux produces CRLF (?)
>
> Git under Mac OS produces the CRLF:
> both Git 2.0.0  and the latest msygit code base (7e872d24a9bd03),
> compiled under Mac OS
>
> What do I miss ?
>
> git --version
> git version 2.0.0
> tb@Linux:~/EOL_Test/TestAutoCrlf$ t=3DMIX-more_LF.txt  &&  rm -f $t &&  g=
it
> -c core.eol=3DCRLF checkout $t  && od -c  $t
> 0000000   L   i   n   e       1  \n   l   i   n   e       (   2   )  \r
> 0000020  \n   l   i   n   e       3   .  \n   t   h   i   s       i   s
> 0000040       l   i   n   e       4  \n   l       i       n       e
> 0000060   N   o   .       5  \n   L   i   n   e       N   u   m   b   e
> 0000100   r       6  \n
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> $ git --version
> git version 1.9.2.msysgit.0.1206.g7e872d2
>
> tb@msgit ~/EOL_test/TestAutoCrlf (master)
> $  t=3DMIX-more_LF.txt  &&  rm -f $t &&  git -c core.eol=3DCRLF checkout =
$t
>  && od -c  $t
> 0000000   L   i   n   e       1  \n   l   i   n   e       (   2   )  \r
> 0000020  \n   l   i   n   e       3   .  \n   t   h   i   s       i   s
> 0000040       l   i   n   e       4  \n   l       i       n       e
> 0000060   N   o   .       5  \n   L   i   n   e       N   u   m   b   e
> 0000100   r       6  \n
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> tb@mac:~/EOL_Test/TestAutoCrlf> git --version
> git version 2.0.0.622.g9478935
> tb@mac:~/EOL_Test/TestAutoCrlf> t=3DMIX-more_LF.txt  &&  rm -f $t &&  git
> -c core.eol=3DCRLF checkout $t  && od -c  $t
> 0000000    L   i   n   e       1  \r  \n   l   i   n   e       (   2   )
> 0000020   \r  \n   l   i   n   e       3   .  \r  \n   t   h   i   s
> 0000040    i   s       l   i   n   e       4  \r  \n   l       i       n
> 0000060        e       N   o   .       5  \r  \n   L   i   n   e       N
> 0000100    u   m   b   e   r       6  \r  \n
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> tb@mac:~/EOL_Test/TestAutoCrlf> t=3DMIX-more_LF.txt  &&  rm -f $t &&
>  ~/projects/git/tb.msygit/git -c core.eol=3DCRLF checkout $t  && od -c  $=
t
> 0000000    L   i   n   e       1  \r  \n   l   i   n   e       (   2   )
> 0000020   \r  \n   l   i   n   e       3   .  \r  \n   t   h   i   s
> 0000040    i   s       l   i   n   e       4  \r  \n   l       i       n
> 0000060        e       N   o   .       5  \r  \n   L   i   n   e       N
> 0000100    u   m   b   e   r       6  \r  \n
>
>
>
>
=E2=80=8BWow!

P.S.
libgit2 just has a PR that try to be identical with official git.
See https://github.com/libgit2/libgit2/pull/2432

Yue Lin Ho

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

--001a11347e3ec19c8d04fc404fdc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:&#39;cou=
rier new&#39;,monospace">Hi:</div><div class=3D"gmail_extra"><br><br><div c=
lass=3D"gmail_quote">2014-06-20 14:56 GMT+08:00 Torsten B=C3=B6gershausen <=
span dir=3D"ltr">&lt;<a href=3D"mailto:tboegi@web.de" target=3D"_blank">tbo=
egi@web.de</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Hm,<br>
I feeled puzzled here.<br>
Even if I wouldn&#39;t recommend to use core.autocrlf, and prefer to use .g=
itattributes,<br>
the CRLF conversion should work under Git, but it doensn&#39;t seem to do s=
o.<br>
<br>
Clone this repo:<br>
origin =C2=A0<a href=3D"https://github.com/YueLinHo/TestAutoCrlf.git" targe=
t=3D"_blank">https://github.com/YueLinHo/TestAutoCrlf.git</a><br>
Try to see if LF or CRLF can be converted into CRLF,<br>
when core.autocrlf is true.<br>
<br>
<br>
Neither msysgit nor Git under Linux produces CRLF (?)<br>
<br>
Git under Mac OS produces the CRLF:<br>
both Git 2.0.0 =C2=A0and the latest msygit code base (7e872d24a9bd03),<br>
compiled under Mac OS<br>
<br>
What do I miss ?<br>
<br>
git --version<br>
git version 2.0.0<br>
tb@Linux:~/EOL_Test/TestAutoCrlf$ t=3DMIX-more_LF.txt =C2=A0&amp;&amp; =C2=
=A0rm -f $t &amp;&amp; =C2=A0git -c core.eol=3DCRLF checkout $t =C2=A0&amp;=
&amp; od -c =C2=A0$t<br>
<div class=3D"">0000000 =C2=A0 L =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =C2=A0 =
=C2=A0 1 =C2=A0\n =C2=A0 l =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =C2=A0 =C2=A0 =
( =C2=A0 2 =C2=A0 ) =C2=A0\r<br>
0000020 =C2=A0\n =C2=A0 l =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =C2=A0 =C2=A0 3=
 =C2=A0 . =C2=A0\n =C2=A0 t =C2=A0 h =C2=A0 i =C2=A0 s =C2=A0 =C2=A0 =C2=A0=
 i =C2=A0 s<br>
0000040 =C2=A0 =C2=A0 =C2=A0 l =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =C2=A0 =C2=
=A0 4 =C2=A0\n =C2=A0 l =C2=A0 =C2=A0 =C2=A0 i =C2=A0 =C2=A0 =C2=A0 n =C2=
=A0 =C2=A0 =C2=A0 e<br>
0000060 =C2=A0 N =C2=A0 o =C2=A0 . =C2=A0 =C2=A0 =C2=A0 5 =C2=A0\n =C2=A0 L=
 =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =C2=A0 =C2=A0 N =C2=A0 u =C2=A0 m =C2=A0=
 b =C2=A0 e<br>
0000100 =C2=A0 r =C2=A0 =C2=A0 =C2=A0 6 =C2=A0\n<br>
<br>
</div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
$ git --version<br>
git version 1.9.2.msysgit.0.1206.g7e872d2<br>
<br>
tb@msgit ~/EOL_test/TestAutoCrlf (master)<br>
$ =C2=A0t=3DMIX-more_LF.txt =C2=A0&amp;&amp; =C2=A0rm -f $t &amp;&amp; =C2=
=A0git -c core.eol=3DCRLF checkout $t =C2=A0&amp;&amp; od -c =C2=A0$t<br>
<div class=3D"">0000000 =C2=A0 L =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =C2=A0 =
=C2=A0 1 =C2=A0\n =C2=A0 l =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =C2=A0 =C2=A0 =
( =C2=A0 2 =C2=A0 ) =C2=A0\r<br>
0000020 =C2=A0\n =C2=A0 l =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =C2=A0 =C2=A0 3=
 =C2=A0 . =C2=A0\n =C2=A0 t =C2=A0 h =C2=A0 i =C2=A0 s =C2=A0 =C2=A0 =C2=A0=
 i =C2=A0 s<br>
0000040 =C2=A0 =C2=A0 =C2=A0 l =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =C2=A0 =C2=
=A0 4 =C2=A0\n =C2=A0 l =C2=A0 =C2=A0 =C2=A0 i =C2=A0 =C2=A0 =C2=A0 n =C2=
=A0 =C2=A0 =C2=A0 e<br>
0000060 =C2=A0 N =C2=A0 o =C2=A0 . =C2=A0 =C2=A0 =C2=A0 5 =C2=A0\n =C2=A0 L=
 =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =C2=A0 =C2=A0 N =C2=A0 u =C2=A0 m =C2=A0=
 b =C2=A0 e<br>
0000100 =C2=A0 r =C2=A0 =C2=A0 =C2=A0 6 =C2=A0\n<br>
<br>
</div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
tb@mac:~/EOL_Test/TestAutoCrlf&gt; git --version<br>
git version 2.0.0.622.g9478935<br>
tb@mac:~/EOL_Test/TestAutoCrlf&gt; t=3DMIX-more_LF.txt =C2=A0&amp;&amp; =C2=
=A0rm -f $t &amp;&amp; =C2=A0git -c core.eol=3DCRLF checkout $t =C2=A0&amp;=
&amp; od -c =C2=A0$t<br>
<div class=3D"">0000000 =C2=A0 =C2=A0L =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =
=C2=A0 =C2=A0 1 =C2=A0\r =C2=A0\n =C2=A0 l =C2=A0 i =C2=A0 n =C2=A0 e =C2=
=A0 =C2=A0 =C2=A0 ( =C2=A0 2 =C2=A0 )<br>
0000020 =C2=A0 \r =C2=A0\n =C2=A0 l =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =C2=
=A0 =C2=A0 3 =C2=A0 . =C2=A0\r =C2=A0\n =C2=A0 t =C2=A0 h =C2=A0 i =C2=A0 s=
<br>
0000040 =C2=A0 =C2=A0i =C2=A0 s =C2=A0 =C2=A0 =C2=A0 l =C2=A0 i =C2=A0 n =
=C2=A0 e =C2=A0 =C2=A0 =C2=A0 4 =C2=A0\r =C2=A0\n =C2=A0 l =C2=A0 =C2=A0 =
=C2=A0 i =C2=A0 =C2=A0 =C2=A0 n<br>
0000060 =C2=A0 =C2=A0 =C2=A0 =C2=A0e =C2=A0 =C2=A0 =C2=A0 N =C2=A0 o =C2=A0=
 . =C2=A0 =C2=A0 =C2=A0 5 =C2=A0\r =C2=A0\n =C2=A0 L =C2=A0 i =C2=A0 n =C2=
=A0 e =C2=A0 =C2=A0 =C2=A0 N<br>
0000100 =C2=A0 =C2=A0u =C2=A0 m =C2=A0 b =C2=A0 e =C2=A0 r =C2=A0 =C2=A0 =
=C2=A0 6 =C2=A0\r =C2=A0\n<br>
<br>
</div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
tb@mac:~/EOL_Test/TestAutoCrlf&gt; t=3DMIX-more_LF.txt =C2=A0&amp;&amp; =C2=
=A0rm -f $t &amp;&amp; =C2=A0~/projects/git/tb.msygit/git -c core.eol=3DCRL=
F checkout $t =C2=A0&amp;&amp; od -c =C2=A0$t<br>
<div class=3D""><div class=3D"h5">0000000 =C2=A0 =C2=A0L =C2=A0 i =C2=A0 n =
=C2=A0 e =C2=A0 =C2=A0 =C2=A0 1 =C2=A0\r =C2=A0\n =C2=A0 l =C2=A0 i =C2=A0 =
n =C2=A0 e =C2=A0 =C2=A0 =C2=A0 ( =C2=A0 2 =C2=A0 )<br>
0000020 =C2=A0 \r =C2=A0\n =C2=A0 l =C2=A0 i =C2=A0 n =C2=A0 e =C2=A0 =C2=
=A0 =C2=A0 3 =C2=A0 . =C2=A0\r =C2=A0\n =C2=A0 t =C2=A0 h =C2=A0 i =C2=A0 s=
<br>
0000040 =C2=A0 =C2=A0i =C2=A0 s =C2=A0 =C2=A0 =C2=A0 l =C2=A0 i =C2=A0 n =
=C2=A0 e =C2=A0 =C2=A0 =C2=A0 4 =C2=A0\r =C2=A0\n =C2=A0 l =C2=A0 =C2=A0 =
=C2=A0 i =C2=A0 =C2=A0 =C2=A0 n<br>
0000060 =C2=A0 =C2=A0 =C2=A0 =C2=A0e =C2=A0 =C2=A0 =C2=A0 N =C2=A0 o =C2=A0=
 . =C2=A0 =C2=A0 =C2=A0 5 =C2=A0\r =C2=A0\n =C2=A0 L =C2=A0 i =C2=A0 n =C2=
=A0 e =C2=A0 =C2=A0 =C2=A0 N<br>
0000100 =C2=A0 =C2=A0u =C2=A0 m =C2=A0 b =C2=A0 e =C2=A0 r =C2=A0 =C2=A0 =
=C2=A0 6 =C2=A0\r =C2=A0\n<br>
<br>
<br>
<br></div></div></blockquote><div><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:&#39;courier new&#39;,monospace">=E2=80=8BWow!</div><div=
 class=3D"gmail_default" style=3D"font-family:&#39;courier new&#39;,monospa=
ce"><br></div>
<div class=3D"gmail_default" style=3D"font-family:&#39;courier new&#39;,mon=
ospace">P.S.</div><div class=3D"gmail_default" style=3D"font-family:&#39;co=
urier new&#39;,monospace">libgit2 just has a PR that try to be identical wi=
th official git.</div>
<div class=3D"gmail_default" style=3D"font-family:&#39;courier new&#39;,mon=
ospace">See <a href=3D"https://github.com/libgit2/libgit2/pull/2432">https:=
//github.com/libgit2/libgit2/pull/2432</a></div><div class=3D"gmail_default=
" style=3D"font-family:&#39;courier new&#39;,monospace">
<br></div><div class=3D"gmail_default" style=3D"font-family:&#39;courier ne=
w&#39;,monospace">Yue Lin Ho=C2=A0</div></div><br></div></div>

<p></p>

-- <br />
-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<=
br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />
<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;msysGit&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:msysgit+unsubscribe@googlegroups.com">msysgit+uns=
ubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--001a11347e3ec19c8d04fc404fdc--

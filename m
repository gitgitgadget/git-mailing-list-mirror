From: =?UTF-8?Q?Magnus_Kallstr=C3=B6m?= <magnus.kallstrom@gmail.com>
Subject: Re: Re: Trailing spaces in branchname (git-svn)
Date: Wed, 22 Jun 2011 00:16:43 +0200
Message-ID: <BANLkTinmmk2KRTBy8rZLhpksK_wqM49_aw@mail.gmail.com>
References: <0014af8a-3b24-4398-88aa-7a3e460f2283@s11g2000yqh.googlegroups.com>
	<AANLkTinZnd0R8Rnv4kaiJAGP0qKEwgbU+nP=donmbEbp@mail.gmail.com>
	<12ada6de-4345-4259-b832-371a74df9775@l6g2000vbn.googlegroups.com>
	<BANLkTikaeXxRMJErAYy3-LSrvfNZXAbEEw@mail.gmail.com>
	<b8767de1-ab2c-4d2a-9024-9ad9b29c614d@j9g2000vbs.googlegroups.com>
	<BANLkTikgF53tKbUsJJznENAiW8Smm5ePPA@mail.gmail.com>
	<58D5F1F8-CC94-4629-B476-91512ED35E0E@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=0016e6dab31ffbad6b04a6403486
Cc: msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: msysgit+bncCK_3npOZGBD9v4TwBBoE1nlRmQ@googlegroups.com Wed Jun 22 00:50:05 2011
Return-path: <msysgit+bncCK_3npOZGBD9v4TwBBoE1nlRmQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCK_3npOZGBD9v4TwBBoE1nlRmQ@googlegroups.com>)
	id 1QZ9lh-0005uG-22
	for gcvm-msysgit@m.gmane.org; Wed, 22 Jun 2011 00:50:01 +0200
Received: by wwf10 with SMTP id 10sf790054wwf.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 21 Jun 2011 15:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:x-beenthere:received-spf:mime-version
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=zlC34U0XWRd1de38kpsV/3FzYMzVGe/agooBDjTqfbY=;
        b=aVYn3nXMvbQTvifPdUIbzAvZXouOICpZ9BqMQmVpRFvl7ODYkmRPSXXvrO7POuwkoq
         7syy69exrsm/s/em2f4Al7MI8YvJO/brATQmnWEwLY3u5KYVfWJLAS7XXdiLx1aSdMa4
         QbEujgY6h1Fc/aAUpo72ovTRZgjIhqDjczUE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        b=6O/Vp8PG1mg+4BoCfCLpZt2EGVw0F9UO/AMeCXwZ3IuczfwHMNMui1y0Wz5A8lfs+X
         XQ+v5pjtm3uc/seEVphVF+VhKvAOd2yYYFiNTNsDZWD8D5k/Hp2161wi8uUenTnQdG8g
         0kwmzZaSowe26zS1ARL55h6xpqklzHEjpXeGI=
Received: by 10.216.68.70 with SMTP id k48mr2912930wed.11.1308696573055;
        Tue, 21 Jun 2011 15:49:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.217.6.11 with SMTP id x11ls2594486wes.3.gmail; Tue, 21 Jun
 2011 15:49:32 -0700 (PDT)
Received: by 10.216.142.13 with SMTP id h13mr127911wej.6.1308696572034;
        Tue, 21 Jun 2011 15:49:32 -0700 (PDT)
Received: by 10.216.254.135 with SMTP id h7mswes;
        Tue, 21 Jun 2011 15:16:44 -0700 (PDT)
Received: by 10.204.144.145 with SMTP id z17mr629633bku.20.1308694604122;
        Tue, 21 Jun 2011 15:16:44 -0700 (PDT)
Received: by 10.204.144.145 with SMTP id z17mr629632bku.20.1308694604092;
        Tue, 21 Jun 2011 15:16:44 -0700 (PDT)
Received: from mail-bw0-f53.google.com (mail-bw0-f53.google.com [209.85.214.53])
        by gmr-mx.google.com with ESMTPS id y18si3677061bkf.2.2011.06.21.15.16.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 15:16:44 -0700 (PDT)
Received-SPF: pass (google.com: domain of magnus.kallstrom@gmail.com designates 209.85.214.53 as permitted sender) client-ip=209.85.214.53;
Received: by bwg12 with SMTP id 12so307650bwg.26
        for <msysgit@googlegroups.com>; Tue, 21 Jun 2011 15:16:44 -0700 (PDT)
Received: by 10.204.84.24 with SMTP id h24mr2857463bkl.185.1308694603869; Tue,
 21 Jun 2011 15:16:43 -0700 (PDT)
Received: by 10.204.35.206 with HTTP; Tue, 21 Jun 2011 15:16:43 -0700 (PDT)
In-Reply-To: <58D5F1F8-CC94-4629-B476-91512ED35E0E@gmail.com>
X-Original-Sender: magnus.kallstrom@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of magnus.kallstrom@gmail.com designates 209.85.214.53 as permitted
 sender) smtp.mail=magnus.kallstrom@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176201>

--0016e6dab31ffbad6b04a6403486
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2011/6/15 Magnus Kallstr=C3=B6m <magnus.kallstrom@gmail.com>

> (I hope I get it right now - previously I used Googles web-interface, and=
 I
> just couldn't find a way to respond to all. Trying from my email client
> instead now... I have even read the 'Welcome post' again :) )
>
> Unfortunately, the patch didn't work.
>
> This is the error I get when it aborts:
> Found branch parent: (refs/remotes/CR3533 s=C3=83=C2=B6kning p=C3=83=C2=
=A5 fakturabelopp )
> be4dd98d152d82f098b90089f4df6a2d411d84e1
> fatal: Unable to create 'd:/Dev/GIT/svk/KOB/.git/svn/refs/remotes/CR3533
> s=C3=B6kning p=C3=A5 fakturabelopp /index.lock': No such file or director=
y
> read-tree be4dd98d152d82f098b90089f4df6a2d411d84e1: command returned erro=
r:
> 128
>
> The patch itself is probably working for other parts, and I even tried a
> similar patch back in March. I never managed to figure out where the call=
 to
> the locking-function got it's path though.
>


Hi again!

I have now successfully cloned "my" repository with the following changes i=
n
git-svn.perl. I'm not sure if the change in "sub refname" is needed, but I
will try to reproduce the error when I find the time for it (the full clone
fails after 2-3 days).

I can't tell if it breaks anything else, but as far as I can tell, the clon=
e
is working.

Does it look as if the modification is done in the right place?

/Magnus

---8<---
diff --git a/git-svn.perl b/git-svn.perl
index 7849cfc..c5e2d23 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2126,6 +2126,9 @@ sub refname {
     # @{ becomes %40{
     $refname =3D~ s{\@\{}{%40\{}g;

+    # trailing space is not not allowed on Windows
+    $refname =3D~ s{ (?=3D/|\\|$)}{%20}g;
+
     return $refname;
 }

@@ -3883,6 +3886,7 @@ sub _new {
     }

     $_[3] =3D $path =3D '' unless (defined $path);
+    $dir =3D~ s{ (?=3D/|\\|$)}{%20}g;
     mkpath([$dir]);
     bless {
         ref_id =3D> $ref_id, dir =3D> $dir, index =3D> "$dir/index",
---8<---

--0016e6dab31ffbad6b04a6403486
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">2011/6/15 Magnus Kallstr=C3=B6m <span dir=3D=
"ltr">&lt;<a href=3D"mailto:magnus.kallstrom@gmail.com">magnus.kallstrom@gm=
ail.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div style=3D"background-color:transparent;margin-top:0px;margin-left:0px;m=
argin-bottom:0px;margin-right:0px"><div>(I hope I get it right now - previo=
usly I used Googles web-interface, and I just couldn&#39;t find a way to re=
spond to all. Trying from my email client instead now... I have even read t=
he &#39;Welcome post&#39; again :) )<div>
<br></div><div>Unfortunately, the patch didn&#39;t work.</div><div><br></di=
v><div>This is the error I get when it aborts:</div><div></div><span style=
=3D"font-size:11pt;font-family:Arial;color:rgb(0, 0, 0);background-color:tr=
ansparent;font-weight:normal;font-style:normal;text-decoration:none;vertica=
l-align:baseline;white-space:pre-wrap">Found branch parent: (refs/remotes/C=
R3533 s=C3=83=C2=B6kning p=C3=83=C2=A5 fakturabelopp ) be4dd98d152d82f098b9=
0089f4df6a2d411d84e1</span><br>
<span style=3D"font-size:11pt;font-family:Arial;color:rgb(0, 0, 0);backgrou=
nd-color:transparent;font-weight:normal;font-style:normal;text-decoration:n=
one;vertical-align:baseline;white-space:pre-wrap">fatal: Unable to create &=
#39;d:/Dev/GIT/svk/KOB/.git/svn/refs/remotes/CR3533 s=C3=B6kning p=C3=A5 fa=
kturabelopp /index.lock&#39;: No such file or directory</span><br>
<span style=3D"font-size:11pt;font-family:Arial;color:rgb(0, 0, 0);backgrou=
nd-color:transparent;font-weight:normal;font-style:normal;text-decoration:n=
one;vertical-align:baseline;white-space:pre-wrap">read-tree be4dd98d152d82f=
098b90089f4df6a2d411d84e1: command returned error: 128</span></div>
<div><span style=3D"font-size:11pt;font-family:Arial;color:rgb(0, 0, 0);bac=
kground-color:transparent;font-weight:normal;font-style:normal;text-decorat=
ion:none;vertical-align:baseline;white-space:pre-wrap"><br></span></div><di=
v>
<span style=3D"font-size:11pt;font-family:Arial;color:rgb(0, 0, 0);backgrou=
nd-color:transparent;font-weight:normal;font-style:normal;text-decoration:n=
one;vertical-align:baseline;white-space:pre-wrap">The patch itself is proba=
bly working for other parts, and I even tried a similar patch back in March=
. I never managed to figure out where the call to the locking-function got =
it&#39;s path though. </span></div>
</div></blockquote></div><br><br clear=3D"all">Hi again!<br><br>I have now =
successfully cloned &quot;my&quot; repository with the following changes in=
 git-svn.perl. I&#39;m not sure if the change in &quot;sub refname&quot; is=
 needed, but I will try to reproduce the error when I find the time for it =
(the full clone fails after 2-3 days).<br>
<br>I can&#39;t tell if it breaks anything else, but as far as I can tell, =
the clone is working.<br><br>Does it look as if the modification is done in=
 the right place?<br><br>/Magnus<br><br><font class=3D"fixed_width" face=3D=
"Courier, Monospaced">---8&lt;--- <br>
</font>diff --git a/git-svn.perl b/git-svn.perl<br>index 7849cfc..c5e2d23 1=
00755<br>--- a/git-svn.perl<br>+++ b/git-svn.perl<br>@@ -2126,6 +2126,9 @@ =
sub refname {<br>=C2=A0=C2=A0=C2=A0=C2=A0 # @{ becomes %40{<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 $refname =3D~ s{\@\{}{%40\{}g;<br>
=C2=A0<br>+=C2=A0=C2=A0=C2=A0 # trailing space is not not allowed on Window=
s<br>+=C2=A0=C2=A0=C2=A0 $refname =3D~ s{ (?=3D/|\\|$)}{%20}g;<br>+<br>=C2=
=A0=C2=A0=C2=A0=C2=A0 return $refname;<br>=C2=A0}<br>=C2=A0<br>@@ -3883,6 +=
3886,7 @@ sub _new {<br>=C2=A0=C2=A0=C2=A0=C2=A0 }<br>=C2=A0<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 $_[3] =3D $path =3D &#39;&#39; unless (defined $path);<br>
+=C2=A0=C2=A0=C2=A0 $dir =3D~ s{ (?=3D/|\\|$)}{%20}g;<br>=C2=A0=C2=A0=C2=A0=
=C2=A0 mkpath([$dir]);<br>=C2=A0=C2=A0=C2=A0=C2=A0 bless {<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ref_id =3D&gt; $ref_id, dir =3D&gt; $dir, i=
ndex =3D&gt; &quot;$dir/index&quot;,<br><font class=3D"fixed_width" face=3D=
"Courier, Monospaced">---8&lt;--- </font><br>


--0016e6dab31ffbad6b04a6403486--

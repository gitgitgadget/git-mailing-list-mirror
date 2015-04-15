From: Vitaly <vitalyster@gmail.com>
Subject: Re: Re: Sneak peek of the upcoming Git for Windows 2.x
Date: Wed, 15 Apr 2015 05:22:10 -0700 (PDT)
Message-ID: <3fc0da8d-a00b-4a92-a1af-aa825063f712@googlegroups.com>
References: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
 <00ecdadf-8bcb-4ade-a2fd-46d866a66be8@googlegroups.com>
 <0a22af8a5207eb8f888b65c6bad3e888@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_321_70484878.1429100530929"
Cc: vitalyster@gmail.com, git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBC34VAHX6MORB45PXGUQKGQEPPGJKMQ@googlegroups.com Wed Apr 15 14:22:15 2015
Return-path: <msysgit+bncBC34VAHX6MORB45PXGUQKGQEPPGJKMQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qk0-f190.google.com ([209.85.220.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC34VAHX6MORB45PXGUQKGQEPPGJKMQ@googlegroups.com>)
	id 1YiMKa-00065Q-Ve
	for gcvm-msysgit@m.gmane.org; Wed, 15 Apr 2015 14:22:13 +0200
Received: by qkbw1 with SMTP id w1sf61051342qkb.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 15 Apr 2015 05:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=Tz/2MVYgq7939lWfxVhJNGF2mt7OPuw57C15uV8TRp0=;
        b=gSFIr579O8IcMhGICGFPnW9kdGixWRL8GiqC5glsSLg400QKCWi8YVn07HlCDdTfW3
         0EBjCQATlAnchAG89i2mcNK1BKzwytYNffp+f1KQr6O588jDbi7ldkOyC6kjsOcxtEf1
         k6SqZwezqD7U1xMlRNhY5pHNiec5R3lLXuIIfFIuNwPrEsIm2kKmt5MWpUteAV/VIvPj
         zEM7W2DKWFGAYUi8S/2qWDQp+lF/7x2gi5K4b+mGBR/2BdeYhFgihvct4Xl4VzJNqJTu
         wh1+k9DmrpGVdA2T5+3idmLSF7ca/JNrP9z+XxpfDkTxgrsk/1Esyk0Ppvav/tbonSWE
         jJcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=Tz/2MVYgq7939lWfxVhJNGF2mt7OPuw57C15uV8TRp0=;
        b=oEHyV1cMQsZHtCSDsod+I7M4ncvZc5vwkEVP7hUExWgk6kMVO21W3matMFerGd4uJw
         /3ESdBcTagRC8jyhnO7O9wUk9SGICRpvagovZiNpBHZWmdrg0cstuhKZtFrdU2nekzkP
         22mY/Z45bnUJsktj0cCzjc/oUj+1rOYvSW+HLTHPEJEX72VGRcigKf3UdSxXbJAJVQsN
         64D2rA7QWorDQH9aQdOqee8QNkJEXI61+Q0zWCv4LsA3JQazrTDSI8cIQqskBdNs0Zbm
         SYPKZGof8pTdnXn0LlfurVWWBmjmaGLWdBeoy9IbBmxEfU2GzSj3ISbjkGF/sYdaRkIt
         aaYg==
X-Received: by 10.140.89.168 with SMTP id v37mr315600qgd.7.1429100531811;
        Wed, 15 Apr 2015 05:22:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.27.138 with SMTP id 10ls601243qgx.47.gmail; Wed, 15 Apr
 2015 05:22:11 -0700 (PDT)
X-Received: by 10.140.36.232 with SMTP id p95mr221675qgp.17.1429100531372;
        Wed, 15 Apr 2015 05:22:11 -0700 (PDT)
In-Reply-To: <0a22af8a5207eb8f888b65c6bad3e888@www.dscho.org>
X-Original-Sender: vitalyster@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267196>

------=_Part_321_70484878.1429100530929
Content-Type: multipart/alternative; 
	boundary="----=_Part_322_1375855049.1429100530929"

------=_Part_322_1375855049.1429100530929
Content-Type: text/plain; charset=UTF-8


>
> > C:\>git 
> > error launching git:      .
>

I have found the root of problem in broken git-wrapper: old git-wrapper in 
msysgit repository uses case-insensitive path comparison after calling 
GetModuleFileName (in my case there is "git.EXE"). This is my dummy fix: 
https://github.com/vitalyster/git/commit/c1904dbee2aab59b5dc213960dfb2481c8d7a1bf 

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

------=_Part_322_1375855049.1429100530929
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><blockquote class=3D"gmail_quote" style=3D"margin: 0;margi=
n-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">&gt; C:\&gt;g=
it
<br>&gt; error launching git: &nbsp; &nbsp; &nbsp;.<br></blockquote><div><b=
r></div><div>I have found the root of problem in broken git-wrapper: old gi=
t-wrapper in msysgit repository uses case-insensitive path comparison after=
 calling GetModuleFileName (in my case there is "git.EXE"). This is my dumm=
y fix: https://github.com/vitalyster/git/commit/c1904dbee2aab59b5dc213960df=
b2481c8d7a1bf&nbsp;</div></div>

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
quot;Git for Windows&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:msysgit+unsubscribe@googlegroups.com">msysgit+uns=
ubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_322_1375855049.1429100530929--
------=_Part_321_70484878.1429100530929--

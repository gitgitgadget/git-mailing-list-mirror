From: =?UTF-8?B?QnJhbmtvIMSMaWJlag==?= <brane@wandisco.com>
Subject: Re: git-svn "Temp file with moniker 'svn_delta' already in use" and
 skelta mode
Date: Sat, 06 Jul 2013 06:23:57 +0200
Organization: WANdisco
Message-ID: <51D79BDD.5020106@wandisco.com>
References: <kr6uvc$p8a$1@ger.gmane.org> <51D7072A.6080909@wandisco.com> <kr75h0$qg5$1@ger.gmane.org> <51D7362B.1040803@wandisco.com> <kr7il5$n0p$1@ger.gmane.org> <51D7660F.6070901@wandisco.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------080303090603040508080505"
Cc: git@vger.kernel.org
To: users@subversion.apache.org
X-From: users-return-18597-gcvsu-users=m.gmane.org@subversion.apache.org Sat Jul 06 06:24:34 2013
Return-path: <users-return-18597-gcvsu-users=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsu-users@plane.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by plane.gmane.org with smtp (Exim 4.69)
	(envelope-from <users-return-18597-gcvsu-users=m.gmane.org@subversion.apache.org>)
	id 1UvK2z-0000vx-Qd
	for gcvsu-users@plane.gmane.org; Sat, 06 Jul 2013 06:24:34 +0200
Received: (qmail 19274 invoked by uid 500); 6 Jul 2013 04:24:29 -0000
Mailing-List: contact users-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:users-help@subversion.apache.org>
List-Unsubscribe: <mailto:users-unsubscribe@subversion.apache.org>
List-Post: <mailto:users@subversion.apache.org>
List-Id: <users.subversion.apache.org>
Delivered-To: mailing list users@subversion.apache.org
Received: (qmail 19261 invoked by uid 99); 6 Jul 2013 04:24:26 -0000
Received: from athena.apache.org (HELO athena.apache.org) (140.211.11.136)
    by apache.org (qpsmtpd/0.29) with ESMTP; Sat, 06 Jul 2013 04:24:26 +0000
X-ASF-Spam-Status: No, hits=1.5 required=5.0
	tests=HTML_MESSAGE,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (athena.apache.org: domain of brane@wandisco.com designates 209.85.215.172 as permitted sender)
Received: from [209.85.215.172] (HELO mail-ea0-f172.google.com) (209.85.215.172)
    by apache.org (qpsmtpd/0.29) with ESMTP; Sat, 06 Jul 2013 04:24:21 +0000
Received: by mail-ea0-f172.google.com with SMTP id q10so1830477eaj.3
        for <users@subversion.apache.org>; Fri, 05 Jul 2013 21:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type:x-gm-message-state;
        bh=kDz1lpJgV/rxAE9kEJ6hTCmh2sqZPEonppr8tAwU74w=;
        b=pUV3I6jnBd4Xg4D1x7kq1jm49rcQo0reLfPFDLsDxspvPfj79793ugAGgDrvcrLd6s
         YXvz1srWUnkESoLj3S022DSeqUMvzDhB632wpNZicSJNLPmHY8r5dQ9zK47k1wsZB2Zt
         f+S4a6tgyl/dOljUENWfqfYbhrJiDD5NrfFBnZCBhj0BvQtykoDe/FxeK75IQIDLYm95
         XFhPRRkig9jpzr0L8wCvP/MzsF1tEsdtb7xNarYaLlF/CDQyafyubYu70rrcvj9kJ5H/
         CO48zZz04G1meAi8T3RL6XYFB6BvM8KUQOA3i6D8Zd322Ygv0GYfFtPWmMIJlMrNsaC5
         WFjQ==
X-Received: by 10.15.23.194 with SMTP id h42mr14572537eeu.123.1373084639635;
        Fri, 05 Jul 2013 21:23:59 -0700 (PDT)
Received: from zulu.local (cpe-46-164-15-215.dynamic.amis.net. [46.164.15.215])
        by mx.google.com with ESMTPSA id o5sm19811577eef.5.2013.07.05.21.23.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 21:23:59 -0700 (PDT)
Received: from zulu.local (localhost [IPv6:::1])
	by zulu.local (Postfix) with ESMTP id 7A6307462E0D;
	Sat,  6 Jul 2013 06:23:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51D7660F.6070901@wandisco.com>
X-Gm-Message-State: ALoCoQkidxhRp3Q/7zuHMzXw2n1MKA1uCknhkZ0et5kZV9QdmhISjd+Tz6XygqBad5p/v/++cOGY
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229694>

This is a multi-part message in MIME format.
--------------080303090603040508080505
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06.07.2013 02:34, Branko Čibej wrote:
> In the meantime, it might be a good idea to relax the restrictions in
> git-svn to account for the way the HTTPv2 protocol works.

By the way, this section of the 1.8 release notes is relevant:

http://subversion.apache.org/docs/release-notes/1.8.html#neon-deleted

In 1.8 there is a client-side configuration option called
http-bulk-updates that controls how the client will request data from
the server. It can be set in the ~/.subversion/servers file, or on the
comand-line by the option

    --config-option=servers:global:http-bulk-updates=on

or, of course, in the client API context. git-svn should probably do the
latter as a simple workaround.

-- Brane

-- 
Branko Čibej | Director of Subversion
WANdisco // Non-Stop Data
e. brane@wandisco.com

--------------080303090603040508080505
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 06.07.2013 02:34, Branko Čibej
      wrote:<br>
    </div>
    <blockquote cite="mid:51D7660F.6070901@wandisco.com" type="cite">
      <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
      In the meantime, it might be a good idea to relax the restrictions
      in git-svn to account for the way the HTTPv2 protocol works.<br>
    </blockquote>
    <br>
    By the way, this section of the 1.8 release notes is relevant:<br>
    <br>
<a class="moz-txt-link-freetext" href="http://subversion.apache.org/docs/release-notes/1.8.html#neon-deleted">http://subversion.apache.org/docs/release-notes/1.8.html#neon-deleted</a><br>
    <br>
    In 1.8 there is a client-side configuration option called
    http-bulk-updates that controls how the client will request data
    from the server. It can be set in the ~/.subversion/servers file, or
    on the comand-line by the option<br>
    <pre>    --config-option=servers:global:http-bulk-updates=on
</pre>
    or, of course, in the client API context. git-svn should probably do
    the latter as a simple workaround.<br>
    <br>
    -- Brane<br>
    <br>
    <div class="moz-signature">-- <br>
      <span style="font-face:sans-serif;font-size:9pt;line-height:18pt">Branko
        Čibej <span style="color: #f90">|</span> <span
          style="font-weight:bold">Director of Subversion</span>
        <br>
        WANdisco <span style="color: #f90">//</span> <span
          style="font-style:oblique">Non-Stop Data</span>
        <br>
        <span style="color: #ccc">e.</span> <a class="moz-txt-link-abbreviated" href="mailto:brane@wandisco.com">brane@wandisco.com</a></span></div>
  </body>
</html>

--------------080303090603040508080505--

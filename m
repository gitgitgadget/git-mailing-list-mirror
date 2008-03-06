From: "Jim Raden" <james.raden@gmail.com>
Subject: Re: The 8th airing of the msysGit herald
Date: Wed, 5 Mar 2008 21:42:29 -0500
Message-ID: <5fc54b450803051842p4163df5do995f82eb17b3c5ca@mail.gmail.com>
References: <alpine.LSU.1.00.0803022329560.22527@racer.site> <7vablfiv42.fsf@gitster.siamese.dyndns.org> <47CC432B.8060502@imap.cc> <7v1w6rh1ru.fsf@gitster.siamese.dyndns.org> <46a038f90803031458t2b404212t10f6e9ae710dc408@mail.gmail.com> <47CF2F61.5060208@imap.cc> <alpine.LSU.1.00.0803060121360.15786@racer.site> <7vskz4heeg.fsf@gitster.siamese.dyndns.org> <5fc54b450803051803t4dda4341ue3ac403c742f1903@mail.gmail.com> <alpine.LSU.1.00.0803060327050.15786@racer.site>
Reply-To: james.raden@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Tilman Schmidt" <tilman@imap.cc>,  "Martin Langhoff" <martin.langhoff@gmail.com>,  "Jakub Narebski" <jnareb@gmail.com>, msysgit@googlegroups.com,  git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Mar 06 03:43:10 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX64b-0004xk-4R
	for gcvm-msysgit@m.gmane.org; Thu, 06 Mar 2008 03:43:09 +0100
Received: by ug-out-1516.google.com with SMTP id 1so3180221uga.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 05 Mar 2008 18:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=rbKflDo5Ysf+Jd9eWmGtDt1tSNEsDLUAcPj4dbp3rgA=;
        b=qfoSL6tkr2tcU2o7QQtRic5m29R3Kobah9bKl3iKYf++LGVfdImgDD+79z19/MDtQfuB6ds4h8KGX8wp5FUF+edfLP0LLjziPqbtEkauLdKGZAtDf5UzlvYyJcEV2IJXWPZSTPOq7Qvi4x5jBJaokygTrYMyyZWiaTW171MdR/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=XAruuEv+tFVZy5as9/BwVO0x8blhqb2Mlhjc7bQVVMMF9STPzZf9lyHdNFyb/Z2igw5XMdAV56fobGA879hg3sufEjB5MSP9Cp1hTFW+O4y5fBx7gg5MDF8evoRzxnUUFQk4Vsu7BBS3xjg8QTsaMBOyyCbNKM5wHsuXaIZM+FY=
Received: by 10.142.254.8 with SMTP id b8mr78539wfi.29.1204771351495;
        Wed, 05 Mar 2008 18:42:31 -0800 (PST)
Received: by 10.106.177.2 with SMTP id z2gr1921pre.0;
	Wed, 05 Mar 2008 18:42:31 -0800 (PST)
X-Sender: james.raden@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.27.20 with SMTP id a20mr1657168waa.23.1204771350922; Wed, 05 Mar 2008 18:42:30 -0800 (PST)
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.190]) by mx.google.com with ESMTP id k36si5023018waf.1.2008.03.05.18.42.30; Wed, 05 Mar 2008 18:42:30 -0800 (PST)
Received-SPF: pass (google.com: domain of james.raden@gmail.com designates 64.233.170.190 as permitted sender) client-ip=64.233.170.190;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of james.raden@gmail.com designates 64.233.170.190 as permitted sender) smtp.mail=james.raden@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by rn-out-0910.google.com with SMTP id e21so834006rng.6 for <msysgit@googlegroups.com>; Wed, 05 Mar 2008 18:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; bh=RHqZlWf61MFkqYt9kiwXlZ6ORvjIeFS2SzUVidSSJ1I=; b=tEqSMsqjILhYJbwm9J96j/lRhXjuZLakQTUQLYR7ICsQNYI48/hCweN/7+TcRkC4GEvqPogmZh3TMzbYN2HcQ1cA1aNQdyCuy3yBDil5yBaNBTs50UzdpTtPKcx2BLeFtMAeyGXrTiNMWWl+ZJO/hWC7xF7qMtwA9DEsBQcDKz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; b=pXww2BbELkN+30A0KqFPeRYjGo+ENQvxa3yFThGzMQwQ8rRYGL7UaJt9lIO60sDjHleMGNHXmNkKM2k1Y7H9aqmjS6WRdpRDyCUJKUaNQEGxHaMez0EiEZAxC34my34pH3i1OjIzjw5y8mEsIwxkbnUigVNjwj3/GnCrNcwW9J0=
Received: by 10.114.14.1 with SMTP id 1mr5942562wan.9.1204771349906; Wed, 05 Mar 2008 18:42:29 -0800 (PST)
Received: by 10.114.198.3 with HTTP; Wed, 5 Mar 2008 18:42:29 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0803060327050.15786@racer.site>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76314>


Msysgit has apparently 60 members, at least according to
http://groups.google.com/group/msysgit. It was that number to which I
was referring.

I saw that this message was cross-posted to git@vger.kernel.org, which
no doubt has many, many more than 60. Perhaps this is where the 853
figure comes from?

On Wed, Mar 5, 2008 at 9:29 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Wed, 5 Mar 2008, Jim Raden wrote:
>
>  > Perhaps adopting a convention for the subject line, like "Usage
>  > question: xxxxxxxxxxxxxxxxxxxxx"? We're still a small list, so it
>  > wouldn't be horribly cumbersome.
>
>  I fail to see how that would accomplish something different from two
>  mailing list, except the very likely chance that people are unaware of
>  that convention.

You're right, many people probably *would* be unaware of the
convention on anything other than a small list, i.e. 60 members.  ;)

If the list were bigger, say for instance 853, the solution I proposed
would be too cumbersome.

>
>  Recently Shawn mentioned that there are 853 members.

Those 853 members are on msysgit or git@vger.kernel.org?

>
>  Don't get me wrong, I'd _love_ to see a proper solution to the problem,
>  alas, I do not see one yet.
>
>  Ciao,
>  Dscho
>
>

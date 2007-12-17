From: "Marco Costalba" <mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Windows binaries for qgit 2.0
Date: Mon, 17 Dec 2007 20:17:32 +0100
Message-ID: <e5bfff550712171117ka671594t7c35e8a3d2aeefe9@mail.gmail.com>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com> <fk2p0f$961$1@ger.gmane.org> <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com> <fk2q1f$bbh$1@ger.gmane.org> <e5bfff550712160242v54ce284emd31a29964770179c@mail.gmail.com> <fk3153$rtb$1@ger.gmane.org> <e5bfff550712161426y101c77efl4f5321d3440fed3f@mail.gmail.com> <fk5grp$7il$2@ger.gmane.org> <e5bfff550712171105k62b90853w1c5eed64bd11fb23@mail.gmail.com> <Pine.LNX.4.64.0712171911070.9446@racer.site>
Reply-To: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Abdelrazak Younes" <younes.a-GANU6spQydw@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,  msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: "Johannes Schindelin" <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Dec 17 20:20:00 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.160])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4LTQ-0000DV-Lq
	for gcvm-msysgit@m.gmane.org; Mon, 17 Dec 2007 20:17:56 +0100
Received: by ug-out-1516.google.com with SMTP id 1so86210uga.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Dec 2007 11:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=ihBM8RU+owFpQqqByesz9MyiNG8z0x/PZs8EBak3s/A=;
        b=p7V+RNEssQktqtrl9PV7GoNFyeEsfnxfbArfENvHhOc1GeTTknDzCCf1NbVZ357JporA9ecfaZ9+gjiXUwSxETbeKL//ECQC8pc757sWM/iKQPFAuiwKsc035cbGQOq5PSksUuoS9xv13v2Jc8taVTY6Hf9PJ6unEw6gAjsdRy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=bdAoA66wcBkYHd3AWt+SdUDlVsT8/l5+kaQB+xtdeLCDVfY6rUIEyf1v1243CIxQ97yy2Hb1y8WMIw+l8XlWZNNukYljolYbcREGKXo9w9nQ3sPZEIhl2JXzsr+NtVDkpowh9BPvu/SgUfYKXfO7arZD01B0bWDC0jq/Dh6E5OU=
Received: by 10.86.70.8 with SMTP id s8mr135701fga.19.1197919054441;
        Mon, 17 Dec 2007 11:17:34 -0800 (PST)
Received: by 10.107.115.27 with SMTP id s27gr1260prm;
	Mon, 17 Dec 2007 11:17:34 -0800 (PST)
X-Sender: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.192.1 with SMTP id p1mr2584566waf.14.1197919053135; Mon, 17 Dec 2007 11:17:33 -0800 (PST)
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187]) by mx.google.com with ESMTP id k36si6180099waf.2007.12.17.11.17.32; Mon, 17 Dec 2007 11:17:33 -0800 (PST)
Received-SPF: pass (google.com: domain of mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.187 as permitted sender) client-ip=209.85.198.187;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.187 as permitted sender) smtp.mail=mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by rv-out-0910.google.com with SMTP id c27so2039899rvf.8 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Mon, 17 Dec 2007 11:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; bh=YXRw1AChrXvwP7TiPmRzIrEI6QaVfJagU7EID4XlwHU=; b=suSziE0l46wnAWXAcUU1DVdH6BEGFIL/SioIlAvqboYy1zxXZjHXm/fn5vG8cYF0D38vVM40uEJeiuGJqpDvIedsywQ7C120e5ty3BfUO2+zPgiv1IRPkLrKxWDOyHcDIdAuDEPkU8ftvncYyMeyI9B4SXwjjn9S6C413PiESjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; b=WzJsItnXfzP8QTTcAEAX4uwXPIcnBlMjvc8/frC3YzMGyd+zoiWcBe2X7CkmumSTyeBbAul9mdPqH4oMFYZRcUmai4adN1AceYLZcCQlfZl8KxEZT7ZU2y+2WbXvxfPV2jUYCMhU/AYyq4nFp76Z3cVac/djmZ3YcSdjHRJVlhk=
Received: by 10.140.144.4 with SMTP id r4mr1548726rvd.15.1197919052071; Mon, 17 Dec 2007 11:17:32 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Mon, 17 Dec 2007 11:17:32 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712171911070.9446-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
Content-Disposition: inline
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68605>


On Dec 17, 2007 8:13 PM, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org> wrote:
>
> It is generally a good idea to provide the server-info for dumb protocols,
> because not everybody is fortunate enough (like you, evidently, because
> you do not seem to care all that much...) to control her outbound firewall
> restrictions.
>

I have taken note of Peter suggestion's to do a

chmod +x foo.git/hooks/post-update

on kernel repository, I don't remember if I have already done it many
months ago, but I'm planning to redo for safety as soon as I reach my
development box.

Thanks
Marco

From: "Marco Costalba" <mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Windows binaries for qgit 2.0
Date: Mon, 17 Dec 2007 20:05:04 +0100
Message-ID: <e5bfff550712171105k62b90853w1c5eed64bd11fb23@mail.gmail.com>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com> <fk2juf$t25$1@ger.gmane.org> <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com> <fk2p0f$961$1@ger.gmane.org> <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com> <fk2q1f$bbh$1@ger.gmane.org> <e5bfff550712160242v54ce284emd31a29964770179c@mail.gmail.com> <fk3153$rtb$1@ger.gmane.org> <e5bfff550712161426y101c77efl4f5321d3440fed3f@mail.gmail.com> <fk5grp$7il$2@ger.gmane.org>
Reply-To: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: "Abdelrazak Younes" <younes.a-GANU6spQydw@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Dec 17 20:07:38 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from nz-out-0708.google.com ([64.233.162.248])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4LHP-0001oT-1l
	for gcvm-msysgit@m.gmane.org; Mon, 17 Dec 2007 20:05:46 +0100
Received: by nz-out-0708.google.com with SMTP id v22so104646nzg.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Dec 2007 11:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=kwBHDNW0+Brenr2jhHkZ40qUC4iZJmX+GZ8IRsYHF00=;
        b=WcMJNNczKjSw7/6IPIEozY5M4SxRpRWBkS4MZYh+amFfH0b7rV2Zo5QK1+Fm1237C8/SiSoYLuH4mRl6iKL2hJX9YD49R+QR/ZdXUTR0goZ8q/gO+J9wJH11rTaEubESOXyexvfAk+yQA1guaJ949iS6n1EtGNxCs7UJwPIoiw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=vz3bDZb2DjKDY+WK5Lfeo2lkwuZQM2RgdWk8NnxsN4YKAAOKJ4grE9yA8xMLHxQhlRViSPJS1U74ki/HwL2dWfI+EoM7lVgJ4BP5+kCNkJqnkx1tud6DimMvBwuwbwM6pt76ISaI9AhR//RsWf1STEhux4lBUcowghstzq/2dcY=
Received: by 10.143.122.7 with SMTP id z7mr223544wfm.6.1197918306267;
        Mon, 17 Dec 2007 11:05:06 -0800 (PST)
Received: by 10.107.100.4 with SMTP id c4gr1257prm;
	Mon, 17 Dec 2007 11:05:06 -0800 (PST)
X-Sender: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.13.4 with SMTP id q4mr12733553pyi.7.1197918306027; Mon, 17 Dec 2007 11:05:06 -0800 (PST)
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.234]) by mx.google.com with ESMTP id x46si14364909pyg.2007.12.17.11.05.05; Mon, 17 Dec 2007 11:05:06 -0800 (PST)
Received-SPF: pass (google.com: domain of mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 64.233.162.234 as permitted sender) client-ip=64.233.162.234;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 64.233.162.234 as permitted sender) smtp.mail=mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by nz-out-0506.google.com with SMTP id m7so1166995nzf.29 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Mon, 17 Dec 2007 11:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; bh=hCHvfHkmH4LHR2xf/RMPGs70LyLvJ8a/pG0BKBxhyQ0=; b=WGyG+V32UqIXvZyzXyfRE2eZEN/QlM5ySa8pROi05m2ogDmiUAH2bUJdCc4absRNthFxvx3XXeEJR7gWrVTscvS1Vt1o+n0yeeP1uZJkPh3CBqU2rerxvtrfQPdZHrnWx7vC/Am/ZSPxLB95HbTMcRTPzyfETT8nlQ4xLm7G0Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; b=QJ9IuVaNSS9MaH+7DnMmoa8Lh+p1ZKo+oIttG84FAe6DSyosatY5NHNygcnytDETDQFxMe+kKhSY3SungKWWh/xwCU3Ub93nseUv5Wio5I6/dcn4lSwUkRCKT+8s6HrLaHEqQ/eVaA6yTN8x4N+lPblZ1XF2/yKTjOpfHYgaSho=
Received: by 10.141.14.14 with SMTP id r14mr4223867rvi.63.1197918304694; Mon, 17 Dec 2007 11:05:04 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Mon, 17 Dec 2007 11:05:04 -0800 (PST)
In-Reply-To: <fk5grp$7il$2@ger.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68601>


On Dec 17, 2007 10:51 AM, Abdelrazak Younes <younes.a-GANU6spQydw@public.gmane.org> wrote:
>
> I would like to help you with that but I can't retrieve the repository:
>
> $ git clone git://git.kernel.org/pub/scm/qgit/qgit4.git qgit4.git
> Initialized empty Git repository in d:/devel/git/qgit4/qgit4.git/.git/
> git.kernel.org[0: 130.239.17.7]: errno=Invalid argument
> git.kernel.org[1: 199.6.1.166]: errno=Bad file descriptor
> git.kernel.org[2: 204.152.191.8]: errno=Bad file descriptor
> git.kernel.org[3: 204.152.191.40]: errno=Bad file descriptor
> fatal: unable to connect a socket (Bad file descriptor)
> fetch-pack from 'git://git.kernel.org/pub/scm/qgit/qgit4.git' failed.
>

This is very strange, I can clone without problems...someone has ideas?


> $ git clone http://git.kernel.org/pub/scm/qgit/qgit4.git qgit4.git
> Initialized empty Git repository in d:/devel/git/qgit4/qgit4.git/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?
>

Well, perhaps, but to clone with git protocol you don't need that.


Marco

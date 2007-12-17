From: Abdelrazak Younes <younes.a-GANU6spQydw@public.gmane.org>
Subject: Re: Windows binaries for qgit 2.0
Date: Mon, 17 Dec 2007 22:20:31 +0100
Message-ID: <4766E81F.1030808@free.fr>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>	 <fk2juf$t25$1@ger.gmane.org>	 <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>	 <fk2p0f$961$1@ger.gmane.org>	 <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>	 <fk2q1f$bbh$1@ger.gmane.org>	 <e5bfff550712160242v54ce284emd31a29964770179c@mail.gmail.com>	 <fk3153$rtb$1@ger.gmane.org>	 <e5bfff550712161426y101c77efl4f5321d3440fed3f@mail.gmail.com>	 <fk5grp$7il$2@ger.gmane.org> <e5bfff550712171105k62b90853w1c5eed64bd11fb23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Marco Costalba <mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Dec 17 22:21:12 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4NOU-0007Gv-2l
	for gcvm-msysgit@m.gmane.org; Mon, 17 Dec 2007 22:20:58 +0100
Received: by ug-out-1516.google.com with SMTP id 1so204800uga.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Dec 2007 13:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=sxJx4x28N4KPNWK1Zumc60DYwUe12DI74mwRakpu4Ic=;
        b=hjnGQPB08vXcvFdq1fN0E6Mgp83GusfCb7rxdyZ9pn/zbRDUMS2KdzH9WjfyaO4oYztS7b+HeWcDP2bg9aBVP5wUtZB6+naFUbACQyd0LjAjz151452Nb/XkuTpi9oPwWFqBlAWp8SypSWabdu0eRrLinRc465bCdweT2ZwKvCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=BP89cf8rqcTZyf8G2rpXTUJacH6aLADRif2RfKzHFdWW/Dj8s0+bZeUZGon4RGR6U7g1VVypmAEzZUJiDPwVOFtLfCLGTguriamEPVDhYVxbE5Q4k+0IN3HxB0K5o8V+hYgiJisvAERZqGsxqwyYXyVZk2VRr7BVUGlggqlbJAM=
Received: by 10.141.68.12 with SMTP id v12mr231535rvk.11.1197926434587;
        Mon, 17 Dec 2007 13:20:34 -0800 (PST)
Received: by 10.107.94.14 with SMTP id w14gr1261prl;
	Mon, 17 Dec 2007 13:20:34 -0800 (PST)
X-Sender: younes.a-GANU6spQydw@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.13.4 with SMTP id q4mr12988424pyi.7.1197926434465; Mon, 17 Dec 2007 13:20:34 -0800 (PST)
Received: from smtp1-g19.free.fr (smtp1-g19.free.fr [212.27.42.27]) by mx.google.com with ESMTP id a28si60961837pye.2007.12.17.13.20.34; Mon, 17 Dec 2007 13:20:34 -0800 (PST)
Received-SPF: pass (google.com: domain of younes.a-GANU6spQydw@public.gmane.org designates 212.27.42.27 as permitted sender) client-ip=212.27.42.27;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of younes.a-GANU6spQydw@public.gmane.org designates 212.27.42.27 as permitted sender) smtp.mail=younes.a-GANU6spQydw@public.gmane.org
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1]) by smtp1-g19.free.fr (Postfix) with ESMTP id AB4421AB2EA; Mon, 17 Dec 2007 22:20:33 +0100 (CET)
Received: from [192.168.0.1] (gre92-5-82-237-199-162.fbx.proxad.net [82.237.199.162]) by smtp1-g19.free.fr (Postfix) with ESMTP id 59B7B1AB2BE; Mon, 17 Dec 2007 22:20:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <e5bfff550712171105k62b90853w1c5eed64bd11fb23-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68624>


Marco Costalba wrote:
> On Dec 17, 2007 10:51 AM, Abdelrazak Younes <younes.a-GANU6spQydw@public.gmane.org> wrote:
>   
>> $ git clone http://git.kernel.org/pub/scm/qgit/qgit4.git qgit4.git
>> Initialized empty Git repository in d:/devel/git/qgit4/qgit4.git/.git/
>> Cannot get remote repository information.
>> Perhaps git-update-server-info needs to be run there?
>>
>>     
>
> Well, perhaps, but to clone with git protocol you don't need that.
>   
Just for clarification, this is not my question, this is git asking.

Abdel.

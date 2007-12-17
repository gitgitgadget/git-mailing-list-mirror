From: Abdelrazak Younes <younes.a-GANU6spQydw@public.gmane.org>
Subject: Re: Failed to clone http://repo.or.cz/w/msysgit.git
Date: Mon, 17 Dec 2007 18:40:04 +0100
Message-ID: <4766B474.1060302@free.fr>
References: <fk5sde$crq$1@ger.gmane.org> <Pine.LNX.4.64.0712171330540.9446@racer.site> <fk5u4d$j9b$1@ger.gmane.org> <Pine.LNX.4.64.0712171702360.9446@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Dec 17 18:41:54 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from nz-out-0708.google.com ([64.233.162.242])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Jxw-0007F0-O8
	for gcvm-msysgit@m.gmane.org; Mon, 17 Dec 2007 18:41:21 +0100
Received: by nz-out-0708.google.com with SMTP id v22so824502nzg.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Dec 2007 09:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:content-transfer-encoding:x-complaints-to:x-gmane-nntp-posting-host:user-agent:in-reply-to:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=yXZX8r2TUbt5evVvpqoBW8/TqY2b0k7GGZ1EFbUVp3Q=;
        b=XUDWrPf//t5TOtlujmXxXUmALYTdz4W0bO60mudjmNwUGbs6V3slexuRkvx5CICXYFL5/r71Ti9w4z9omG5dg2s5TGvTA6pCkUSYS0yQ6PdnkMIBKu3Mi66vyDb1zxTrFXLFoGfoB8ymyPEKYbgLDVSFYyUMK9NXrBhsLZiLiYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:content-transfer-encoding:x-complaints-to:x-gmane-nntp-posting-host:user-agent:in-reply-to:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=2qpoFSzMIH5Hz6OQ8pSgTZLupklp0HlXX/FD3SldFIA5iPII3nUa1CVOGxJ5DjrHmKkPH8l6u9uSgLsfClV2IOIEIpQd/19MH16yU/5m7iGfQDrS2P1EBYmfHJhggUj1DNC3bpgDu+5MhImPtBrzLhMVvKUiuw19409T54Xv1HE=
Received: by 10.142.172.12 with SMTP id u12mr220637wfe.19.1197913253637;
        Mon, 17 Dec 2007 09:40:53 -0800 (PST)
Received: by 10.107.114.37 with SMTP id r37gr1256prm;
	Mon, 17 Dec 2007 09:40:53 -0800 (PST)
X-Sender: gcvm-msysgit@m.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.66.2 with SMTP id o2mr2517272waa.18.1197913250635; Mon, 17 Dec 2007 09:40:50 -0800 (PST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2]) by mx.google.com with ESMTP id h71si19251884nzf.2007.12.17.09.40.48; Mon, 17 Dec 2007 09:40:50 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) client-ip=80.91.229.2;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org
Received: from list by ciao.gmane.org with local (Exim 4.43) id 1J4Jx5-0004zL-1V for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Mon, 17 Dec 2007 17:40:27 +0000
Received: from matrix-eth-s4p3c0.eurocontrol.fr ([192.93.23.254]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Mon, 17 Dec 2007 17:40:27 +0000
Received: from younes.a by matrix-eth-s4p3c0.eurocontrol.fr with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Mon, 17 Dec 2007 17:40:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet-dbVV3NMTNubNLxjTenLetw@public.gmane.org
X-Gmane-NNTP-Posting-Host: matrix-eth-s4p3c0.eurocontrol.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <Pine.LNX.4.64.0712171702360.9446-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68583>


Johannes Schindelin wrote:
> Hi,
> 
> [please do not cull me from the Cc: list when you reply to me.  This is 
>  like replying to me, but talking away from me (to the public).]

Sorry, I am afraid I cannot do that right now because I use the gmane 
news interface and I don't have access to my smtp from here. If it is 
too irritating I'll wait up until I go back home before I answer. In any 
case, sorry for the inconvenience.

> 
> On Mon, 17 Dec 2007, Abdelrazak Younes wrote:
> 
>> Johannes Schindelin wrote:
>>> On Mon, 17 Dec 2007, Abdelrazak Younes wrote:
>>>
>>>> I am trying to clone the msysgit repository but I get this error:
>>>>
>>>> $ git clone http://repo.or.cz/w/msysgit.git
>>>> Initialized empty Git repository in d:/devel/git/msysgit/.git/
>>>> D:/program/Git/bin/git-clone: line 144: /bin/git-http-fetch: Bad file
>>>> number
> 
> Okay, I get the same error here.  Fishy.  But then, this is not the 
> correct URL either (so I think Peff's patch probably fixes it).
> 
> What you tried is the gitweb URL, which explicitely says
> 
> 	Mirror URL	git://repo.or.cz/msysgit.git
> 
> 			http://repo.or.cz/r/msysgit.git
> 
> IOW replace your "/w/" by "/r/" and have fun,

Yes, it works! Thanks and sorry for the mixup, I just copied and pasted 
the link without thinking.

Abdel.

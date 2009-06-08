From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git for Windows 1.6.3.2
Date: Mon, 8 Jun 2009 12:58:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906081255530.4461@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de>  <26984.77.61.241.211.1244457815.squirrel@hupie.xs4all.nl> <fabb9a1e0906080351hbfe7ab7w2016a030ef1bde7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>, msysgit@googlegroups.com,  git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Jun 08 12:58:19 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDcYR-0003pe-DW
	for gcvm-msysgit@m.gmane.org; Mon, 08 Jun 2009 12:58:15 +0200
Received: by mail-qy0-f143.google.com with SMTP id 7so8726227qyk.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 08 Jun 2009 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=XStcQFovNcexTR7mXg3rq3kINsf5ybbXDBi9j3kJSrY=;
        b=Wh9hGxiIGeeSApDkWKTW5uqzTTxbm4OMC/WJr59GRwQ4DAiiCjcfHZU5fz6aaqfYKQ
         DKH1+fIscuAuIY9NzhMpiZkLC2J9ZPAjiDHGweN5jPrbFCfT4FS4Ct8AXVfNUaGeMFsV
         m4mo0GN5lEVOot4cWeomQHDMq/qYok8qyc17Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=VKxyc5lWO6E52SXV81ko2K1X6fXgonmm15AxtenHaGjXa9KO46zMIam+AGO79IDfGa
         F7hlU1KIuGGncehnc3ILLiCeY+OQdsK9SyNPcGPBIRaCbMR7BIapN/P5OeLzm60OKG6S
         0H7BNZtGIZCnGDND0cpMRZEQzu4XUeDPX+k50=
Received: by 10.220.98.5 with SMTP id o5mr2220772vcn.19.1244458685211;
        Mon, 08 Jun 2009 03:58:05 -0700 (PDT)
Received: by 10.230.2.2 with SMTP id 2gr5508vbh.0;
	Mon, 08 Jun 2009 03:58:05 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.86.26.11 with SMTP id 11mr106584fgz.21.1244458684224; Mon, 08 Jun 2009 03:58:04 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id d8si151129fga.9.2009.06.08.03.58.04; Mon, 08 Jun 2009 03:58:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 08 Jun 2009 10:58:03 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp055) with SMTP; 08 Jun 2009 12:58:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19p8QBYFkZpKRC+VwAF1tPLHnDDgTdVVLSRTHEo6r ikszgry9uncf9X
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fabb9a1e0906080351hbfe7ab7w2016a030ef1bde7@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121060>


Hi,

On Mon, 8 Jun 2009, Sverre Rabbelier wrote:

> On Mon, Jun 8, 2009 at 12:43, Ferry Huberts<ferry.huberts@pelagic.nl> 
> wrote:
> > this does not work for me.
> 
> Perhaps you want to define 'does not work'

Well, it is clear, no?  It "does not work".

:-)

> > with this patch it is fixed/reverted:
> 
> I doubt simply reverting the 'fix' is going to be a good idea, methinks 
> the original fix was done for a reason, no?

The original fix was indeed done for a reason.

My best guess (as I said in another email on the msysgit list today, where 
Ferry probably did not expect helpful information): msys-1.0.dll was not 
properly updated.

I worked on a check for this some time ago, but I forgot to finish and 
include it in our official 'devel'.

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git for Windows 1.6.3.2
Date: Tue, 9 Jun 2009 15:58:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906091555140.23789@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de>    <26984.77.61.241.211.1244457815.squirrel@hupie.xs4all.nl>    <fabb9a1e0906080351hbfe7ab7w2016a030ef1bde7@mail.gmail.com>    <alpine.DEB.1.00.0906081255530.4461@intel-tinevez-2-302> <34357.77.61.241.211.1244459143.squirrel@hupie.xs4all.nl> <alpine.DEB.1.00.0906081403390.4461@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>, msysgit@googlegroups.com,  git@vger.kernel.org
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Jun 09 15:58:21 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME1qH-0004aJ-HI
	for gcvm-msysgit@m.gmane.org; Tue, 09 Jun 2009 15:58:21 +0200
Received: by qyk7 with SMTP id 7so10723966qyk.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 09 Jun 2009 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=2hu/Z7NfrWo4thwttIzzNu6L5FkKdNLUp3X4EtLSD1Y=;
        b=qufBWbu1tsFNU0FgTGGBToH2OBN1eG3r3FDp6OofxoNKVNxUvwF77WAFjeTVRiSGDj
         znM/kct0tlU586jPgdDCiib9xvmmDPZLo/CkIYhDX1lTcRMXniC6nn+SXQkjqOXy1Ush
         Bijd+al9IQ7FvPcxGiU/SGiffUDm4I5qgcqWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=QgBd+659ujSYxhayqlQSzVea1snjYkpa0WjeY7igF1xIwGqO/aw5f5tPiEM9kT7Yk+
         LK5uMQYfXPoQVnAO9AaVJyfMtw1ziY3YQtC5PPiCucO/ZrlvVulDJh9MbVk2+jjbsMm/
         +Ao9gNyT/LfnNh9xFb6sVsDVZ9HsaOw7KNe6o=
Received: by 10.220.91.197 with SMTP id o5mr52956vcm.1.1244555890697;
        Tue, 09 Jun 2009 06:58:10 -0700 (PDT)
Received: by 10.230.18.136 with SMTP id w8gr5534vba.0;
	Tue, 09 Jun 2009 06:58:10 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.86.94.12 with SMTP id r12mr4080fgb.26.1244555888911; Tue, 09 Jun 2009 06:58:08 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id d8si215257fga.0.2009.06.09.06.58.08; Tue, 09 Jun 2009 06:58:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 09 Jun 2009 13:58:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp015) with SMTP; 09 Jun 2009 15:58:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vNB9ND6mvKDkdSwE8b4H7frNs9li7Rf3x6VkaLa /cFcUsRJfBQB2S
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.0906081403390.4461@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121174>


Hi,

On Mon, 8 Jun 2009, Johannes Schindelin wrote:

> On Mon, 8 Jun 2009, Ferry Huberts wrote:
> 
> > > The original fix was indeed done for a reason.
> > >
> > > My best guess (as I said in another email on the msysgit list today, 
> > > where Ferry probably did not expect helpful information): msys-1.0.dll 
> > > was not properly updated.
> > 
> > sorry for that, I am subscribed to git.devel only. probably should have 
> > checked the msysgit list
> > 
> > > I worked on a check for this some time ago, but I forgot to finish and 
> > > include it in our official 'devel'.
> > 
> > does this mean that we can expect a '-2' msysgit release soon?
> 
> No.

Just to clarify: there is no -2 release, because it is a new day.  And no, 
I did not like the feeling that you "expect" me to do the work at all.

An example I positively _like_ is Tom Koelman, who tried the net installer 
(pointing out an issue I had not encountered before) and built his own Git 
installer, the better to help me fix bugs in the future.

Ciao,
Dscho

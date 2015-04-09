From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Re:
Date: Thu, 9 Apr 2015 14:27:16 +0300
Message-ID: <20150409142716.bd75cc6b9e13dc580cdda722@domain007.com>
References: <CAM9_S8jip3q-vUWFHCWP6ia2wrKOxDpxz2zLSQZPQvAQ0xmKrw@mail.gmail.com>
	<5525A4A2.9080405@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Mamta Upadhyay <mamta.upadhyay@gmail.com>,
        msysGit
 <msysgit@googlegroups.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: msysgit+bncBCWKX34CSUCBBGGETGUQKGQEDKJNZ4Q@googlegroups.com Thu Apr 09 13:27:21 2015
Return-path: <msysgit+bncBCWKX34CSUCBBGGETGUQKGQEDKJNZ4Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f188.google.com ([209.85.212.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCWKX34CSUCBBGGETGUQKGQEDKJNZ4Q@googlegroups.com>)
	id 1YgAcC-0003ti-Qo
	for gcvm-msysgit@m.gmane.org; Thu, 09 Apr 2015 13:27:20 +0200
Received: by wiwh11 with SMTP id h11sf24649076wiw.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Apr 2015 04:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=28QVoAYa05Q1f3Yn0B+JEm8wsmb0jWp3EpDq6SIB9Po=;
        b=AKFQeM1YbAgDyyRajR3UtFdrjDOT2zbdtRW3uFmYWZbK5jmgeQzOpXW2OKOrwxef7T
         L01d1zKz6stpYqYd/OGYFGbktg7MUcax9FgWmAkkZ0bnH0UuepIMiSHc2OH99VwcsRGz
         R5NxvpRMbNiamxqtTLTkXDhXA8t8HDq29RqKV7WIovcRrEEDWlpWtmYnol25TrO99jrz
         5lkPYwsXlF9mJz7MbtEMxQK8xWsQFGwHa2CGvkqhPaNStKILIwQFGEI3YPleQ3s45hsn
         8S2KJbhr9KhT/+SOpxa4t4e9gnKFSKieJ6uNXxi5zoA1VA4lGtAlnNbRhgDIXu9BaHRf
         /V9Q==
X-Received: by 10.180.188.106 with SMTP id fz10mr23663wic.14.1428578840413;
        Thu, 09 Apr 2015 04:27:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.82.168 with SMTP id j8ls562577wiy.1.gmail; Thu, 09 Apr
 2015 04:27:19 -0700 (PDT)
X-Received: by 10.180.105.226 with SMTP id gp2mr503584wib.1.1428578839670;
        Thu, 09 Apr 2015 04:27:19 -0700 (PDT)
Received: from mailhub.007spb.ru (mailhub.007spb.ru. [84.204.203.130])
        by gmr-mx.google.com with ESMTPS id b6si1172612lbc.1.2015.04.09.04.27.19
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 Apr 2015 04:27:19 -0700 (PDT)
Received-SPF: none (google.com: flatworm@users.sourceforge.net does not designate permitted sender hosts) client-ip=84.204.203.130;
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	(authenticated bits=0)
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id t39BRGao030247
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 9 Apr 2015 14:27:17 +0300
In-Reply-To: <5525A4A2.9080405@virtuell-zuhause.de>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-Original-Sender: flatworm@users.sourceforge.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: flatworm@users.sourceforge.net does not designate permitted
 sender hosts) smtp.mail=flatworm@users.sourceforge.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266990>

On Wed, 08 Apr 2015 23:58:58 +0200
Thomas Braun <thomas.braun@virtuell-zuhause.de> wrote:

[...]
> > I am trying to run the latest git 1.9.5 installer on windows. When I
> > run strings on libneon-25.dll it shows this:
> > 
> > ./libneon-25.dll:            OpenSSL 1.0.1h 5 Jun 2014
> > 
> > But when I load this dll in dependency walker, it picks up
> > msys-openssl 1.0.1m and has no trace of openssl-1.0.1h. My questions
> > to you:
> > 
> > 1. Is libneon-25.dll statically linked with openssl-1.0.1h?
> > 2. If not, where is the reference to 1.0.1h coming from?
> 
> I would be suprised if we link openssl statically into libneon. I
> guess libneon just reports against which openssl version it was
> *built*.
> 
> > I am asked to rebuild git with libneon-25.dll linked against
> > openssl-1.0.1m. But I am having a feeling that this is not needed,
> > since libneon is already picking the latest openssl version. Can you
> > please confirm?
> 
> You can download the development enviroment for git for windows here
> [1]. After installation, checkout the msys branch and then you can try
> to recomplile libneon using /src/subversion/release.sh.
> 
> [1]:
> https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20150319/msysGit-netinstall-1.9.5-preview20150319.exe
[...]

JFTR, the discussion about the same issue has been brought up on
git-users as well [2].

(People should really somehow use the basics of netiquette and mention
in their posts where they cross-post things.)

2. https://groups.google.com/d/topic/git-users/WXyWE5_JfNc/discussion

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

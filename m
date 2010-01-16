From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [RFC] Git Wiki Move
Date: Sat, 16 Jan 2010 11:17:05 +0100
Message-ID: <20100116101705.GA28821@localhost>
References: <4B4EF1E0.3040808@eaglescrag.net>
 <vpqbpgxrn32.fsf@bauges.imag.fr>
 <4B4F68E8.5050809@eaglescrag.net>
 <4B50F7DB.7020204@eaglescrag.net>
 <fabb9a1e1001151521s1837b3d5o2a35cb5bb35c8038@mail.gmail.com>
 <4B510217.8060200@eaglescrag.net>
 <fabb9a1e1001151608k6911bcf8p854d97c2f2d46264@mail.gmail.com>
 <4B51082B.5030508@eaglescrag.net>
 <fabb9a1e1001151644n65577c99qe41327b66de28114@mail.gmail.com>
 <4B5113FD.9020004@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Pieter de Bie <pieter@frim.nl>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Jan 16 11:17:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW5id-0002lk-KA
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 11:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab0APKRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 05:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462Ab0APKRP
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 05:17:15 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:65343 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab0APKRN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 05:17:13 -0500
Received: by fxm25 with SMTP id 25so891796fxm.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 02:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=nYezAUwruhis/tQbY8R/iowySyp5MklEiI7MqQcVyn4=;
        b=ZInir1Lt+IWwtAopL60efIvoz9EIjBHZa4jbtvsKXdjQT/Jfz2CuQfjXFky1+2EulW
         5gJChap4xsIst6I++/LUs8rtG6zE7YcODavBYX5TDHpS+xsZtOzthMccrPVXkE6PAEaH
         k/RgWp00HtSe9IuplVPOkVQMdMz1eotPDb2SY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=NeGYtcesroT5dD1cyxMwasJKO9MQAv6VJAEX/gAUMU1/xCVdmKMqTyCSx4RIbDYQ3e
         fiizqJn5N3xfYPhfAShhthQdQI7y76qr4gFtZOnOM5rCIxj7KbY/0ukjU8cf8ORRMXlA
         DUNvTYCU42TckgLXUUpknFOf7NfdeNWPLT74w=
Received: by 10.103.4.9 with SMTP id g9mr1622201mui.57.1263637032391;
        Sat, 16 Jan 2010 02:17:12 -0800 (PST)
Received: from darc.lan (p549A2DF3.dip.t-dialin.net [84.154.45.243])
        by mx.google.com with ESMTPS id 23sm9439086mun.41.2010.01.16.02.17.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Jan 2010 02:17:11 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1NW5iL-0007de-Ae; Sat, 16 Jan 2010 11:17:05 +0100
Content-Disposition: inline
In-Reply-To: <4B5113FD.9020004@eaglescrag.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137215>

On Fri, Jan 15, 2010 at 05:18:53PM -0800, J.H. wrote:
> On 01/15/2010 04:44 PM, Sverre Rabbelier wrote:
> > On Sat, Jan 16, 2010 at 01:28, J.H. <warthog19@eaglescrag.net> wrote:
> >>> <!-- GitLink[git-name] Because Linus is an egotistical git -->
> >>
> >> Probably, should be fixed now, found it on GitBot too.
> > 
> > I guess you removed them rather than turning them in to comments
> > (probably due to MediaWiki's lake of comments)? Works for me, we can
> > figure out something else for gitbot. A regular text file that it can
> > slurp or something. We being Pieter perhaps (as he is the original author)?
> > 
> 
> The templates giving me a PITA trying to get it to actually generate a
> comment, easiest thing might be to hide it in the span or something, or
> add the comments in manually.
> 

While we are at it, it would be good to put gitlink's past the section
name, so that it is available when using section editing (the lack of which
was a huge PITA in moinmoin).

Also, it would be better to actually show the gitlink name and comment with
the regular content. Maybe using a special tag which makes it look like a
comment. For example

 == Why won't I see changes in the remote repo after "git push"? ==
 {{gitlink|non-bare|Pushing to non-bare repositories is discouraged}}

which gets translated to

 <div id="contentSub">
  non-bare -- Pushing to non-bare repositories is discouraged
 </div>

Clemens

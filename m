From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why is it important to learn git?
Date: Wed, 22 Jul 2009 14:44:23 -0700 (PDT)
Message-ID: <m3my6wbdfs.fsf@localhost.localdomain>
References: <e1a5e9a00907212208t10a071d0oe59a39b357a1111a@mail.gmail.com>
	<20090722210738.GA25324@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 23:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjc1-0003Ru-Vo
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbZGVVoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753816AbZGVVoZ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:44:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:7708 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbZGVVoY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:44:24 -0400
Received: by fg-out-1718.google.com with SMTP id e21so147452fga.17
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 14:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=1zvqYrchzj7JRnjWEnXaOplB1lj6IAic0F5ctBCcoLI=;
        b=A8P1DaBKHj6woarMF2iminEsJYWzcASzzRfAGNU1z53YVQiJbAL9Yt+bHinLvNC+19
         WLDIYXZTmFPmqnMfwQK4wavLkA6eLqwb6mOTQTB8+gtpGDWA5qENYftCuNJSraftbwLN
         yU6evlQuzvlFWXeIPwRjm5DA5mCLquzINN2ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=OKMYOL02YSPG4v2ckdy+gCdlID17IaLk8GCM6Htbl3m6CNcULLfINinInYQUh1M6Ke
         Zdu4HPWdHMK73MKlBMURLrMWhgsIG7+aw2o/Ln7N6tEwicaWZCBvshaddtbnJFqv0Ec8
         KMyt6RDUV9joiq0HPxKkke/wsVAG7Mx+gZ6Qs=
Received: by 10.86.30.16 with SMTP id d16mr1247224fgd.2.1248299063996;
        Wed, 22 Jul 2009 14:44:23 -0700 (PDT)
Received: from localhost.localdomain (abvd136.neoplus.adsl.tpnet.pl [83.8.201.136])
        by mx.google.com with ESMTPS id e11sm17462259fga.16.2009.07.22.14.44.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 14:44:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6MLiP8i002778;
	Wed, 22 Jul 2009 23:44:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6MLiOHx002775;
	Wed, 22 Jul 2009 23:44:24 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090722210738.GA25324@dpotapov.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123783>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Tue, Jul 21, 2009 at 11:08:31PM -0600, Tim Harper wrote:
> > 
> > How has mastering the advanced features of git helped you to be a
> > better programmer?
> 
> I don't think that features itself make as big difference as the fact
> Git provides you much more flexibility in choosing a more appropriate
> workflow than you have with any centralized VCS. (Yes, you will still
> find many Git features handy even if you work with it as you did with
> CVS, but you will miss most benefits of Git).
> 
> To really understand what benefits Git offers, you have to realize first
> what is wrong CVS and CVS-like VCSes. Unfortunately, it is difficult to
> explain just in a few words. Some implementation deficiency of CVS is
> obvious (and it was addressed in some CVS clones like Subversion), but
> more fundamental problems are far less obvious even for people who used
> CVS for many years.

See also my answer for "Difference between GIT and CVS" question
at StackOverflow:

  http://stackoverflow.com/questions/802573/difference-between-git-and-cvs/824241#824241
 
> To be fair to CVS, it is far from the worst VCS. There are some insane
> lock-based VCS, which were so painful to use (mostly due to these
> exclusive locks but often due to some other insanity too) that anyone
> who worked with may think about CVS as a really nice system...

By the way, even if CVS didn't implement support for file renames and
copying, at least it provides support for file deletion (as opposed to
*khem* SourceSafe).

-- 
Jakub Narebski
Poland
ShadeHawk on #git

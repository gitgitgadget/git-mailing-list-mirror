From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Sat, 3 Sep 2011 01:45:31 -0700
Message-ID: <20110903084530.GA20905@gmail.com>
References: <201107252233.02088.jnareb@gmail.com>
 <4E2DE708.8050805@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 03 10:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzlrE-0006l6-O8
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 10:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976Ab1ICIpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 04:45:40 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62650 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab1ICIpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 04:45:39 -0400
Received: by gxk21 with SMTP id 21so2627760gxk.19
        for <git@vger.kernel.org>; Sat, 03 Sep 2011 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QYmW27QwX/0FZ8qs8y+/NTCfYms6jBLv9eYCqCmnl3A=;
        b=DJ18EP0UT/2kJZAx9O7n1aO6Q6UB9clC9iDMmnTImibYQnnB8GIlMl86wlk0zxBdU0
         RKeZUQKlMIL5URKp9BKQvfbWDkfkvCs6S3ct45CdgLZ8itU0jlCsmLSaVvAopk59/X+h
         VgXZHoKTKx6OhiFCe6cLyBXzyminV8JkomR94=
Received: by 10.68.49.200 with SMTP id w8mr3618177pbn.9.1315039538402;
        Sat, 03 Sep 2011 01:45:38 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net. [208.106.56.2])
        by mx.google.com with ESMTPS id m1sm4584736pbf.3.2011.09.03.01.45.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Sep 2011 01:45:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E2DE708.8050805@cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180646>

On Mon, Jul 25, 2011 at 05:58:32PM -0400, Phil Hord wrote:
> On 07/25/2011 04:33 PM, Jakub Narebski wrote:
> > === 11. What Git interfaces, implementations and frontends do you use? ===
> > (multiple choice, with other)
> >
> >  + JGit (Java implementation), e.g. via Eclipse plugin
> >  + NGit or Git# (C# implementation)
> >  + Dulwich (pure-Python implementation)
> >  + Git::PurePerl (Perl implementation)
> >  + git.js (JavaScript)
> >  + libgit2 bindings
> >
> >  + git (core) commandline
> >  + Cogito (DEPRECATED)
> >  + Easy Git
> >  + Pyrite
> >  + I don't know, I only use (graphical) tools
> >
> >  + pg aka Patchy Git (DEPRECATED)
> >  + StGIT
> >  + Guilt
> >  + TopGit
> >
> >  + Zit
> >
> >  + other (please specify)
> 
> You can probably drop pg and Cogito now, yes?

I would drop Pyrite too.  The last activity was in 2008 and it
never went beyond pre-alpha.

> Looking at the 2010 results, I would add these GUIs to the main list:
> git-gui (core)
> gitk (core)
> gitX
> gitg
> git-cola
> TortoiseGit
> SmartGit
> Git Extensions
> Giggle

This is a better list ;-)
-- 
					David

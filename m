From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC 2009 Prospective student
Date: Mon, 23 Feb 2009 07:37:24 -0800 (PST)
Message-ID: <m3y6vxupvf.fsf@localhost.localdomain>
References: <a149495b0902221158h16d499f7w8bd18abaf1321e46@mail.gmail.com>
	<20090222204334.GY4371@genesis.frugalware.org>
	<alpine.LFD.2.00.0902221709460.5511@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Rohan Dhruva <rohandhruva@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 16:38:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbctT-00089B-GS
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 16:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbZBWPhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 10:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbZBWPhb
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 10:37:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:51331 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbZBWPha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 10:37:30 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2677147fgg.17
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 07:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=nlYwfMQ417ewESzz9A4yE/0iGA58LmHHCfLTUf7C68M=;
        b=IIy4zaUxT47HOnQYxpxqZ+fO9voT2SVQFo50xc8Asx+Lt5tzTaa+qNSCcBvmc1xBAn
         FOTxxbmwdVy0V+Xpnk+zwSXK8Vq/eI5OnCXd80gsUX6e1I1u4tcLh1h34Es9CMV7FyuJ
         NSJwzH1fn/T1z0deNphxBdQQOKmPF046zDvMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=VyHbOSlxy2EiaBMA4lK19gSJtsrHBOidld0UHnMKuI4SbV3qWg6ZutklUK14emrz2z
         c9y7NoRl28YuGvA1w3FH1Pc68DudI7yZVT/SUKsYSC4/CJGDQzt7j3ZZciJvoyXB77qt
         8PcIz3Ng0v76GyKFGt41OPNt6vSVMNM6Hclqs=
Received: by 10.86.28.2 with SMTP id b2mr715634fgb.62.1235403445273;
        Mon, 23 Feb 2009 07:37:25 -0800 (PST)
Received: from localhost.localdomain (abve227.neoplus.adsl.tpnet.pl [83.8.202.227])
        by mx.google.com with ESMTPS id e20sm651819fga.16.2009.02.23.07.37.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Feb 2009 07:37:24 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1NFatne021093;
	Mon, 23 Feb 2009 16:37:06 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1NFabfN021083;
	Mon, 23 Feb 2009 16:36:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.00.0902221709460.5511@xanadu.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111139>

Nicolas Pitre <nico@cam.org> writes:
> On Sun, 22 Feb 2009, Miklos Vajna wrote: 
> > On Mon, Feb 23, 2009 at 01:28:33AM +0530, Rohan Dhruva <rohandhruva@gmail.com> wrote:

> > > That being said, I have knowledge of C/C++ what was taught to me in
> > > school and college. I realize that my qualifications as such are not
> > > very impressive, and hence I wish to start with a smaller project. I
> > > read on the http://git.or.cz/gitwiki/SoC2009Ideas page that a
> > > "jump-in" project might be the "Restartable Clones" proposal.
> > 
> > I would recommend you to read this thread:
> > 
> > http://thread.gmane.org/gmane.comp.version-control.git/55254/focus=55298
> > 
> > Especially Shawn's message, which can be a base for your proposal, if
> > you want to work in this.
> 
> I don't particularly agree with Shawn's proposal.  Reliance on a stable 
> sorting on the server side is too fragile, restrictive and cumbersome.
> 
> Restartable clone is _hard_.  Even I who has quite a bit of knowledge in 
> the affected area didn't find a satisfactory solution yet.

I think it is possible for dumb protocols (using commit walkers) and
for (deprecated) rsync.
 
The only thing would be for "git clone --continue" to bypass check if
directory to download repository to is nonexistent or empty.  

I guess that what code can do (or perhaps even does currently) for
commit walk based dumb protocols (like HTTP) is to do commit walk, and
for packfiles which are already downloaded or partially downloaded,
download rest of file (if web server supports it; if not, redownload
whole packfile, but do not redownload already exiting packfiles).

For rsync:// it could be enough to just bypass the check... but the
probability of getting corrupted repository would be even higher,
unfortunately.

> I think restartable clone is a really bad suggestion for SOC students.  
> After all we want successful SOC projects, not ones that even core git 
> developers did not yet find a good solution for.
> 
> IMHO of course.

But I agree that within current limits (as far as I know there are no
way to ask for SHA-1; you can only ask for refs for security reasons)
it would be difficult to very difficult to add restartable clone
support to native (smart) protocols.

If not for this limitation it would be, I think, possible to do a kind
of fsck, checking which commits in packfile are complete (i.e. have
all objects), and based on that ask for subset of objects.  This would
require support only from a client... alas, this is not possible.

In mentioned post Shawn talks about a way for server to 1) generate
exactly the same packfile (the proposal is to replay want/have, but it
also requires stable sorting of objects); 2) transfer only the rest of
file (but server has to regenerate packfile anyway, as packfiles are
generated on-the-fly; well, unless it caches packfiles, which might be
good idea anyway).


I think that unless 'restartable clone' is limited to commit wakers
(HTP protocol etc.) it should be moved up the diffuculty from "New to
Git?" section. I guess that mirror-sync, formerly GitTorrent, could be
easier to implement.

-- 
Jakub Narebski
Poland
ShadeHawk on #git

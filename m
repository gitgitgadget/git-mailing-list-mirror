From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Sun, 13 Jan 2008 01:44:10 +0100
Message-ID: <200801130144.14574.jnareb@gmail.com>
References: <200712101357.49325.jnareb@gmail.com> <200801071057.27710.shlomif@iglu.org.il>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	David Kastrup <dak@gnu.org>, Florian Weimer <fw@deneb.enyo.de>,
	Chris Shoemaker <c.shoemaker@cox.net>
To: Shlomi Fish <shlomif@iglu.org.il>
X-From: git-owner@vger.kernel.org Sun Jan 13 01:44:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDqy2-0003CV-1k
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 01:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbYAMAoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 19:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbYAMAoW
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 19:44:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:38505 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYAMAoV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 19:44:21 -0500
Received: by ug-out-1314.google.com with SMTP id z38so663047ugc.16
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 16:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=n5i7Y5jQMgPLfTd0ht81f4hXvaEOmT2sPlF2VLVjKEQ=;
        b=LpGzuRK1ntz5DEcoAKu0jdYWW9ZcYZfBRH2NlVwdPj8xMx4Y3y0XoYpuMpcF5Ve2BFXc+56SZFGxCqz0TtTl7J8fTYb6YeAL1qU1+ARCsaCTdUcqsRdl30Dtlys9yf09+ri3zG6gaLKlv0IA5xDCTTHMV6zBkqtYjBEW+3J9EII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZKaeF+LW4g3oE838wJ2+kG2HF1RzX/sdNxCqujefhH4aPZy1WThWhm3yygMI52QKkb74ceHUxdU7S/Kzrk40uuNL4o5/3/X6t5BBbjP7XTToDSJcBWetrrxSksqMKfP5S61jkq0EnnBMaC7/71DLKnHJ+5KKF0HjOwdJY1QJwBs=
Received: by 10.67.98.15 with SMTP id a15mr1833982ugm.69.1200185059515;
        Sat, 12 Jan 2008 16:44:19 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.190.231])
        by mx.google.com with ESMTPS id 18sm16101704ugk.18.2008.01.12.16.44.16
        (version=SSLv3 cipher=OTHER);
        Sat, 12 Jan 2008 16:44:17 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200801071057.27710.shlomif@iglu.org.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70364>

On Mon, 7 Jan 2008, Shlomi Fish wrote:
> 
> I'm CCing all the correspondents, because I'm banned from the vger.kernel.org 
> mail. This has been an obstacle for me in several legitimate occassions and 
> this one is the latest. I'm still CCing it, so the people in the mailing list 
> will receive the replies.
> 
> On Monday 10 December 2007, Jakub Narebski wrote:
> > I have noticed that your SCM comparison at "Better SCM Initiative"
> > website
> >   http://better-scm.berlios.de/comparison/comparison.html
> > misses one of the Git, version control system which is used to manage
> > Linux kernel, and one of the main open source (distributed) version
> > control systems (among Mercurial, Bazaar-NG, Monotone and Darcs).
> >
> 
> Indeed git is absent. That's because no one until you has volunteered to send 
> a patch that adds it to the comparison. Another requirement is for someone to 
> volunteer to become a "champion" for the version control system and maintain 
> it into the future. So who is going to be the champion?

I can be git champion for "Better SCM Initiative" comparison... although
I'd rather somebody else was it.
 
[...] 
> > Below there is (slightly doctored) patch to the sources for the site.
> >
> 
> Despite the fact that I the comparison was recently patched to add Bazaar and 
> fix some grammatical problems, the patch still applies cleanly. However, I 
> saw that some people commented on it here. Can you send me a new patch 
> integrating all this commentary?

I'll try to send revised patch soon. Integrating commentary is a bit
harder that it could be because some responses were sent _only_ to
git mailing list, so I'd have to browse through git mailing list
archives.


BTW. some of the questions / comments were caused by the fact that the
features listed in Better SCM Initiative: Comparison are a bit ambiguous.

What does for example "Atomic Commit" mean? Does it mean that if we
interrupt commit in the middle we would always get full commit or none,
and not some f**d-up intermediate state? Hos CVS can have atomic commits
then?

What does "Renames Support" mean? Does it mean that when browsing history
we [can] show file / directory renames? Does it mean that log of file or
directory history [can] follow renames? Does it mean that line-wise file
history [can] follow renames? Renames support in merges is as TODO, so
I don't think that this one matters in this question. Because the answer,
especially in the case of git which is a bit different in that it does
rename detection and not rename tracking (using inodes / file-ids),
depends on that...

-- 
Jakub Narebski
Poland

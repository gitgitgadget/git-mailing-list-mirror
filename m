From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: git-scm.com
Date: Fri, 25 Jul 2008 22:30:29 -0700
Message-ID: <d411cc4a0807252230v76670d3cp2205e40826acc6e2@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <6b6419750807251838h12ea4f19gdff107694e3797c4@mail.gmail.com>
	 <d411cc4a0807251928g75744b78vac2ce77bf07fbd81@mail.gmail.com>
	 <20080726023707.GX32184@machine.or.cz>
	 <alpine.DEB.1.10.0807251943280.11335@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Patrick Aljord" <patcito@gmail.com>,
	"git list" <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Jul 26 07:31:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMcNT-0001QL-Gs
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 07:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbYGZFab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 01:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbYGZFab
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 01:30:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:24878 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbYGZFaa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 01:30:30 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2287740waf.23
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 22:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cC0UIvSZSoY43dGLW2V7mbJNBrrKHW+/9oVni0oTDyo=;
        b=NFvy+TaIqXalGpE78pE5G3CCMNeeY25CWDiPBsMD1rK/gx/j3uINBPt06d+r1PC8Rg
         jPi1nS3QdszL2ZH7h7iaWd3TvLlU/BzO6FEsvs5Q2qLMFSbakjvvfjPkaddVeuAAPgI8
         f5X12AND7Boq83Q+t69RDHarDfmwE8aeXy8yY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=M+RQv3vhTk77BQojdB6moKESNphtjR3Q6yMrpnqwzkHfhk68v9bR/sKibkxpRixEX7
         h8qyNYF8tyzRIjK3XdGn5g2yW6Oy6YZ/KgrvRe5xBIFALm9UwvCOlw0jJ9A9vW7OfFD0
         oJMYl5h36equklbynaVm3yiGKKtWciHDQIUeM=
Received: by 10.114.168.15 with SMTP id q15mr2883794wae.167.1217050229664;
        Fri, 25 Jul 2008 22:30:29 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Fri, 25 Jul 2008 22:30:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0807251943280.11335@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90181>

On Fri, Jul 25, 2008 at 7:47 PM,  <david@lang.hm> wrote:
> On Sat, 26 Jul 2008, Petr Baudis wrote:
>
>>  Hi,
>>
>> On Fri, Jul 25, 2008 at 07:28:32PM -0700, Scott Chacon wrote:
>>>
>>> I am more concerned about the logo at the bottom, and Petr and I are
>>> discussing this - I can remove the logo, but then I'd have to pay for
>>> this out of my pocket instead of having a small logo on the page.
>>
>>  I actually think that this is *one* reference to GitHub that is
>> perfectly and 100% okay; if it is sponsoring the hosting, it deserves
>> the logo, and it is fairly non-intrusive. I _am_ watching out warily
>> for excessive GitHub references within the rest of the site - if only
>> because I have kind of personal interest in a competitor of GitHub and
>> thus don't want GitHub to get unwarranted free advertising. :-)
>>
>>                                Petr "Pasky" Baudis
>
> since this is a Ruby on Rails site, could the 'five links' that have been
> bothering people be randomly selected? if every time you go to the site you
> get a different list of projects it show how broadly git is used. it's not
> as 'in your face' as managing to select five that cause people to say "wow,
> they're using this", but different people will react to different sites.
>
> if this table gets populated by GitHub, kernel.org, and a couple other
> sources it should be vendor independant enough (and we need a table like
> this anyway for the 'list of projects that use git', so it serves two
> purposes)
>
> David Lang
>

I would really like to have the big ones there all the time ('Linux',
'Ruby on Rails', 'WINE', 'X.org', etc)  Prototype and MooTools are
pretty big in the web dev world, which a lot of people are starting to
come from - at least Prototype should be there all the time.  For the
rest, if we want to pool a bunch of other projects from different
places, that would be cool, but they should be active - I don't want
people clicking on something above the fold and getting a dead
project.  If someone wants to help me vet a list, I'd be happy to do
that.

However, that being said, it's going to be difficult to have Github
projects not dominate the list a bit.  The fact is that it hosts far,
far more projects than any other single hosting service.  Just in
fully public projects, the current stats (from the website pages) are
something like this:

kernel.org : 475
repo.or.cz : 1,553
gitorious   : 780
github       : 10,560

It hosts far more than that if you include private projects, too.  So,
if we want to choose totally randomly, it's going to be at least a 5:1
ratio between github projects and all other public hosting providers.
If anything, statistically, the current list is conservative in it's
links to github projects.  For me to avoid using them is artificially
punishing them for having paid plans, which is silly.

Scott

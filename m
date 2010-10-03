From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Advertising the Git User's Survey 2011
Date: Sun, 3 Oct 2010 23:37:46 +0530
Message-ID: <20101003180743.GK328@kytes>
References: <AANLkTim1mLhQnJPT9KiinR4L3C=O9L=V9M3X9x7Cr+oC@mail.gmail.com>
 <201010031121.03795.jnareb@gmail.com>
 <20101003124818.GA328@kytes>
 <201010031655.40521.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 20:09:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Szh-0005kB-7R
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 20:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307Ab0JCSI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 14:08:58 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57169 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271Ab0JCSI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 14:08:57 -0400
Received: by pvg2 with SMTP id 2so1146292pvg.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bHO5vmypyIUYAPjiGD1sv1Bxt7e90HrBgO796OH76vw=;
        b=ANVBHllaZmDbj3JHi3xnwnKnPw7NPaYu4Qg+HMX/C2ULV1GdLaor8xZYaVBSoOjZOF
         aI0BXp5GUiyOuKrygEJ1xfNPMBfXWAHL+EFsjHa3/G7nDYHoBeZm6VLiw7ty0kqFurY+
         G1PDT9LaK6JLLTNYi6ctjEn8+W9lYIgzf+g3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WEy+0EqfdE7PGm73XGbgxQYjWU49Oc1EfzLIzAoO9cd61EjCO7PJ9/A7Gy+NV9EUWC
         L3eb54lTf3LZdqmkiUhlx9FwhOsKuLsdBe6svyCi5E6tN+Z1lCnwahB3R7goGWAFI+So
         0IL88w3Ar6ei2VtiWY1wY9f+KcInXmkg+NhEs=
Received: by 10.143.33.1 with SMTP id l1mr7483781wfj.249.1286129337288;
        Sun, 03 Oct 2010 11:08:57 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id o9sm5167694wfd.16.2010.10.03.11.08.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 11:08:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010031655.40521.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157888>

Hi again,

Jakub Narebski writes:
> On Sun, 3 Oct 2010, Ramkumar Ramachandra wrote:
> > Perhaps we can email survs.com and ask them?
> 
> Should I do it, or would you do it?

Er, why will they know who I am and give me this information? You've
been in touch with them before, I hope?

> > > We could also write how much time it takes on average to fill the survey.
> > 
> > Sounds good.
> 
> Note however that such information is available only after survey is
> opened for a bit (unless we use test run statistics).

I suppose that's alright.

> > > The other side of removing options from "13. Which git hosting site(s)
> > > do you use for your project(s)?" is that when sending requests to 
> > > announce the survey to those git hosting sites that are not on this
> > > list, some of them requested to be added (which is impossible after
> > > starting the survey; and before survey begins it is little sense to
> > > send announcements).
> > 
> > I see. How are we going to tackle this in future?
> > 
> > > Besides all of those below 1% rounded (Codesion, GitFarm, The Chaw,
> > > CipherHive) are also those that I didn't get response to request for
> > > announcing Git User's Survey 2010...
> > 
> > Interesting.
> 
> We can always remove (and do not add) those choices for which we don't
> get much responses for, and which do not respond to attemts to contact.  
> Conversely, we probably should add those git hosting sites that we have
> many replies in the "other, please specify".

*nod*

> > > We could make it more organized though, e.g. by sorting list of options
> > > alphabetically, or something like that.
> > 
> > Sounds good.
> 
> Will do, perhaps starting with repo.or.cz (first site), GitHub (most
> popular), Gitorious and perhaps Gitolite (OSS engine), and ending with
> non-generic sites such as git.kernel.org, Alioth, Fedora Hosted, etc.

*nod*

> > > Another solution would be to have pre-filled combo box (<select> field)
> > > with the list of countries to choose from, with GeoIP ised to pre-select
> > > the country.  I can generate list of all countries myself
> > > 
> > >   $ perl -MLocale::Country \
> > >     -wle 'print join("\n", sort (all_country_names()))'
> > > 
> > > as far as I know Survs.com doesn't offer GeoIP nor any API to hook it
> > > to survey questions.
> > 
> > I suppose we could always work out a way to display the results from
> > the information Survs.com gives us.
> 
> Do you have any idea how to display such geographical information, and
> what tool to use for that visualization?

A quick Google search pointed me to several tools that parse a
plaintext file of (lattitude, longitude) entries and use the Google
Maps API to plot them. I'm sorry, but I don't know much more about
this.

> > Nice histogram! How did we manage to do this in 2009? Did we use a
> > custom-made application to do the survey?
> 
> I used a Perl script, which uses Text::CSV to parse data exported from
> Survs.com in CSV format (and PerlIO::gzip to not have to decompress it).
> Each survey page on Git Wiki, except for the very first survey, contains
> link to file with such exported data.
> 
> For example for age it extracts digits from the response, and assumes
> that it is number of years.  It also creates this nice table of ranges
> that you can see in the mentioned section of GitSurvey2009 page.
> 
> I can publish this script, e.g. the one used for 2009 survey on the
> GitSurvey2009 page, but it is rough'n'dirty script.

Sounds good- we should create a small repository that contains all the
tools used, notes made, and results (in semantic format) of previous
surveys. Embarrassingly enough, I can't read Perl myself, but I'm sure
the others will find it useful. Also, isn't there some Perl module to
use Google Maps API to draw that map?

-- Ram

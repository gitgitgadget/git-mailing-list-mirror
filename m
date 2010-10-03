From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Advertising the Git User's Survey 2011
Date: Sun, 3 Oct 2010 16:55:36 +0200
Message-ID: <201010031655.40521.jnareb@gmail.com>
References: <AANLkTim1mLhQnJPT9KiinR4L3C=O9L=V9M3X9x7Cr+oC@mail.gmail.com> <201010031121.03795.jnareb@gmail.com> <20101003124818.GA328@kytes>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "=?iso-8859-1?q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 16:55:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2PyR-0007qu-Bg
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 16:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab0JCOza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 10:55:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49763 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab0JCOz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 10:55:29 -0400
Received: by bwz11 with SMTP id 11so3082548bwz.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HpQeL+N6H3/aNGFiBhGBykk293W6nESh5JsUfP5r4SA=;
        b=OGpJjmDb4u8ODDnU9Rau0sVN8Y8nyysibVjzOQ1rkQtNBnN23/oDdk6Hh6oxb9Q1WY
         rxG3c6X7H/8NuQggjVi5KNIEPV+RbdQor7HDPkiLzL92ju/KcIBCT3ueeJAzirw6VjKC
         2ryWkdkjNWkp4cPRxU3aUlzlseXBDVkidRBv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=X6xPX3syHeN2QqHnazwbnz4E48pSvtKtmcQ7lK9rwYf6HRGHLWB5nL0JC1WHpuXL8r
         WoPjKBYuLT5afSUB9YMPDsDz6RkYM8CfnfBPDztN76du88gocFKrNWK2rKAiHLpOUHde
         9zym5P+JH+QmEjjtrLKNZiyfZ7eG0Zdi9UyZY=
Received: by 10.204.51.83 with SMTP id c19mr1039654bkg.144.1286117727727;
        Sun, 03 Oct 2010 07:55:27 -0700 (PDT)
Received: from [192.168.1.13] (abwo152.neoplus.adsl.tpnet.pl [83.8.238.152])
        by mx.google.com with ESMTPS id x13sm2798837bki.0.2010.10.03.07.55.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 07:55:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20101003124818.GA328@kytes>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157879>

On Sun, 3 Oct 2010, Ramkumar Ramachandra wrote:
> Jakub Narebski writes:
> > On Sat, 2 Oct 2010, Ramkumar Ramachandra wrote:

[...]
> Perhaps we can email survs.com and ask them?

Should I do it, or would you do it?

[...]
> > We could also write how much time it takes on average to fill the survey.
> 
> Sounds good.

Note however that such information is available only after survey is
opened for a bit (unless we use test run statistics).

> > > The average time spent on the survery is 34 minutes

[...]
> > The other side of removing options from "13. Which git hosting site(s)
> > do you use for your project(s)?" is that when sending requests to 
> > announce the survey to those git hosting sites that are not on this
> > list, some of them requested to be added (which is impossible after
> > starting the survey; and before survey begins it is little sense to
> > send announcements).
> 
> I see. How are we going to tackle this in future?
> 
> > Besides all of those below 1% rounded (Codesion, GitFarm, The Chaw,
> > CipherHive) are also those that I didn't get response to request for
> > announcing Git User's Survey 2010...
> 
> Interesting.

We can always remove (and do not add) those choices for which we don't
get much responses for, and which do not respond to attemts to contact.  
Conversely, we probably should add those git hosting sites that we have
many replies in the "other, please specify".

> > We could make it more organized though, e.g. by sorting list of options
> > alphabetically, or something like that.
> 
> Sounds good.

Will do, perhaps starting with repo.or.cz (first site), GitHub (most
popular), Gitorious and perhaps Gitolite (OSS engine), and ending with
non-generic sites such as git.kernel.org, Alioth, Fedora Hosted, etc.

> > > 1. Country of residence: we can probably make this a nice click-on-map
> > >    interface as opposed to freeform text. It'll be more useful to us,
> > >    and more interesting to users when we advertise the results.
> > 
> > It would be nice to have click-on-map (Google Maps or Bing Maps based),
> > something like Ohloh provides, resulting in map of survey responders
> > similar to the map of git users and git contributors on Ohloh
> > 
> >   http://www.ohloh.net/p/git/map
> > 
> > it isn't something that Survs.com offers currently.  I can only ask for
> > it to be provided...
> > 
> > 
> > Another solution would be to have pre-filled combo box (<select> field)
> > with the list of countries to choose from, with GeoIP ised to pre-select
> > the country.  I can generate list of all countries myself
> > 
> >   $ perl -MLocale::Country \
> >     -wle 'print join("\n", sort (all_country_names()))'
> > 
> > as far as I know Survs.com doesn't offer GeoIP nor any API to hook it
> > to survey questions.
> 
> I suppose we could always work out a way to display the results from
> the information Survs.com gives us.

Do you have any idea how to display such geographical information, and
what tool to use for that visualization?

> > > 2. Age: Maybe we restrict the input to 2-digit integers and draw a
> > >    graph with all these integers to show a mean, median etc?
> > 
> > Restricting input doesn't give us much.
> 
> I just meant it as a sanity check in case people enter "34 years old"
> and the like.

We can quite easily parse this, see below.

> > There is nice histogram of responder's age for Git User's Survey 2009
> > 
> >   https://git.wiki.kernel.org/index.php/GitSurvey2009#02._How_old_are_you_.28in_years.29.3F
> > 
> > and tabularization of responses.  We can calculate mean, median, mode
> > (aka modal score, i.e. most common response), perhaps after eliminating
> > outliers, but would it give us much information?
> 
> Nice histogram! How did we manage to do this in 2009? Did we use a
> custom-made application to do the survey?

I used a Perl script, which uses Text::CSV to parse data exported from
Survs.com in CSV format (and PerlIO::gzip to not have to decompress it).
Each survey page on Git Wiki, except for the very first survey, contains
link to file with such exported data.

For example for age it extracts digits from the response, and assumes
that it is number of years.  It also creates this nice table of ranges
that you can see in the mentioned section of GitSurvey2009 page.

I can publish this script, e.g. the one used for 2009 survey on the
GitSurvey2009 page, but it is rough'n'dirty script.

> > > Of course, I understand that there must be some technical constraints
> > > due to which some things are not implementable (eg. survs doesn't
> > > provide the feature?), but I've not taken that into consideration.
> > 
> > Note that as it currently stands we can use Survs.com account only for
> > 2011 survey, provided that it is done earlier than this year (perhaps
> > 1 June -- 31 July?), as our Premium account which we got thanks to 
> > generosity of Survs.com admins (after Survs.com got out of beta) will
> > downgrade to the Free plan (which is offersn much too low limits)
> > on Sep 22, 2011.
> 
> I see. Any thoughts on long-term plans? Do we pay for the premium
> account or do we build a custom application?

Dunno.

-- 
Jakub Narebski
Poland

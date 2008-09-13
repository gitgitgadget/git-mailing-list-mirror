From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary, part 5 - other SCM
Date: Sun, 14 Sep 2008 00:03:28 +0200
Message-ID: <200809140003.29570.jnareb@gmail.com>
References: <200809031607.19722.jnareb@gmail.com> <200809121244.59067.jnareb@gmail.com> <alpine.DEB.1.10.0809131408010.17867@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Sun Sep 14 00:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KedEU-0001AT-U2
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 00:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbYIMWDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 18:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbYIMWDj
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 18:03:39 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:3412 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbYIMWDi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 18:03:38 -0400
Received: by ey-out-2122.google.com with SMTP id 6so630580eyi.37
        for <git@vger.kernel.org>; Sat, 13 Sep 2008 15:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=b9JpCZ1WFq32IeS75enK2SPkojGbk0HbeRCyOrAtY8Q=;
        b=bABm+yMocZnwjqZ45O53I9etlEc18DomkrEeviee3kAzVmOc9tAmCNrndYaob+Zqat
         abT5TrkHt1/j094mZ1zOxUm4AFzvk8itDVKY2k9a04+LXR1iMfbbbdyORdkBA7zvph1Z
         cDB2/0koWBMRyIoVC8H+4aeto9GLYdUvj16Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=F4VfD0URZKsHskYh6Xzf+tREOTFFXuMHqlw38ICSXNU1JjUCTlvszB9tpu7u06pKwr
         hLzuA91lfrWkylbIS89rvDEYREaNx1zTHuQHolcKigWKh5hJ1LJmQYgte8Ehr2s/0MRG
         S8gQZWUuI0JjkO6dqcZ/vdphWFZNuxzH5AtuE=
Received: by 10.86.95.20 with SMTP id s20mr4457132fgb.49.1221343416161;
        Sat, 13 Sep 2008 15:03:36 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.227.225])
        by mx.google.com with ESMTPS id d6sm12673156fga.2.2008.09.13.15.03.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Sep 2008 15:03:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.10.0809131408010.17867@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95817>

On Sat, 13 Sep 2008, David Lang wrote:
> On Fri, 12 Sep 2008, Jakub Narebski wrote:
>> On Fri, 12 Sep 2008 00:51, david@lang.hm wrote:
>>> On Thu, 11 Sep 2008, Jakub Narebski wrote:
>>>
>> True, I have forgot that "I use this SCM" (or "I used this SCM") doesn't
>> necessarily mean that one _choose_ this SCM.  One can use some SCM
>> because it is SCM project uses, or because their company requires it;
>> but not necessary, as git-svn and git-p4 show one can use Git, and
>> make it interact with respectively Subversion and Perforce, and trying
>> to make it look like one uses this other SCM.
> 
> I would expect people to still count those as using the other SCM. git-svn 
> and git-p4 can do a lot, but they don't do everything, once in a while I 
> would expect to need to use the native commands for the upstream SCM

Well, you can check it by analysing correlations between answers. 
Unfortunately there is no way to share raw data beside me generating it
and sending, or you registering at Survs.com and me adding you as admin,
but you can emulate it using existing (just created) filters on
"Analyze" page for Git User's Survey 2008:
  http://www.survs.com/shareResults?survey=M3PIVU72&rndm=OKJQ45LAG8
  http://tinyurl.com/GitSurvey2008Analyze

For example if you chose filter 'publish to git-svn', which select all
replies that have answered question 25.: how do you publish and checked
git-svn option, you can see that among those responders 6 of 555 (1%)
selected that they _never_ used Subversion.

>>> I find it interesting that the number of people who use git and the other
>>> DVCS systems in so small. Is this becouse the 'market share' of those
>>> other systems is small? Or becouse people who learn git aren't willing to
>>> put up with other systems (or vice-versa)? Or is there some other trend
>>> or tendancy that makes people who select one DVCS more likely to work on
>>> similar projects, so people interested in those types of projects will
>>> generally just see a single DVCS system
>>
>> I don't think 59% (in the example case of using currently Subversion)
>> is small.  Take into account for example that there are people who (as
>> seen from responses to other questions in this survey) use SCM (Git)
>> only to track their private work, never publishing.  Then there are
>> people who do not track (perhaps with exception of web interfaces)
>> other projects development using version control systems, even if they
>> do follow their development.
> 
> Subversion is not a Distributed SCM. I am pointing out the much smaller 
> overlap between distributed SCM systems.

Oh, now I understand and agree with what you noticed: in "I use" most
you get for distributed SCM is 9%, most in "used it" is 19% (hmmm...
is it really small?).

First, from various nonscientific researches (Ohloh stack count, Debian
popcon, counting well-known projects using given SCM; Google search
trends do not count) it looks like Git has biggest market share from
distributed version control systems (Subversion has larger share, but
it is centralized).  So one would expect at most
  <share of SCM>/<share of Git>*100% 
as a percentage for sum of "I used it" and "I use it" columns, or at
least for "I use it" answer.

Second, one usually choose single SCM for his/her projects. And one
usually interacts (for example tracks) projects which use the same SCM;
kernel folks use Git (and kernel-related projects migrate to Git too,
take for example ALSA project), people who work more on Windows (Mozilla)
and have product competing with Linux (OpenSolaris) ;-) use Mercurial,
Ruby and RoR people moved to Git, Ubuntu / Canonical use Bazaar-NG.

Third different SCM have slightly different UI, and different underlying
models.  If you use one, usually you find other SCM concept and commands
unintuitive (and of course vice versa).

But that is just speculation...
-- 
Jakub Narebski
Poland

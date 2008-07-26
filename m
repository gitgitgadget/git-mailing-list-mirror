From: david@lang.hm
Subject: Re: git-scm.com
Date: Fri, 25 Jul 2008 23:27:17 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0807252317050.10571@asgard.lang.hm>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>  <6b6419750807251838h12ea4f19gdff107694e3797c4@mail.gmail.com>  <d411cc4a0807251928g75744b78vac2ce77bf07fbd81@mail.gmail.com>  <20080726023707.GX32184@machine.or.cz> 
 <alpine.DEB.1.10.0807251943280.11335@asgard.lang.hm> <d411cc4a0807252230v76670d3cp2205e40826acc6e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Petr Baudis <pasky@suse.cz>, Patrick Aljord <patcito@gmail.com>,
	git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 08:27:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMdFw-0005ky-6D
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 08:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbYGZG00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 02:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbYGZG00
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 02:26:26 -0400
Received: from mail.lang.hm ([64.81.33.126]:34076 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbYGZG0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 02:26:25 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m6Q6QFDI023936;
	Fri, 25 Jul 2008 23:26:15 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <d411cc4a0807252230v76670d3cp2205e40826acc6e2@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90184>

On Fri, 25 Jul 2008, Scott Chacon wrote:

> On Fri, Jul 25, 2008 at 7:47 PM,  <david@lang.hm> wrote:
>> On Sat, 26 Jul 2008, Petr Baudis wrote:
>>
>>>  Hi,
>>>
>>> On Fri, Jul 25, 2008 at 07:28:32PM -0700, Scott Chacon wrote:
>>>>
>>>> I am more concerned about the logo at the bottom, and Petr and I are
>>>> discussing this - I can remove the logo, but then I'd have to pay for
>>>> this out of my pocket instead of having a small logo on the page.
>>>
>>>  I actually think that this is *one* reference to GitHub that is
>>> perfectly and 100% okay; if it is sponsoring the hosting, it deserves
>>> the logo, and it is fairly non-intrusive. I _am_ watching out warily
>>> for excessive GitHub references within the rest of the site - if only
>>> because I have kind of personal interest in a competitor of GitHub and
>>> thus don't want GitHub to get unwarranted free advertising. :-)
>>>
>>>                                Petr "Pasky" Baudis
>>
>> since this is a Ruby on Rails site, could the 'five links' that have been
>> bothering people be randomly selected? if every time you go to the site you
>> get a different list of projects it show how broadly git is used. it's not
>> as 'in your face' as managing to select five that cause people to say "wow,
>> they're using this", but different people will react to different sites.
>>
>> if this table gets populated by GitHub, kernel.org, and a couple other
>> sources it should be vendor independant enough (and we need a table like
>> this anyway for the 'list of projects that use git', so it serves two
>> purposes)
>>
>> David Lang
>>
>
> I would really like to have the big ones there all the time ('Linux',
> 'Ruby on Rails', 'WINE', 'X.org', etc)  Prototype and MooTools are
> pretty big in the web dev world, which a lot of people are starting to
> come from - at least Prototype should be there all the time.  For the
> rest, if we want to pool a bunch of other projects from different
> places, that would be cool, but they should be active - I don't want
> people clicking on something above the fold and getting a dead
> project.  If someone wants to help me vet a list, I'd be happy to do
> that.

I can see things going either way on this, and I'm sure that the algorithm 
for the 'best' way to select projects can be tweaked endlessly. I am not 
that afraid of someone hitting a dead link, especially if you were to list 
them as 'projects 2,4895,9287,104,18439 of xxxxxx project that have 
reported using git' with numbers that large people expect that some 
projects will have gone dead, and even if they are all live today, how 
frequently did you plan to re-check them to decide they are dead? (and 
what is your definition of dead?)

> However, that being said, it's going to be difficult to have Github
> projects not dominate the list a bit.  The fact is that it hosts far,
> far more projects than any other single hosting service.  Just in
> fully public projects, the current stats (from the website pages) are
> something like this:
>
> kernel.org : 475
> repo.or.cz : 1,553
> gitorious   : 780
> github       : 10,560
>
> It hosts far more than that if you include private projects, too.  So,
> if we want to choose totally randomly, it's going to be at least a 5:1
> ratio between github projects and all other public hosting providers.
> If anything, statistically, the current list is conservative in it's
> links to github projects.  For me to avoid using them is artificially
> punishing them for having paid plans, which is silly.

as long as there is a mechanism to add things to the list I don't see 
anything wrong with the frequency reflecting this reality. anyone who 
thinks the numbers are skewed is free to add other projects to the list.

part of this is reducing the room for people to accuse you of impropriaty, 
if you select the links people can accuse you of playing favorites, if 
it's random selection and includes competitors entire lists, it's much 
clearer that you aren't skewing things.

David Lang

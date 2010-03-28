From: Scott Haneda <talklists@newgeo.com>
Subject: Re: Is this an appropriate list for general git questions
Date: Sat, 27 Mar 2010 17:00:29 -0700
Message-ID: <E5E3011E-ACE4-4932-B6CA-74E5555C708E@newgeo.com>
References: <5C4288BC-B87E-41CB-B3CB-90122098B7E9@newgeo.com>  <32541b131003211736t823ea8cye7ab4075fa8ccdd5@mail.gmail.com>  <0D0DD5C5-B535-49AC-B0A9-403C4FA5E193@newgeo.com> <32541b131003271529x6d6f8b03g18cbf9949d49a574@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 01:00:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvfvs-0000d7-KV
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 01:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab0C1AAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 20:00:31 -0400
Received: from moses.hostwizard.com ([64.84.37.6]:61873 "EHLO
	gonepostal.hostwizard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117Ab0C1AAa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 20:00:30 -0400
Received: from [192.168.1.107] (173.164.173.161) by 
 gonepostal.hostwizard.com with ESMTP (EIMS X
 3.3.9); Sat, 27 Mar 2010 17:00:29 -0700
In-Reply-To: <32541b131003271529x6d6f8b03g18cbf9949d49a574@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143365>

On Mar 27, 2010, at 3:29 PM, Avery Pennarun wrote:
> On Sat, Mar 27, 2010 at 4:07 AM, Scott Haneda <talklists@newgeo.com> wrote:
>> On Mar 21, 2010, at 5:36 PM, Avery Pennarun wrote:
>>> You should probably look at getting a good book on version control.
>>> You can find *these* using Google, including free online ones, now
>>> that you know this is what you should do :)
>> 
>> Ok, I will look into it.  I am really hoping there is a "4 command to using
>> git" type of thing.  I think I even heard that Joel Spolsky guy state
>> something along those lines; that he has gotten by with version control
>> on 4 commands.  I can not remember if it was git he was referring to though.
> 
> No, it was mercurial.  As I recall, he then went on to decide that
> trying to use it with only four commands wasn't the right approach and
> you should actually learn about it, and wrote a series of tutorials.

Ha, you have a good memory :)

> It's generally agreed (though perhaps not among everyone on this list
> :)) that mercurial is easier to learn at first than git.  However, in
> my experience, once you've spent the time to learn how git works, you
> also gain a lot more than with any other system.  It's ridiculously
> powerful, in the same way that Unix is powerful.

Good, I should eventually feel at home then.  I may use Mac OS X, but I certainly treat it like any other *nix I admin.  That is part of this, all the maintenance, helper, and other scripts I have created and culled over the years, need a place to go.

I am tired of the excessive comments in my files, with time and date stamps, and commenting out a chunk of code, but not deleting it because I need it as a point of reference to tell myself down the road WTF I was thinking.  Git should help me clean that all up and have a nice code only file, with revisions I can go back through to answer any questions about why I did something in the past.

> Then again, if you're running on a Mac, there are some GUI-based git
> tools available.  I've heard good things about GitX, though I haven't
> tried it myself.

I think I am going to stay away for the GUI tools.  I always regret using them.  I end up on some other machine, in some other shell, in some other session, and do not have the tools with me.  I have found it most beneficial to be able to be functional in a shell, which is more or less the same no matter what platform I am on as long as it is not Windows.  I stuff my bash profiles in a place where I can get to them, and that usually works for me.  That is another thing I could put in git as well.

>>> source code almost never *needs*
>>> these resource forks: only finished products do, and those are usually
>>> built *from* the source code.  As part of the build process, you add
>>> the resource forks and xattrs onto the completed files.
>> 
>> Yes, very true, except in the case of AppleScripts and Automator actions.
>>  Which can be "compiled" and finished apps, but also can be raw source files.
>>  However, I believe that even those, being that they run in their own development
>> environment, have resources and other attributes that have to be maintained.
> 
> As I understand it, almost everything in OS X avoids requiring
> resource forks nowadays.  You'll probably be okay.

*Almost* being the key word. :)  The things that do use them, rely on them heavily, and cause me great headaches.  But yes as of 10.6, there is a major push to get away from resource forks.  Though I do not see extended attributes going away any time soon.  However, some softwares are just too legacy, and developers either too stubborn, or too set in a code base that is too hard to manage to get out of resource forks.  I know of one software, that I believe that if resource forks were EOL'd, that developer would probably bring them back by writing his own resource fork management tools within the app.

At any rate, thank you very much for all your advice and pointers.  Sounds like I just need to jump in and start using git.  I can look at git hub later if and when I want to publicly distribute my work.  First step, get up to speed on the commands I need to know to at least check in and how to step a few revisions back if need be.

Thank you so much.
-- 
Scott * If you contact me off list replace talklists@ with scott@ * 

From: Paul Franz <thefranz@comcast.net>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 13:49:46 -0400
Message-ID: <46F6A73A.3010203@comcast.net>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>	<46F5318A.4030103@krose.org> <877imishdp.fsf@catnip.gol.com>	<46F55E03.2040404@krose.org>	<5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>	<20070923020951.GF24423@planck.djpig.de>	<20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz>	<e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>	<20070923104525.GC7118@artemis.corp>	<e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com> <85zlzdo3ch.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 19:50:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZVak-0007TX-8i
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 19:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbXIWRtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 13:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbXIWRtz
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 13:49:55 -0400
Received: from alnrmhc14.comcast.net ([204.127.225.94]:59005 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619AbXIWRty (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 13:49:54 -0400
Received: from paul-franzs-computer.local (c-69-136-89-103.hsd1.pa.comcast.net[69.136.89.103])
          by comcast.net (alnrmhc14) with ESMTP
          id <20070923174953b1400opbbve>; Sun, 23 Sep 2007 17:49:54 +0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <85zlzdo3ch.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58971>

To me the methods that an OO class defines is the same thing as an API.  
And you can screw up an API whether it is C++ or C. Both give you the 
same opportunity to screw up the model and create code that needs to be 
re-written.

Paul Franz

David Kastrup wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
>   
>> On 9/23/07, Pierre Habouzit <madcoder@debian.org> wrote:
>>     
>>>> Object oriented languages creates black boxes: that's the reason
>>>> why object oriented exsists and also the reason why Linus hates
>>>> it ;-)
>>>>         
>
>   
>>> So please stop with this myth. And don't speak for people, I would
>>> be very surprised that Linus would dislike "black
>>> boxes". Abstractions are good, when used wisely, and I would be
>>> much surprised to see Linus pretend otherwise.
>>>       
>> From a Linus recent thread:
>>
>>     
>>> In other words, the only way to do good, efficient, and system-level
>>> and portable C++ ends up to limit yourself to all the things that
>>> are basically available in C. And limiting your project to C means
>>> that people don't screw that up, and also means that you get a lot
>>> of programmers that do actually understand low-level issues and
>>> don't screw things up with any idiotic "object model" crap.
>>>       
>> Perhaps I have misunderstood, but the idea I got is that for Linus
>> OO brings in more problems than what it tries to fix.
>>     
>
> I read that as OO bringing in more programmers capable of creating
> problems than those capable of fixing them.
>
> It is not the fault of OO in itself, but it is the bottom line that
> counts: if it draws the wrong audience for the wrong reasons, it
> better had great benefits to offset that.  Not quite unsimilar with
> communism: the idea is great in principle, but the idea has no
> built-in self-check.  Capitalism, in contrast, is a distasteful idea
> at its heart, but it is rooted soundly in individual egoism.  Which
> does not make it any less distasteful, but at least it tends to work.
>
>   

-- 

-------------------------------------------

There are seven sins in the world.
     Wealth without work.
     Pleasure without conscience.
     Knowledge without character.
     Commerce without morality.
     Science without humanity.
     Worship without sacrifice.
     Politics without principle.

   -- Mohandas Gandhi

-------------------------------------------

From: Patrick Renaud <prenaud76@gmail.com>
Subject: Re: The GitTogether
Date: Fri, 10 Aug 2012 10:42:50 -0400
Message-ID: <CAC+LNEQB-B5L2CV2pONsOyD-VE4SW36c9SKxdOcYGBQbA-d4hQ@mail.gmail.com>
References: <CAP2yMaJzJyw=9DqJzUXkkQjz_jcqB4pH=FfHFRiftC9=yC7dvg@mail.gmail.com>
	<87k3xpe8bz.fsf@thomas.inf.ethz.ch>
	<50155CD9.6060702@web.de>
	<5016894C.7020907@drmicha.warpmail.net>
	<5023E77E.4020604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 16:43:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzqQU-0000Bc-IE
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 16:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758325Ab2HJOmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 10:42:53 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62906 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758271Ab2HJOmv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 10:42:51 -0400
Received: by yhmm54 with SMTP id m54so1651628yhm.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=upb+FC+NLacf7Ympxrx/jviZ0j2eIJGiPIpxj2XrDZk=;
        b=rFXlX2vJsXzsn1s9Ci9kAitDiLmtjfOyFF8fINqWj4T3nWh1GH2JjE8Xgii8Piy67E
         SIq8XaiPggG7HnxRV2+0YSyEnCPA9O8kriNUJ/U1keCo0vviGJtQeXPXYAtLSKbP6UIm
         4kujpaxhe0ufPldop24iXHfJMGKu9RmRGXhcCB4bkw6a5AQ0G/Ftu3YaCz1hAcjv6gYv
         iK5wSDbyYbFtDu9vLml5igyyzPAmd7RNxZDNmviXjpGyh/RTl6OY9MAnU9Ob5kpRq9+5
         dTF+YSrvdy1YmrmIWrOpKDxYv4PM6lovPAGsVst8eLsUDwy0Oh3ofR88bLus44nHJUxG
         jFoQ==
Received: by 10.60.169.138 with SMTP id ae10mr4565778oec.7.1344609771014; Fri,
 10 Aug 2012 07:42:51 -0700 (PDT)
Received: by 10.182.67.1 with HTTP; Fri, 10 Aug 2012 07:42:50 -0700 (PDT)
In-Reply-To: <5023E77E.4020604@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203218>

Hi,

I am not sure to understand why having two physically disconnected
events, in time and in place. Personally I'd rather see one event,
maybe longer than the previous occurrences to accommodate for the user
and developer centric topics. Along this line, maybe it would be best
to begin the event with the user-centric topics for a couple of days
and then continue with a few more days for the core developers to
discuss how to implement the features highlighted by the user
community, as well as other topics of interest for core devs. The
users could decide to join the rest of the event and listen-in the
core dev topics, or go back home.

Sadly, I am not a core dev. However I do appreciate the close contact
the GitTogether event so far gave to development concerns. From a
user's standpoint being exposed to that was an eye opener, something
that is impossible when dealing with a proprietary solution provider.
Under the new proposed approach I am afraid that we would start seeing
the beginning of a formal separation between Git users: devs vs users.
And I would bet that core devs would stop showing up at the user event
and vice-versa, and thus create that continental divide that was so
far absent in the Git community, which contributes to making Git so
great.

Scott, I believe you and I discussed this at last year's GitTogether
and we both thought the time had come for a user event. But I am not a
fan of making two completely disconnected events the way it is
proposed here. And as for Berlin vs Mountain View, my vote goes to
Mountain View but I'll go wherever the event is held.

On 9 August 2012 12:38, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Michael J Gruber venit, vidit, dixit 30.07.2012 15:17:
>> Jens Lehmann venit, vidit, dixit 29.07.2012 17:55:
>>> Am 27.07.2012 13:45, schrieb Thomas Rast:
>>>> Scott Chacon <schacon@gmail.com> writes:
>>>>
>>>>> GitHub would like to volunteer to organize and pay for these events
>>>>> this year.  I would like to hold the developer-centric one in Berlin
>>>>> in early October
>>
>> Winter term classes start 10/15. Before 10/15 it will be easier to book
>> university rooms if we need that.
>>
>>>>
>>>> Yay, Berlin!  I would be glad to join there; I would probably not have
>>>> the time and resources to travel to SF this year.
>>>
>>> Same here.
>>
>> Same.
>>
>> Do we have contacts regarding (un)conference rooms in Berlin already? I
>> might be able to ask around.
>>
>>>
>>>>> For those of you who *have* been to a GitTogether, what did you find
>>>>> useful and/or useless about it?  What did you get out of it and would
>>>>> like to see again?  For those of you who have never been, what do you
>>>>> think would be useful?  I was thinking for both of them to have a
>>>>> combination of short prepared talks, lightning/unconference style
>>>>> talks and general discussion / breakout sessions.
>>>>
>>>> I was at the 2010 GitTogether in Mountain View.  I really liked the
>>>> unconference format, and the way Shawn and Junio used it: just using the
>>>> topic stickers as a sort of todo-list, not actually fixing any schedule
>>>> in advance.  Oddly enough we also managed to avoid the usual consequence
>>>> of open-ended discussions: getting stuck endlessly on an absolutely
>>>> insignificant point.
>>>
>>> Yup, the unconference format with both common and breakout sessions
>>> worked really well.
>>>
>>>> I think the discussions were very productive.  I would love to do more
>>>> hacking than we managed in 2010, but I realize that this is not possible
>>>> if we just meet for 2-3 days.  Perhaps one option would be to plan for
>>>> 1-2 days of hacking after the discussion rounds, so that the interested
>>>> people can stay a bit longer?
>>>
>>> I really like that idea and would vote for 3-4 days (maybe including a
>>> weekend for those of us who have to take a leave from work ;-).
>
> While the unconference format is successful, may I suggest a
> track/topic: Especially if there's GitHub support and participation this
> would be a good opportunity to discuss some GitHub specific issues in
> person rather than via the list or support tickets. Two come to my mind:
>
> 1) GitHub for Git developers: I certainly don't suggest a change in
> workflow for git.git, but you often hear Git developers say "we can't do
> this or that on GitHub", and I think GitHub (and other projects using
> GitHub) could benefit from the specific point of view and input of Git
> developers to improve workflow support on GitHub.
>
> 2) git-scm.com: The old Git website and wiki certainly did not quite
> meet GitHub's demands (e.g. reliability, looks), and git-scm.com
> certainly does not quite meet the/all Git developers demands (e.g. list
> discussion based decisions and actions, separation between the "free
> project" and "business related content). In person it may be easier to
> find a way forward which benefits all parts of the large and undefined
> "Git community".
>
> Cheers,
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
-Patrick

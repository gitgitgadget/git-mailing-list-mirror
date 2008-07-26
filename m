From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Official Git Homepage change? Re: git-scm.com
Date: Fri, 25 Jul 2008 23:43:55 -0700
Message-ID: <d411cc4a0807252343n2b9ade68veaebb68664f0a3d7@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <20080726015314.GU32184@machine.or.cz>
	 <20080726020951.GV32184@machine.or.cz>
	 <7v4p6dnv5k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 08:45:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMdWY-0001NS-MH
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 08:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbYGZGn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 02:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbYGZGn5
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 02:43:57 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:32704 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbYGZGn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 02:43:56 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2303251waf.23
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 23:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nVVq+o2eO8LDRShOqFhD72wbuUKJe79gyqlXjjohXJ4=;
        b=o7lycI96KMPfOGQfrCH6VqhiqqBmQEx/fHXeBQi/q5LNDndPXDHFug6w1SEpmVJtki
         qf9qOCXvnOKPUvuG3j9LAUSGGoiwq66N+r7QT2Btnn+2U4g0oPEciS52ysrw7mNcHKms
         nq/jhBwrusMvpDBaJU2nr0mzyCk4imb0JWDVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kv8ukOtfOTGJ1sdebZZNc9fDkwFiSNVigPsVQTVY26eBpZetElCfoqpl2qUfol57Z5
         2a7SgPaReSIE0xxwL5dEhcgvyi5WZBuyszfUhfczMPZ6rQs7udE7w9YLqTg6GBYO9fSO
         pPpMMhdWvZv7Bf2JtLCa42xgNKOHBtOxziKYU=
Received: by 10.114.178.13 with SMTP id a13mr2931927waf.158.1217054635540;
        Fri, 25 Jul 2008 23:43:55 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Fri, 25 Jul 2008 23:43:55 -0700 (PDT)
In-Reply-To: <7v4p6dnv5k.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90185>

On Fri, Jul 25, 2008 at 9:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Petr Baudis <pasky@suse.cz> writes:
>
>> .... Of course, I would be transferring the control of the homepage
>> from my hands so I would like to poll the community about how do people
>> feel about this - opinion of core Git contributors would be especially
>> welcome...
>> ...
>>   - The new site is affiliated with a commercial entity - GitHub.
>> The website maintainer also has commercial interest in some published
>> Git learning materials, which might generate certain conflict of
>> interests; we must trust them that they handle this well.
>>   - Both GitHub and Scott seem to be rather distanced from the "core"
>> Git development community. This might or might not be an issue.
>
> These two are directly related.  They might be friendly and well-meaning
> folks, but I agree that they haven't earned our trust yet.
>
> But I do not think it matters that much.
>
> The thing is, git.or.cz may have been the closest thing to the "official"
> homepage we have had, but that is not because Linus or I or Shawn declared
> the site is official and/or that the site is trustworthy.  It was because
> you put efforts preparing the contents worthy to be one-stop shop for git
> related information, back when there was no such thing.  And the members
> of the comminity found it a good site.  And you have the wiki there, where
> there truly have been community participation to enhance the contents.
>
> For me personally, pages outside the wiki have never felt like "the
> official git homepage", not because the contents you prepared were
> inadequate, but because I did not see much community participation to help
> enrich it.
>
> So I wish the new site success, but the definition of success from my
> point of view is not how many random visitors it will attract, but how
> well the site makes the contributors (both to git software itself, and to
> the site's contents) feel welcomed.  Maybe in time it will become
> successful enough by _my_ definition of success, and I may recommend
> kernel.org folks to point at it from http://git.kernel.org/ (link with
> text "overview") if/when that happens, and I may start mentioning them in
> the "Note".  We'll see.
>
>>   The negatives section writeup is longer, but in fact I think the
>> positives win here; I also have a bit of bad conscience about not giving
>> git.or.cz the amount of time it would deserve...
>
> Let me thank you for maintaining not just git.or.cz/ but also repo.or.cz/
> and the wiki.  I personally never visited the "Homepage" but the
> repositories and the wiki are valuable services you gave back to the
> community.
>
> It's also somewhat interesting to observe that several people I have never
> heard of in the git circle are simultaneously doing new git books,
> apparently never asking for much technical advice from core git people, by
> the way.
>

To be honest, I have asked for a fair amount of technical advice from
many helpful people in the IRC channel over the past few years.  In my
case, one of my best friends - the guy I've been working with for the
last 4 years - is Nick Hengeveld, who has something like 50 commits in
there - why email the list when I can yell a question over the cube
wall?  I'm sure you all have more important things to do than review
my book for newbies - I asked Nick to do it.

If I could code C worth a lick, I'm sure I would have contributed more
to this list, but since I have nothing that I feel would be helpful to
you, I've passively followed the list.  I'm sorry that you do not
consider me a "git community member" just because I don't code C, and
so I can't contribute helpfully to core.

However, I have evangelized Git in person to literally thousands of
people, and tens of thousands more online.  GitHub hosts over 10,000
public git projects completely for free, and has contributed a ton
back to the community, both in code and proselytization efforts.

I hope these things can be taken as proof that we are not simply
friendly and well meaning, but that we have contributed meaningfully
to the adoption of Git and are just as committed to it's improvement
and success as nearly anyone on this list.

We want to help - help you with resources, help new people learn git
quickly and easily, and help the unconverted see the light.  We highly
respect you guys and most of the time you don't hear from us because
we don't want to bother you and take your time away from improving our
favorite tool.

Feel free to contact or email me at any time with questions, or
suggestions for improvement - schacon on IRC, schacon at gmail, or
thescottchacon on AIM.

Scott

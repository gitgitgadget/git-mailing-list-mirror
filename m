From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Promoting Git developers (was: Bashing freelancers)
Date: Tue, 10 Mar 2015 12:51:32 +0100
Message-ID: <CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 12:51:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVIhH-0004JB-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 12:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbbCJLvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 07:51:35 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34767 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbCJLvd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 07:51:33 -0400
Received: by iecsl2 with SMTP id sl2so11361022iec.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9OTU3dKSR92L2p1K5BYhV+MmBddk/qbCRTrpQYugkLY=;
        b=oXnVho6PSkVPI16pr59dcHZSp2D23C7lhNeMgESuttZe9NBorEasWOH+ZyAP1aEH2H
         ecblfAcxRLAheBCiOGEOF4BvlgY9Z3H8O77ZOmj6P3tIW4GVrRHDMZfcIypzVu6qbjBO
         CiBYJwSyk8ZcTFSwgU+IgalmyAX5cb5PDAlWIvOS4D8eI1nKr9qsP7Rt87zpbF6uCgg4
         97qQ3vQumncIBO/XmVUN8WpLy7nJb0K2KXq7oEUDZN+7OwoDhBPdXhdLMIC0xq7tqYnm
         S0DEladZnVSwoFpDyzWYzCkfP5kMdvGpQc2fe8ytHJFMnLAovZU9I/5yYklRYMrLKje7
         LZhw==
X-Received: by 10.50.129.9 with SMTP id ns9mr54985588igb.24.1425988292696;
 Tue, 10 Mar 2015 04:51:32 -0700 (PDT)
Received: by 10.50.245.144 with HTTP; Tue, 10 Mar 2015 04:51:32 -0700 (PDT)
In-Reply-To: <54FDA6B5.8050505@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265230>

On Mon, Mar 9, 2015 at 2:57 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Christian Couder venit, vidit, dixit 07.03.2015 08:18:
>> Hi,
>>
>> On Fri, Mar 6, 2015 at 6:41 PM, David Kastrup <dak@gnu.org> wrote:
>>
>>> At some point of time I think it may be worth reevaluating the toxi=
c
>>> atmosphere against freelancers doing Git development.
>>
>> My opinion on this is that the Git community has not been good
>> especially lately at promoting its own developers.
>>
>
> I guess we have at least 3 kinds of people here:
>
> A) Paid to do Git development, at least as part of their job.
> B) Freelancers who don't get paid directly for "doing git" but hope t=
o
> profit from their git efforts directly or indirectly.
> C) Doing it in their freetime (or as minor, inofficial part of their
> non-programming job).
>
> I'm in camp C and honestly wasn't aware of camp B until now.
>
> I consider camp A to be beneficial for all of us, and I don't think
> specific employer interests have pushed the project in specific
> directions, or specific features (OK, maybe one, but not as a rule).
>
> I do see that remuneration is an issue for camp B.

=46irst thank you for responding to my email. It is great to see that
some developers are interested in talking about this.

I am in camp C and I think the people in all the camps are beneficial
for all of us.

>> Some facts:

[...]

I don't want to write again about each of these points now. I am more
interested in discussing a good strategy to try to revert the sad
trend of Git developers being promoted less and less, because I think
that it is really very important.

>> None of these facts is a big issue in itself for me, but I think the
>> trend is very sad, and I would be happy if we could discuss here or =
at
>> the Git Merge (or both) about ways to improve in this area.
>
> There should be a good occasion, after we see how it went, and hopefu=
lly
> also to sort out any apparent misunderstandings from the past that ha=
ve
> resurfaced in this thread.
>
> Maybe, all we need is badges? [1]
>
> [1] https://badges.fedoraproject.org/

My opinion is that the big issue is that we should all realize how
important it is to promote the Git developers.

There are people who say out there that GitHub succeeded mostly
because they easily allowed developers to build a portfolio. I think
there is some truth in that. And I think GitHub also says to
developers that it's good for them to have a nice GitHub portfolio and
to employers that it's good for them to hire people who have a nice
GitHub portfolio.

This shows that the success of GitHub (and so of Git too) is based in
part on promoting Open Source / Free Software developers.

So why don't we try to do it more (instead of less) and how could we
do it more (instead of less) for the Git developers?

Yesterday evening I attended a Docker meeting in Paris [1] where
J=C3=A9r=C3=B4me Petazzoni a Docker developer working for Docker gave a=
 talk
about Docker storage drivers. In the middle of his talk there were at
least 2 slides dedicated to thank some developers who helped make
Docker work with different filesystems or operating systems. And
J=C3=A9r=C3=B4me did stop at least twice to thank these people in the m=
iddle of
his talk.

Wouldn't his talk have been smoother if he had not done that? So why
did he do that?

This reminded me about the following great talk by Julien Barbier the
Community and Marketing guy at Docker:

http://www.slideshare.net/julienbarbier42/community-marketing-42674728

I had seen this talk last december at another Docker meetup in Paris
(and I think it really worth reading the slides or attending the talk
if Julien gives it again and you can go).

The slides and the talk keep repeating some sentences because they are
worth repeating. Some of these sentences are:

* It is about what you can do for your community
* Belonging, recognition, respect, love
* Add more links to your community
* Your product is not what you say it is, it is what THEY say it is
* It's all about people

It is especially interesting to have a look at slide 5 where they say
that "Community is the new marketing" and that Community is 80+% of
their marketing.

And it's true that they are really doing a lot for their community.
=46or example the meeting yesterday evening was the 19th docker meeting
in Paris in two years.

And then there is slide 20 about "Content Strategy" where there is:

* Encourage your community to build content
  - Say thank you, repost, post, upvote, RT, include them in your
newsletter, itw them, =E2=80=A6
  - Belonging, Recognition, Respect, Love

* Your team is your community too!
  - Say thank you, gamify, hall of fame, tweet, post, recycle, etc=E2=80=
=A6
  - Belonging, Recognition, Respect, Love

So we can see that "saying thank you" is a big part of their content st=
rategy.

And are they successful? Yes, they are very successful as an open
source project [2] and as a company.

Now it's up to us, either we keep coming up with excuses not to
promote developers, or we decide to do something about it.

Best,
Christian.

[1] http://www.meetup.com/Docker-Paris/events/220891955/
[2] http://stackshare.io/posts/how-docker-manages-its-massive-open-sour=
ce-project

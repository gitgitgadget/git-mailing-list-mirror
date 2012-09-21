From: Shawn Pearce <spearce@spearce.org>
Subject: Re: The GitTogether
Date: Fri, 21 Sep 2012 07:05:53 -0700
Message-ID: <CAJo=hJtFdrFWBjg6v9ggFVSYN=_-vy6UWWW_6ay4W=E02Wqxcg@mail.gmail.com>
References: <CAP2yMaJzJyw=9DqJzUXkkQjz_jcqB4pH=FfHFRiftC9=yC7dvg@mail.gmail.com>
 <5059CC01.2080205@alum.mit.edu> <505B662B.2040709@gmail.com> <CAP8UFD0KiNzfNOAaAA_y8ha6LOjzJXQP4G2hTyYfouYAUBTD0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Patrick Renaud <prenaud76@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 16:06:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF3s9-0001Ny-9D
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 16:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab2IUOGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 10:06:16 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:49480 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab2IUOGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 10:06:15 -0400
Received: by qaas11 with SMTP id s11so1262147qaa.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hheQWxOMFd7ZGrJbs3jHIB7N4OjZD35A6mdcsN93RbM=;
        b=KRxSwXWhoZ3mVJ4KcQSuxiVzhs8nbw+52A3qodK+XdeyzAIA/8DRqcc88TQ1Q+UK5v
         j3tuS8IBI6s6Tm89HU3EhEXYFfHF7EpIPBGMmHSudl6AOj3k15PceCoFqBlHOS2Em6sE
         2tw2erV5P/+F3LCOf5Z2xRo4Kn7uExZeEGFTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=hheQWxOMFd7ZGrJbs3jHIB7N4OjZD35A6mdcsN93RbM=;
        b=M1pjFso4KlYIosCzbVAEMUDqNBxtutKDEa6dls/q2WfKWK+gx2MipPpofONPkk2qgJ
         hsxZuOsNLw/UEXUw6T/Iu14hCDdaZlEvVN4Ob/EqpPw7ofE/Ok5J66G6T7LyHEJqSdpJ
         efeOX2bBEj6LcHC5Y6QZ/pWgtcN2ilc5jwpfIVbPj5wgru/rEniIZtfJMduNhjvkHnpy
         xPXXqYXWpmIhMBDepDzunRm4Wp4BZ8qv6khIJd3kzQIWtqOPt3Za3R6nMX+5TLzdD0XU
         2Ul+jcM9h8D06V30+gF5iIXJwA0rS4WeZZEcZVYIRNr1+/MRJ7Ef7UXMrkAiOpwSKP/l
         4lNQ==
Received: by 10.229.135.136 with SMTP id n8mr3417323qct.42.1348236374007; Fri,
 21 Sep 2012 07:06:14 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Fri, 21 Sep 2012 07:05:53 -0700 (PDT)
In-Reply-To: <CAP8UFD0KiNzfNOAaAA_y8ha6LOjzJXQP4G2hTyYfouYAUBTD0w@mail.gmail.com>
X-Gm-Message-State: ALoCoQnYeSU61eVXhKgbY19+uKD+jIE9nEv5fW6H3wK4tdk7QtWYgY3aKPDqCFW+soHpYaDRZ6po
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206120>

On Fri, Sep 21, 2012 at 2:20 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Sep 20, 2012 at 8:53 PM, Sebastian Schuberth
> <sschuberth@gmail.com> wrote:
>> On 19.09.2012 15:43, Michael Haggerty wrote:
>>
>>> Is there any news about the proposed gatherings?  I would be quite
>>> interested in attending the developer meeting.  October is just around
>>> the corner...what's up?
>>
>>
>> I'm also very much interested in attending a gathering Berlin, though
>> preferably not in the first week of October. As I'm a local, I could
>> probably also help with finding a location if necessary.
>
> In this thread:
>
> https://groups.google.com/forum/?fromgroups=#!topic/repo-discuss/_MCrS4FjZak
>
> there is a message by Shawn with the following:
>
> -------------------------------------------
>
> On Sun, Sep 2, 2012 at 12:27 PM, Luca Milanesio
> <luca.mi...@gmail.com> wrote:
>>
>> Does anybody have info about the next GitTogether 2012 ?
>
> Google is not hosting GitTogether this year. There may be a Git
> gathering in the EU sometime early next year, organized by GitHub.
>
>> (candidate dates ? place ? # of days ?)
>>
>> We should plan flights, (and possibly hackathons) in advance in order to get maximum availability :-)
>
> Instead... Google is looking into hosting a 2 day Gerrit user
> conference followed immediately by a Gerrit developer hackathon in
> early November. Nothing concrete yet, but we are working on it, and
> trying to make sure we have enough lead time for people to book an
> affordable flight.
>
> -------------------------------------------
>
> It is sad that people who know what is or what is not happening are
> not taking care of letting people on this list know about it...

I did not post to this mailing list about the Gerrit Code Review user
summit because I did not consider it to be on-topic to this list. We
do not normally discuss Gerrit Code Review here. Most users and
developers on this list only work on git-core (aka git.git aka the
thing Junio maintains). Gerrit... is a different animal. :-)

If you are interested in attending, it is Saturday November 10th and
Sunday 11th in Mountain View, CA. The user summit is invite only, but
you may request an invitation at http://goo.gl/5HYlB.


I have no further information about the potential GitTogether than
anyone else. IIRC there is a suggestion in this thread about hosting
something in the EU sometime in early next year, with someone at
GitHub acting as organizer.

Google chose to run only a Gerrit user summit this year because of the
mix of attendees at the last GitTogether. The group was about 60-70%
Gerrit users/admins. We felt it was time to host something specific
for that audience.

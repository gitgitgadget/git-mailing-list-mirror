From: Patrick Renaud <prenaud76@gmail.com>
Subject: Re: The GitTogether
Date: Fri, 21 Sep 2012 12:43:44 -0400
Message-ID: <CAC+LNER-ePWTBGb5H=R-9P_c+MmCF-tTsH+JMJDSNhVv9YHDSQ@mail.gmail.com>
References: <CAP2yMaJzJyw=9DqJzUXkkQjz_jcqB4pH=FfHFRiftC9=yC7dvg@mail.gmail.com>
	<5059CC01.2080205@alum.mit.edu>
	<505B662B.2040709@gmail.com>
	<CAP8UFD0KiNzfNOAaAA_y8ha6LOjzJXQP4G2hTyYfouYAUBTD0w@mail.gmail.com>
	<CAJo=hJtFdrFWBjg6v9ggFVSYN=_-vy6UWWW_6ay4W=E02Wqxcg@mail.gmail.com>
	<CAP8UFD0DWe3JM20PznrR5ssyf4V-RgOKF-p4K04ptXTppc3VGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Pearce <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 18:43:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF6KY-0008Q5-Tu
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 18:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756525Ab2IUQnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 12:43:46 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:41663 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407Ab2IUQnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 12:43:45 -0400
Received: by oago6 with SMTP id o6so3529995oag.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mEInZYk7azCZYQGmkNen25J4IJN/gi7oVWPJtvc1sqs=;
        b=SBIpvQ78lCmc4AMLRoa1BqftxZJyGqxS4HUcFtvyx8pJQ84yKtx9Fc0gfMtb/t/OrA
         5VY3i2c4DQWX+Ex1PA+vKEuRsEUA2euxStWNHbxUKfcwO9AFkMjISEKG+PikRtUWDiyD
         gPXfXpWeFbwbtzd/GQlASO907JijsMra7X7sycUD2smnIpXHnrx2NmjjDjgyy8mj4S7x
         PjSKsOIbck7RXomBz8v2mqztQh2lt0/i/AjWRFz1aEva6nBy3kRrk/sxrofMGC/5zZ1b
         E5pzXgUeChpfjux+I47XghSpVXzTMI068/EInwwKxm1YNkDuDe2tzqYqcFBbZqxrr/7r
         io+Q==
Received: by 10.60.7.104 with SMTP id i8mr4224865oea.31.1348245824765; Fri, 21
 Sep 2012 09:43:44 -0700 (PDT)
Received: by 10.182.166.1 with HTTP; Fri, 21 Sep 2012 09:43:44 -0700 (PDT)
In-Reply-To: <CAP8UFD0DWe3JM20PznrR5ssyf4V-RgOKF-p4K04ptXTppc3VGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206130>

Guys,

Are we still talking of having two disconnected events for Git, one
for core devs and one for users?

-Patrick

On 21 September 2012 11:23, Christian Couder <christian.couder@gmail.com> wrote:
> On Fri, Sep 21, 2012 at 4:05 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> On Fri, Sep 21, 2012 at 2:20 AM, Christian Couder
>>
>>> It is sad that people who know what is or what is not happening are
>>> not taking care of letting people on this list know about it...
>>
>> I did not post to this mailing list about the Gerrit Code Review user
>> summit because I did not consider it to be on-topic to this list. We
>> do not normally discuss Gerrit Code Review here. Most users and
>> developers on this list only work on git-core (aka git.git aka the
>> thing Junio maintains). Gerrit... is a different animal. :-)
>
> It would have been nice if you had said earlier on this list/thread
> that Google chose to host a Gerrit user summit instead of the
> traditional GitTogether.
>
>> If you are interested in attending, it is Saturday November 10th and
>> Sunday 11th in Mountain View, CA. The user summit is invite only, but
>> you may request an invitation at http://goo.gl/5HYlB.
>
> Thanks for the information. I think it is indeed interesting to know about it.
>
>> I have no further information about the potential GitTogether than
>> anyone else. IIRC there is a suggestion in this thread about hosting
>> something in the EU sometime in early next year, with someone at
>> GitHub acting as organizer.
>
> Before I posted what you wrote on the Gerrit mailing list, the only
> information people had on this list/thread was about a GitHub proposal
> to organize 2 different GitTogether: "the developer-centric one in
> Berlin
> in early October (a few weeks before the Mentor Summit this time) and
> the user one in January or February of next year."
>
>> Google chose to run only a Gerrit user summit this year because of the
>> mix of attendees at the last GitTogether. The group was about 60-70%
>> Gerrit users/admins. We felt it was time to host something specific
>> for that audience.
>
> Gerrit users/admins are probably Git users/admins too. But anyway, it
> is ok of course for Google to organize whatever it prefers.
> I hope GitHub will do as good a job running a GitTogether as Google did.
>
> Thanks,
> Christian.

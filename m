From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Sun, 23 Sep 2012 01:09:03 -0700
Message-ID: <7v39292mao.fsf@alter.siamese.dyndns.org>
References: <201107252233.02088.jnareb@gmail.com>
 <201109031738.11678.jnareb@gmail.com>
 <CAMP44s2ZSKx3jDZOSX7EM2bYtuUvvEctZYw6R3wNWQEbCeX4Rw@mail.gmail.com>
 <201109141939.14070.jnareb@gmail.com>
 <CAMP44s31xx5qfF4-f3kGsa1uEe7TMVmqSDvB9zL=prR12xwM6g@mail.gmail.com>
 <CANQwDwfVM+besf2if-z6UT6K1QYfj7A7jXsEgfyfxJ1Ww9oBdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 10:10:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFhGb-0001hm-2R
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 10:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab2IWIJS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 04:09:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51690 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337Ab2IWIJH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2012 04:09:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8A5D61DF;
	Sun, 23 Sep 2012 04:09:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IpBQJCY3nrsA
	CwGG/MqcFv3oeVk=; b=sT0rEfObRHZLxbQnrfhdT5/CjfOOXZJ/xQSRUJzKVQnM
	yeul3HEKI4OMrEj8phR/8UzGyg/CmAMx2YtIpDkEyWbCADmqchuG632d5sIpkTMj
	38vrEY5Gw8Hvgy5jN63E3Y78l7Yfc/LBOudGdKmwD0gyRylgNK6Hf/r0smjMs7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TfMb7u
	QgVpD0O9FhhIWtany19drDTFcLtJdvANltVtGq9LsQQABlxuyDkHejXhcnkfShaz
	zPZe9wRqw7ro3DtBBzLw5or7v7kG6d+gH3wcaKtVslshyH8/SvDGb44iSdHhOVbm
	gJE4eK28eqVZVwlT3z3gMI7d131gpAVVRY2wk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B60F261DE;
	Sun, 23 Sep 2012 04:09:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E424061DD; Sun, 23 Sep 2012
 04:09:04 -0400 (EDT)
In-Reply-To: <CANQwDwfVM+besf2if-z6UT6K1QYfj7A7jXsEgfyfxJ1Ww9oBdA@mail.gmail.com> ("Jakub
 =?utf-8?Q?Nar=C4=99bski=22's?= message of "Sun, 23 Sep 2012 00:45:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F112A108-0555-11E2-B0F0-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206222>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> I have created short (well, at least shorter than previous ones)
> "Git User's Survey 2012" on Survs.com.  The test channel is
>
>   https://www.survs.com/survey/J87I3PDBU4
>
> Note that all answers in this channel would be deleted.
>
> I was thinking about running this survey for about three weeks, from
> 24 September to 14 October 2012.  The current premium unlimited plan,
> a gift from Survs.com admins, is valid till 26 October.  I don't know=
 if it
> would be prolonged; it usually was.
>
> As to what is involved in running survey: if we want and would be abl=
e to
> use Survs.com, one should register there, and I can add them to "git"
> account as a member with admin rights.

Thanks for getting the ball rolling again this year.

A few comments.

  #5. Given that 1.8.0 will ship on Oct 21st, this may want to
      include 1.8.0 as well.

  #7. Stop "backup", and leave that to 'other (please specify)'.
      Also, "Frontend to other SCM" feels somewhat out of place.  It
      would be interesting to see how "work vs personal" and "native
      vs foreign" are correlated, for example, but this format does
      not let you measure it.

 #12. I am not sure why EGit applies and Eclipse doesn't.  Is it
      like saying "vc.el applies but Emacs doesn't" (the former is
      the interface, the latter is 'the other side' the interface
      connects git to")?  If so it makes sense to me, but if EGit is
      the only interface used to connect to Eclipse, perhaps it does
      not help people who answer these questions to say this.

 #13. This list is intelligible, at least to me.  "git add" but not
      "git rm"?  What is "incremental add / commit"?  "git add -p"?
      Is it worth asking about "update-index"?

      It may be simpler to condense the questionaire down to the
      following three questions:

      - Do you use command line tool to build commit?
        [Always/Often/Sometimes/Never]

      - When you do, do you build the next commit incrementally with
        "git add [-p]" and run "git commit" without the "-a" option?
        [Always/Often/Sometimes/Never]

      - What do you use if you do not commit with the command line?
        GUI? IDE/Editor? FileManager? Web?

 #21. (nit) Isn't ProGit one of the "printed books (or ebooks)"?

I think the questions are designed to gauge the individual users
(proficiency, background, etc.), but I think it would be interesting
to see what kind of projects they are using Git for, but not in
vague terms like #7 does.

Even within "work projects - code", it would be enlightening to see
a bit more details, e.g. Are they building phone app?  Controlling
nuclear reactors?  Bioinformatics?  How big is their team?  How is
the project structured, e.g. a central repository where everybody
pushes into?  Workers push to submission branches that are reviewed,
approved and merged by the official committers?  Use of continuous
integration?  Issue tracker integration?

     =20

From: Illia Bobyr <ibobyr@blizzard.com>
Subject: Re: Newbie grief
Date: Fri, 4 May 2012 17:17:30 +0000
Message-ID: <4FA40F2A.7070109@blizzard.com>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com>
 <201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com>
 <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
 <4FA2D8EA.7030809@palm.com> <87obq5ggpu.fsf@an-dro.info.enstb.org>
 <7vehr1dl2z.fsf@alter.siamese.dyndns.org> <4FA307C5.102@palm.com>
 <4FA3090D.5080406@palm.com> <4FA32A6A.4070007@blizzard.com>
 <CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com>
 <1167779eee7d442b9db0eecb347d5516-mfwitten@gmail.com>
 <7vmx5ocyc3.fsf@alter.siamese.dyndns.org>
 <1336126182.3490.28.camel@beez.lab.cmartin.tk>
 <CA+7g9Jx20q6C8JqrcrmbWhYNH1K35Gwp_BAckjM=8qg1kMwU4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Fri May 04 19:17:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQM8R-0006qa-5W
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 19:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab2EDRRd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 13:17:33 -0400
Received: from mx10.blizzard.com ([12.130.201.12]:15474 "EHLO
	mx10.blizzard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab2EDRRc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 13:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=blizzard.com; i=ibobyr@blizzard.com; q=dns/txt;
  s=mail; t=1336151852; x=1367687852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LipNSXIsTtbtuC8gOtTQduCJh/1GfHvYB+8NmlYQkCg=;
  b=v0DCjkXHAaF8qFUNTzcRffEaD5dWwQhy5lINk52nAK5n/uIMyNF6Rpdo
   t01DeGvo9qbicySNlCZk9HHCsfafgSD77xIiJ8aQXmSq0k+hXUqIVgst6
   UlGDLkx7NXi22v7VSdKSDlDRAL0YV5evGvfTgBui5HAN4jrJp9y/O3hlV
   8=;
X-IronPort-AV: E=Sophos;i="4.75,532,1330934400"; 
   d="scan'208";a="3277917"
Received: from irvex205.corp.blizzard.net ([10.130.14.26])
  by mx10.blizzard.com with ESMTP; 04 May 2012 10:17:32 -0700
Received: from IRVEX022.corp.blizzard.net (10.130.1.157) by
 IRVEX205.corp.blizzard.net (10.130.14.26) with Microsoft SMTP Server (TLS) id
 14.1.289.1; Fri, 4 May 2012 10:17:31 -0700
Received: from IRVEX008.corp.blizzard.net ([fe80::c5f9:f4ad:53fc:4d4b]) by
 IRVEX022.corp.blizzard.net ([10.130.1.157]) with mapi id 14.01.0289.001; Fri,
 4 May 2012 10:17:31 -0700
Thread-Topic: Newbie grief
Thread-Index: AQHNKWoSOzhARVRq9kmPhVkDfom0zpa4kKFRgACLeICAAAGHgIAAJ8UAgAAkv4CAABcYAP//mHhMgADE3ACAAG6+AIAACMgA
In-Reply-To: <CA+7g9Jx20q6C8JqrcrmbWhYNH1K35Gwp_BAckjM=8qg1kMwU4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.129.238.124]
Content-ID: <3217C93F0C98B744BDCE158475128FC2@blizzard.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197039>

On 5/4/2012 9:46 AM, Nathan Gray wrote:
> On Fri, May 4, 2012 at 3:09 AM, Carlos Mart=EDn Nieto<cmn@elego.de>  =
wrote:
>> On Thu, 2012-05-03 at 22:25 -0700, Junio C Hamano wrote:
>>> Michael Witten<mfwitten@gmail.com>  writes:
>>>
>>>> As for a seemingly conservative suggestion, how about using a litt=
le
>>>> more structural white space:
>>>>
>>>>    To $uri_for_central_repo
>>>>     ! [rejected]        HEAD ->  feature_0 (non-fast-forward)
>>>>
>>>>    error: failed to push some refs to '$uri_for_central_repo'
>>>>
>>>>    To prevent you from losing history, non-fast-forward updates we=
re rejected
>>>>    Merge the remote changes (e.g. 'git pull') before pushing again=
=2E  See the
>>>>    'Note about fast-forwards' section of 'git push --help' for det=
ails.
>>>>
>> Most of the first sentence repeats what we can see above. Restating =
that
>> non-ff updates were rejected doesn't add information and doesn't hel=
p
>> people who don't already know what a non-ff update is, so it's eithe=
r
>> redundant or not helpful[0]. So lets see if we can come up with a
>> friendlier way of saying it. Maybe something like:
>>
>>     To $uri_for_central_repo
>>     ! [rejected]        HEAD ->  feature_0 (non-fast-forward)
>>
>>     error: failed to push some refs to '$uri_for_central_repo'
>>
>>     Some updates which might rewrite history and lose someone else's
>>     changes were rejected. Merge those changes (e.g. 'git pull') to
>>     incorporate that history. See the 'Note about fast-forwards' sec=
tion
>>     of 'git push --help' for details.
>>
>> It may be a bit longer, but if you don't know what a non-ff is or wh=
y
>> it's a problem, this text should help you a lot more than the previo=
us
>> one did. Not reading the documentation (specially when the error mes=
sage
>> points you to a specific section for a longer explanation) is still =
no
>> excuse for not known what's going on, but if you've been working on =
your
>> own for a while, you might have forgotten what this is all about.[1]
> The whitespace that Michael introduced is a big help, for starters,
> and this rewording is also a nice step forward.  I'm still not
> thrilled about the "rewriting history" verbiage -- that makes it soun=
d
> like the user did something super risky and was rescued by the system=
=2E
>   Here's my suggestion for replacing the last paragraph:
>
>    Some of your branches are out of date.  Merge the remote changes
> (e.g. 'git pull') then try again.
>
> It's short and easy to scan.  It has no git-specific jargon that new
> users would be unfamiliar with.  There's no reference to fast-forward
> updates so no need to refer the user to that help section.  What do
> you think?

Not everybody is a new user :)
Throwing away a precise explanation for the purpose of avoiding a=20
possible confusion for someone who either just started (and will have t=
o=20
learn the terms anyway) or for someone who does not really care to lear=
n=20
is a decision that I would weight very carefully.

Just as I side note, I lead a team of an ordinary developers through a=20
transition from CVS to Git and there were pretty much fine with the fac=
t=20
that there are pieces in such a complex system as Git that they do not=20
understand immediately.  Over a couple of month everyone who cared or=20
required this knowledge knew what a fast-forward is.  And people who di=
d=20
not care just learn to do git pull as the message suggests.

I think that a reference to the documentation is very nice.  I remember=
=20
that this kind of references allowed me to learn Git gradually as I was=
=20
facing different usage scenarios instead of reading the whole=20
documentation for all the tools.
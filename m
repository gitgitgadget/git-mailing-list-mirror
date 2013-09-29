From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Local tag killer
Date: Sun, 29 Sep 2013 06:29:45 +0200
Message-ID: <5247ACB9.40208@alum.mit.edu>
References: <52327E62.2040301@alum.mit.edu>	<CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>	<xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com>	<523D3FD2.4090002@alum.mit.edu>	<20130924075119.GD7257@sigill.intra.peff.net>	<alpine.LFD.2.03.1309251834210.312@syhkavp.arg>	<5246C975.1050504@alum.mit.edu> <CALKQrgeJn1J4ntE_2Lr7Et+Oao=vB1FE6nLfaFJOvLHJLzG9tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmk=?= =?UTF-8?B?ZXRv?= 
	<cmn@elego.de>, Michael Schubert <mschub@elegosoft.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Sep 29 06:29:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ8dn-0002Vt-NS
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 06:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073Ab3I2E3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 00:29:52 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:63037 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750889Ab3I2E3v (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Sep 2013 00:29:51 -0400
X-AuditID: 1207440f-b7f306d000006d99-e3-5247acbe9d55
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DA.2F.28057.EBCA7425; Sun, 29 Sep 2013 00:29:50 -0400 (EDT)
Received: from [192.168.69.9] (p57A25F5B.dip0.t-ipconnect.de [87.162.95.91])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r8T4Tjpl003125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Sep 2013 00:29:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CALKQrgeJn1J4ntE_2Lr7Et+Oao=vB1FE6nLfaFJOvLHJLzG9tA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsUixO6iqLtvjXuQwYVHMhbTu1azWHRd6Way
	aOi9wmwx7+4uJounnZUW8168YLP40dLD7MDucWndSyaPQ3+msHs8O9HO5nHp5Xc2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO+PD77+sBZ+1K9o/r2RtYFyi1MXIySEhYCKx7/Zp
	ZghbTOLCvfVsXYxcHEIClxklTv3qZAdJCAmcYZJom8IEYvMKaEp0fX0AFmcRUJXYuWknmM0m
	oCuxqKcZrEZUIERi4arj7BD1ghInZz5hAbFFgOp3PP4FtoBZYAGTxKy9N9hAEsICshJrN59l
	gtjcxCzx4PE3RpAEp0CgxLP+lUDncQB1qEusnycEEmYWkJfY/nYO8wRGgVlIdsxCqJqFpGoB
	I/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0TvdzMEr3UlNJNjJBI4N/B2LVe5hCjAAejEg9v
	hJd7kBBrYllxZe4hRkkOJiVR3iXLgEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeD2nAeV4UxIr
	q1KL8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK8d1cDNQoWpaanVqRl5pQgpJk4
	OEGGc0mJFKfmpaQWJZaWZMSDIjW+GBirICkeoL2PQdp5iwsSc4GiEK2nGHU5mjat+sooxJKX
	n5cqJc77EaRIAKQoozQPbgUs7b1iFAf6WJh3OkgVDzBlwk16BbSECWjJrQo3kCUliQgpqQZG
	80R7Fa8XmQ+fTOFKFUnQsV3ftlRpxXOugwzlGx/OTemQ3lp1bjWD06J4q9hYoXO+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235579>

On 09/28/2013 11:42 PM, Johan Herland wrote:
> On Sat, Sep 28, 2013 at 2:20 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> [...]
>> Nicolas made the two best arguments for the necessity of
>> separate tag namespaces per remote in *some* form:
>> [...]
> 
> I'd also like to mention my initial motivation for the proposal: a
> natural way to organize other types of remote refs (notes, replace
> refs, etc.). The separate tag namespace came about as a natural
> (and IMHO quite useful) consequence of the proposed reorganization
> of refs/remotes/*.

ACK.

>> Other discussion and open issues regarding a ref namespace reorg:
>>
>> * What exactly would be the ambiguity rules for references with the same
>>   name that appear in multiple remotes' namespaces?
>>
>>   * Are references to two annotated tags considered the same if they
>>     refer to the same SHA-1, even if the annotated tags are different?
>>     What about an annotated vs an unannotated tag?  The consensus
>>     seemed to be "no".
>>
>>   * Do they depend on how the reference is being used?  Yes, sometimes
>>     only a SHA-1 is needed, in which case multiple agreeing references
>>     shouldn't be a problem.  Other times the DWIM caller needs the
>>     full refname (e.g., "git push" pushes to different locations
>>     depending on whether the source is a branch or tag), in which case
>>     the rules would have to be more nuanced.
> 
> Could we try to classify all ref lookups as either ref _name_ lookups
> (in which case only a single, matching full refname is acceptable), or
> ref _value_ lookups (in which case multiple matching names are allowed,
> as long as they all point to the same SHA-1)? There are some complicated
> cases (e.g. describe) which needs more thought, but if we can agree on
> a mechanism for dealing with all the simpler cases, that might help
> inform how to deal with the complicated ones.

Yes, name vs. value lookups is a useful distinction.

> [...]
>> * How would somebody (e.g., an interim maintainer) suck down tags from
>>   a project into his own refs/tags/* namespace?  (Would it even be
>>   necessary?)
> 
> I'm not convinced it would be necessary. I have yet to see a case where
> a (suitably unambiguous) remote tag would not fulfill the same purpose
> as the equivalent local tag. The only exception is for dealing with
> ambiguous remote tags, where a local tag could be created to serve as a
> tie-breaker.

I guess I was wondering how the interim maintainer would get Junio's
tags into his public repo (which he would want to do, so that users can
get everything from a single clone).

I think that the new version of "git push --tags" should *not* push all
tags from all remotes; it should push only refs/tags, like now.  So I
was thinking that the interim maintainer would want to import Junio's
tags into his own namespace, then

    git push --tags $URL

But I guess it would be cleaner just to push using an explicit refspec:

    git push $URL 'refs/remotes/origin/tags/*:refs/tags/*'

>> [...]
>> * How would this help somebody who wants to fetch content from multiple
>>   projects (e.g., git, gitk, gitgui) into a single repo?  There might
>>   be tags with the same names but very different meanings, and it would
>>   be awkward if there were ambiguity warnings all over the place.
>>   [Would it work to configure the fetching repo something like
>>
>>   [remote "gitk-origin"]
>>           fetch = refs/tags/*:refs/remotes/gitk-origin/tags/gitk/*
>>
>>   and to refer to a hypothetical gitk tag "v1.2.3" as "gitk/1.2.3"?
>>   Admittedly this is somewhat ambiguous with the proposed DWIM pattern
>>   <REMOTE>/<TAGNAME>.]
> 
> Only if you also had a remote called "gitk". ;)

True.

> An alternative way to solve the problem of many ambiguity warnings:
> If we define the rules so that local tags always override remote tags,
> you could simply fetch the tags from your preferred remote into your
> local tag namespace (as discussed above).
> 
> Personally, I would rather set up the configuration like this:
> 
>   [remote "gitk"]
>           fetch = refs/tags/*:refs/remotes/gitk/tags/*
> 
> (i.e. keeping the default refspec) and then use "gitk/v1.2.3",
> "git/v.1.2.3", "gitgui/v1.2.3" to disambiguate between the tags.

But if there were more than one remote providing gitk tags, it would be
difficult to grab a tag without caring where it came from.  And where
would I create a local gitk-scope tag?

I wonder whether remotes.group could sensibly be used to group remotes
into logical groups for value lookups:

    [remotes]
            gitk = gitk-origin
            gitk = second-gitk-repo

Then DWIM could be taught to seek "gitk/foo" under
"refs/remotes/gitk-origin/tags/foo" and
"refs/remotes/second-gitk-repo/tags/foo" in addition to
"refs/tags/gitk/foo" (insisting, of course, that if more than one of
these are present that they are all consistent).

Remote groups might also be used to configure the remotes that describe
considers when describing a commit:

    [remotes]
            describe = junio
            describe = jrn

or maybe (using the above config)

    git describe --remote-group=gitk

>> [...]
>> @Johan, I know that you were working on the ref-namespace issue at
>> GitMerge.  Did your work get anywhere? Are you still working on it?
> 
> I posted [...]

Thanks for your comments, and for the status update!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

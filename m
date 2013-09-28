From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Local tag killer
Date: Sat, 28 Sep 2013 14:20:05 +0200
Message-ID: <5246C975.1050504@alum.mit.edu>
References: <52327E62.2040301@alum.mit.edu> <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com> <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com> <523D3FD2.4090002@alum.mit.edu> <20130924075119.GD7257@sigill.intra.peff.net> <alpine.LFD.2.03.1309251834210.312@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>
To: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Sep 28 14:20:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPtVU-0003g9-DD
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 14:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585Ab3I1MUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 08:20:17 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55613 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752835Ab3I1MUO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Sep 2013 08:20:14 -0400
X-AuditID: 12074414-b7fb46d000002a4d-42-5246c97c6532
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C4.C4.10829.C79C6425; Sat, 28 Sep 2013 08:20:12 -0400 (EDT)
Received: from [192.168.69.9] (p57A248D5.dip0.t-ipconnect.de [87.162.72.213])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r8SCK5vZ030207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 28 Sep 2013 08:20:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <alpine.LFD.2.03.1309251834210.312@syhkavp.arg>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsUixO6iqFtz0i3IoH+ilcX0rtUsFl1Xupks
	GnqvMFvMu7uLyeJpZ6XFvBcv2Cx+tPQwO7B7XFr3ksnj0J8p7B7PTrSzeVx6+Z3N41nvHkaP
	i5eUPT5vkgtgj+K2SUosKQvOTM/Tt0vgzrh/YhJLwWObivY1R5gaGL/qdzFyckgImEj03NnO
	CGGLSVy4t56ti5GLQ0jgMqPEifYVTCAJIYGzTBJPZvmC2LwC2hI3ZrxhA7FZBFQlDn1+xgpi
	swnoSizqaQarFxUIkVi46jg7RL2gxMmZT1hAbBGBbImPX3+ygixgFljLKDHlwFGwzcICshJr
	N59lgtg8l0ni1/eNYBs4BWwk5h89A9bNLKAj8a7vATOELS+x/e0c5gmMArOQLJmFpGwWkrIF
	jMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUKiQWQH45GTcocYBTgYlXh4
	D8xwDRJiTSwrrsw9xCjJwaQkymt9yC1IiC8pP6UyI7E4I76oNCe1+BCjBAezkgiv/wygHG9K
	YmVValE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQimKwMB4eSBO/1E0CNgkWp6akVaZk5JQhp
	Jg5OkOFcUiLFqXkpqUWJpSUZ8aBojS8GxitIigdo732Qdt7igsRcoChE6ylGY46mTau+MnJs
	WrvmK6MQS15+XqqUOO8jkFIBkNKM0jy4RbA0+IpRHOhvYd7DIFU8wBQKN+8V0ComoFW3KsBW
	lSQipKQaGINCTnA+8j+p3LawgE1kb+i02MKXZyryKjzmhd3cqm2XZGvD0c1/Nsl5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235502>

On 09/26/2013 12:54 AM, Nicolas Pitre wrote:
> On Tue, 24 Sep 2013, Jeff King wrote:
>> I think most of this problem is the way that we fetch tags straight into
>> the refs/tags hierarchy. You would not do:
>>
>>   [remote "origin"]
>>   fetch = +refs/heads/*:refs/heads/*
>>   prune = true
>>
>> unless you wanted to be a pure-mirror, because you would hose your local
>> changes any time you fetched. But that is _exactly_ what we do with a
>> refs/tags/*:refs/tags/* fetch.
>>
>> If we instead moved to a default fetch refspec more like:
>>
>>   [remote "origin"]
>>   fetch = +refs/*:refs/remotes/origin/refs/*
>>
>> Then everything would Just Work. [...]
> 
> I remember participating to a discussion about this like 2.5 years ago:
> 
> http://news.gmane.org/group/gmane.comp.version-control.git/thread=165799
> 
> The flat tag namespace remains my major annoyance with git IMHO.

I just reviewed that old thread to determine its relevance to the
present discussion.  For the benefit of the other readers, here is a
summary of the main points that I got out of it.

The main proposal under discussion was that of Johan Herland:

    http://article.gmane.org/gmane.comp.version-control.git/165885

Nicolas made the two best arguments for the necessity of
separate tag namespaces per remote in *some* form:

> The extraordinary misfeature of the tag namespace at the moment
> comes from the fact that whenever you add a remote repo to fetch,
> and do fetch it, then your flat tag namespace gets polluted with all
> the tags the remote might have.  If you decide to delete some of
> those remote branches, the tags that came with it are still there
> and indistinguishable from other tags making it a real pain to sort
> out.
>
> -- http://article.gmane.org/gmane.comp.version-control.git/166108

and

> Let's take the OpenOffice vs LibreOffice as an example.  What if I
> want both in my repository so I can easily perform diffs between
> those independent branches?  They may certainly end up producing
> releases with the same version numbers (same tag name) but different
> content (different tag references).
>
> -- http://article.gmane.org/gmane.comp.version-control.git/166749

Other discussion and open issues regarding a ref namespace reorg:

* What exactly would be the ambiguity rules for references with the same
  name that appear in multiple remotes' namespaces?

  * Are references to two annotated tags considered the same if they
    refer to the same SHA-1, even if the annotated tags are different?
    What about an annotated vs an unannotated tag?  The consensus
    seemed to be "no".

  * Do they depend on how the reference is being used?  Yes, sometimes
    only a SHA-1 is needed, in which case multiple agreeing references
    shouldn't be a problem.  Other times the DWIM caller needs the
    full refname (e.g., "git push" pushes to different locations
    depending on whether the source is a branch or tag), in which case
    the rules would have to be more nuanced.

  * Should the same ambiguity rules be applied to other references
    (e.g., branches)?

  * What if a branch and a tag have the same name?

    * Nicolas Pitre suggested that usually they should be accepted if
      they have the same value, and if the refname matters then the
      branch should take precedence (with a warning).

    * Peff pointed out that currently dwim_ref prefers tags, but that
      Junio has said that that behavior was arbitrary [and by
      implication could be changed].  He suggested:

      > For dwim_ref, it prefers the tag and issues a warning. For
      > git-push, it complains about the ambiguity and dies. For git
      > checkout, we prefer the head. For git-tag, we prefer the tag
      > (though I think that only matters for "git tag -d").
      >
      > -- http://article.gmane.org/gmane.comp.version-control.git/166290

* What should "name-rev", "describe", "--decorate" output?  See
  discussion here:

      http://article.gmane.org/gmane.comp.version-control.git/165911

* "fetch" should probably warn if it ends up fetching a tag with the
  same name (according to the refname disambiguation rules) but value
  that conflicts with an existing tag in a different namespace.

* Do we need some pathspec modifier (e.g., "~") to specify that the
  corresponding references should be auto-followed in the manner
  currently done for refs/tags/*?  Or is auto-following maybe not
  needed at all anymore?:

      http://article.gmane.org/gmane.comp.version-control.git/160726

  Junio thought, and Johan agreed, that tag auto-following should still
  be done for repositories that use the old ref namespace format.  But
  perhaps this could be special-cased via a config setting rather than
  built into the refspec syntax.

* How would somebody (e.g., an interim maintainer) suck down tags from
  a project into his own refs/tags/* namespace?  (Would it even be
  necessary?)  Should there be a tool for this?  [It seems to me that
  something like

      git fetch . refs/remotes/origin/tags/*:refs/tags/*

  would do the trick, as long as pruning were turned off.]

* What special handling (if any) is required for
  refs/remotes/$REMOTE/HEAD?

  * According to Junio, HEAD is meant to indicate which branch is the
    "main" branch of the remote.  It is not transferred via the
    protocol, but rather guessed at by the client's "clone" process:

        http://article.gmane.org/gmane.comp.version-control.git/166694
        http://article.gmane.org/gmane.comp.version-control.git/166740

* How would this help somebody who wants to fetch content from multiple
  projects (e.g., git, gitk, gitgui) into a single repo?  There might
  be tags with the same names but very different meanings, and it would
  be awkward if there were ambiguity warnings all over the place.
  [Would it work to configure the fetching repo something like

  [remote "gitk-origin"]
          fetch = refs/tags/*:refs/remotes/gitk-origin/tags/gitk/*

  and to refer to a hypothetical gitk tag "v1.2.3" as "gitk/1.2.3"?
  Admittedly this is somewhat ambiguous with the proposed DWIM pattern
  <REMOTE>/<TAGNAME>.]

* It might be nice to have a command like

      git push $REMOTE --interactive

  that allows the user to choose interactively which branches/tags to
  push

  -- http://article.gmane.org/gmane.comp.version-control.git/166700

I hope that saves somebody the time of reading the whole thread
(though admittedly my summary is not especially short either).


As far as I can tell, the division of tags into remote-specific
namespaces would be another way of preventing the problem of tags being
pruned too aggressively.  But given that such a big change would be a
huge development effort, implementing something like the following
might be a quicker fix and would not conflict with a hypothetical
future ref namespace reorganization:

1. Limit "git fetch --prune" to only pruning references that are under
   refs/remotes/*

2. Add a new option --prune-tags that removes the above limitation

3. And the above two changes would make this one possible: Change the
   meaning of the --tags option to mean "fetch all tags *in addition
   to* (rather than *instead of*) the references that would otherwise
   be fetched".

Comments?

@Johan, I know that you were working on the ref-namespace issue at
GitMerge.  Did your work get anywhere?  Are you still working on it?
Have you documented somewhere any new insights that you have gained
about the problem space?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

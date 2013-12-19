From: Johan Herland <johan@herland.net>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 19 Dec 2013 16:26:18 +0100
Message-ID: <CALKQrgeiVSPhe84xTnKQ6iAmN3UX_Jy77pgp5ieSwFQ21tWPFg@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
	<CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
	<20131212042624.GB8909@thyrsus.com>
	<CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
	<52B02DFF.5010408@gmail.com>
	<CALKQrgf3kuXRpbWmSp_nk8+zDFYNzkgV+dSBHaBbmUkxqjaDUA@mail.gmail.com>
	<20131217145809.GC15010@thyrsus.com>
	<CALKQrgeegcsO7YVqEmQxD4=HfR4eitodAov0tEh7MRvBxtRKUA@mail.gmail.com>
	<20131217184724.GA17709@thyrsus.com>
	<52B2335D.2030607@alum.mit.edu>
	<CALKQrgdin=8h9dr=h+VfGjX3suOGRXNsvzzcF=_L9cQDYtKPgg@mail.gmail.com>
	<52B2BCF9.5080300@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Raymond <esr@thyrsus.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 19 16:26:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtfUg-0005rV-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 16:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab3LSP03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 10:26:29 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:44643 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab3LSP0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 10:26:25 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VtfUU-000426-TK
	for git@vger.kernel.org; Thu, 19 Dec 2013 16:26:22 +0100
Received: from mail-pd0-f174.google.com ([209.85.192.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VtfUU-000BRX-EB
	for git@vger.kernel.org; Thu, 19 Dec 2013 16:26:22 +0100
Received: by mail-pd0-f174.google.com with SMTP id x10so1250116pdj.33
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 07:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZYlZyoz9lnYRy33+YURfFirhupv7+dwxpsraMiaVJyQ=;
        b=XUcmi/7bRldBF31pJP2VlIBZRjnY1MHKbfCKnl0A/VxLgklVQBzjf685RP8njdbkNA
         6EZRY9ku13O5AXeEHsv9jOH5a0Q8Xj0P5x7AqQw8O7NjZB/GRA0XAbgznmj6GZIkHIrW
         zuem0ywy7PbU1HpaCFE57KslZLYD1Ai6dRr0x2Jis2+yqrVlYZ2HTQamUbpiQ8kjUylj
         Lv1eJ+omUGT2psMW9W6CajY9v9JFQsD7sEpQf1otolJSMu5Zgax2AVqH4JevI1cGJN/J
         cHXIM8VZULA5u8nhPbXBkjgEQ3H3ksZfOV/FPPSZJUj/GkdVOyQqoS7FBvRa75+9f+IQ
         MuQQ==
X-Received: by 10.68.130.130 with SMTP id oe2mr2260683pbb.135.1387466778302;
 Thu, 19 Dec 2013 07:26:18 -0800 (PST)
Received: by 10.70.24.228 with HTTP; Thu, 19 Dec 2013 07:26:18 -0800 (PST)
In-Reply-To: <52B2BCF9.5080300@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239522>

On Thu, Dec 19, 2013 at 10:31 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 12/19/2013 02:11 AM, Johan Herland wrote:
>> On Thu, Dec 19, 2013 at 12:44 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> A correct incremental converter could be done (as long as the CVS users
>>> don't literally change history retroactively) but it would be a lot of work.
>>
>> Although I agree with that sentence as it is stated, I also believe
>> that the parenthesized condition rules out a _majority_ of CVS repo of
>> non-trivial size/history. So even though a correct incremental
>> converter could be built, it would be pretty much useless if it did
>> not gracefully handle rewritten history. And in the face of rewritten
>> history it becomes pretty much impossible to define what a "correct"
>> conversion should even look like (not to mention the difficulty of
>> actually implementing that converter...).
>
> A correct conversion would, conceptually, take a diff between the old
> CVS history and the new CVS history (I'm talking about the history as a
> whole, not a diff between two changesets), figure out what had changed,
> and then figure out what Git commits to make to effect the same
> conceptual changes in Git-land.
>
> This means that the final Git history would have to depend not only on
> the current entirety of the CVS history, but also on what the CVS
> history *was* during previous incremental imports and how the tool chose
> to represent that history in Git the previous rounds.
>
> There is a tradeoff here.  The smarter the tool is, the fewer
> restrictions would have to be made on what people can do in CVS.  For
> example, it wouldn't be unreasonable to impose a rule that people are
> not allowed to move files within the CVS repository (e.g., to fake
> move-file-with-history) after the CVS <-> Git bridge is in use.  (Abuses
> of the history that occurred *before* the first incremental conversion,
> on the other hand, wouldn't be a problem.)  If the user of the
> incremental tool has *no* influence on how his colleagues use CVS, then
> the tool would have to be very smart and/or the user would might
> sometimes be forced to do another from-scratch conversion.

Agreed, but I find it quite ugly how the git history will end up
different depending on _when_ the incremental conversion is run. It
means that it will be impossible for two users to create the same Git
repo (matching SHA1s), unless they carefully synchronize all of their
conversion runs (at which point it's much simpler to run a single
conversion and then have both users fetch the result).

There is a continuum here in incremental converters:

At one end - given that you're always going to lose _some_ history -
you can go "screw it! let's not care about history at all!", and do
the fastest possible conversion: check out the current CVS version;
diff that against the previous CVS version; apply the diff to your Git
repo as a single commit. I suspect quite a lot of users would be happy
with this solution - at least as a temporary measure while they wait
for their surrounding organization to do a proper migraiton off CVS.

At the other end - you can realize that the CVS storage format on the
server is simply too lossy, and you can write a proxy or monitor that
intercept CVS operations on the server, and replicate those in a
companion Git repo as soon as they occur in CVS. Whether you write a
CVS server monitor that detects changes to the CVS server files in
real time (using e.g. inotify or similar), or you write a CVS server
proxy that intercepts CVS commands from the user (also forwarding them
to the _real_ CVS server) is an implementation detail[*]. The
important thing is you should end up with is a real-time stream of
changes that can be converted to corresponding changes in a Git repo.
That should give you closest possible picture of what really happens
in a CVS repo, even better than what CVS stores in its on-disk format.
This would allow an organization to provide a (read-only) Git mirror
of their CVS repo.

What we have been discussing in this thread (various strategies for
fixing up broken history in Git) can be considered intermediate points
between the two extremes presented above: You try to recreate as much
history as possible, but realize that you sometimes need to simply
synthesize some fake history in order to make everything fit together.

>> Here are just a couple of things a CVS user can do (and that happened
>> fairly regularly at my previous $dayjob) that would make life
>> difficult for an incremental converter (and that also makes stable
>> output from a non-incremental converter hard to solve in practice):
>>
>>  - A user "deletes" $file from $branch by simply removing the $branch
>> symbol on $file (cvs tag -B -d $branch $file). CVS stores no record of
>> this. Many non-incremental importers will see $file as never having
>> existed on $branch. An incremental importer starting from a previously
>> converted state, must somehow deal with that previous state no longer
>> existing from the POV of CVS.
>
> No problem; the tool could just add a synthetic commit "git rm"ming the
> file from the branch.  It wouldn't know *when* the file was deleted, so
> it would have to pick a plausible date between the time of the last
> incremental conversion and the one that discovers that the branch tag
> has been removed from the file.  The resulting Git history would contain
> more complete information than CVS's history.

A server proxy/monitor analyzing CVS operations in real time would
know _exactly_ when the file was removed...

>>  - A user moves a release tag on a few files to include a late bugfix
>> into an upcoming release (cvs tag -F -r $new_rev $tag $file). There
>> might be no single point in time where the tagged state existed in the
>> repo, it has become a "Frankentag". You could claim user error here,
>> and that such shortcuts should not happen, but that doesn't really
>> prevent it from ever happening. Recreating the tree state of the
>> Frankentag in Git is easy, but what kind of history do you construct
>> to lead up to that tree?
>
> Frankentags (tags that include file versions that didn't occur
> contemporaneously) can occur even with one-time CVS->Git conversions.
> The only way to handle them is to create a Git branch representing the
> tag and base it at a plausible Git commit, and then (on the branch)
> issue a fixup commit that makes the contents of the branch equal to the
> contents of the CVS branch.  This is a problem that cvs2git already handles.
>
> A hypothetical incremental importer would have to notice the changes in
> the branch contents between the previous conversion and the current one,
> and create commits on the branch to bring it in line with the current
> contents.  This is no uglier than what a one-shot conversion already has
> to do.

True, but analyzing CVS operations in real time, you might be able to
recreate the moving (and adding/deleting) of tags as file edits (and
adds/deletes) in the corresponding Git branch.

>>  - A modularized project develops code on HEAD, and make regular
>> releases of each module by tagging the files in the module dir with
>> "$modulename-$version". Afterwards a project-wide "stable" tag is
>> moved on that subset of files to include the new module release into
>> the "stable" tag. ("stable" is conceptually a branch, but the CVS
>> mechanism used here is still the tag, since CVS branches cannot
>> "follow" eachother like in Git). This is pretty much the same
>> Frankentag scenario as above, except that in this case it might be
>> considered Best Practice (it was at our $dayjob), and not a
>> shortcut/user error made by a single user.
>
> Same problem and same solution as above, as far as I can see.
>
>> (None of these examples even involve the "cvs admin" which allows you
>> to do some truly scary and demented things to your CVS history...)
>
> Even some of these might be permitted.  For example:
>
> * Obsoleting already-converted revisions: it's a pretty stupid thing to
> do in most cases and the tool could just ignore such events, retaining
> the history in Git.  If the revisions were obsoleted because they
> contained proprietary information or something, then you've got a bigger
> problem on your hands but one that you would have even if you were using
> pure Git.
>
> * Retroactive changes to log messages: would probably have to be ignored
> or handled via notes.
>
> * Changes to the "default branch" (another brain-dead CVS feature
> related to vendor branches): I'd have to think about it.  But handling
> vendor branches is already difficult for a one-time converter because
> CVS retains too little info (but cvs2git does it except in the most
> ambiguous cases).  An incremental importer would have *more* information
> than a one-shot importer, because it would have a hope of catching the
> change to the default branch at roughly the time it occurred.

Agreed, but if you want correct metadata (_when_ did these changes
happen, _who_ performed them), then you need to actually monitor the
CVS command stream (or CVS server files) in real time...

>> My point here is that people will use whatever available tools they
>> have to solve whatever problems they are currently having. And when
>> CVS is your tool, you will sooner or later end up with a "solution"
>> that irrevocably rewrites your CVS history.
>
> Yes, but I maintain that an incremental importer could keep a Git
> history that is consistent with the CVS history in the sense that:
>
> 1. the result of checking out any branch or tag, right after a run of
> the importer, gives the same results as checking the same branch or tag
> out of CVS.
>
> 2. the Git history from one run is added to (never rewritten) by the
> next run.

Yes, and even my simplest/fastest possible converter described above
can meet those criteria. After that, it really becomes a question of
_how_much_ CVS history you want to retain in your incremental import.
I have described the two extremes above. Interestingly, _both_ of
those extremes would look quite different from the
whole-history-gone-incremental converters represented by cvs2git and
cvs-fast-export, and _both_ of the extremes would probably also
provide a converted result quite a bit faster than anything in between
(one by virtue of depending on a single "cvs update" command, and the
other by monitoring the CVS server and performing the conversion to
Git in real time).


...Johan


[*]: That said, I suspect git-cvsserver would be a good starting point
for implementing a CVS server proxy, if someone is actually interested
in looking at this...

-- 
Johan Herland, <johan@herland.net>
www.herland.net

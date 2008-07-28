From: "Tom Werner" <pubsub@rubyisawesome.com>
Subject: Re: git-scm.com
Date: Mon, 28 Jul 2008 11:12:49 -0700
Message-ID: <530345950807281112w45215c16k49ffe240d41c6a9e@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <7v3alxr0fd.fsf@gitster.siamese.dyndns.org>
	 <d411cc4a0807251759m1d83d7c4w4724806b19f7c02a@mail.gmail.com>
	 <7vsktwfu5z.fsf@gitster.siamese.dyndns.org>
	 <20080727113707.GC32184@machine.or.cz>
	 <7v3alv2n46.fsf@gitster.siamese.dyndns.org>
	 <7vd4kzyoj1.fsf@gitster.siamese.dyndns.org>
	 <46a038f90807271619l69c085a7o58f50b7d64b7222d@mail.gmail.com>
	 <530345950807272011o7c92fdaaw3116cc257dcbab7a@mail.gmail.com>
	 <alpine.DEB.1.00.0807281201350.2725@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 20:14:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNXET-0004WJ-GD
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 20:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbYG1SMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 14:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbYG1SMw
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 14:12:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:59298 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbYG1SMv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 14:12:51 -0400
Received: by wr-out-0506.google.com with SMTP id 69so3958038wri.5
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 11:12:50 -0700 (PDT)
Received: by 10.90.63.15 with SMTP id l15mr7939635aga.79.1217268769761;
        Mon, 28 Jul 2008 11:12:49 -0700 (PDT)
Received: by 10.90.75.3 with HTTP; Mon, 28 Jul 2008 11:12:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807281201350.2725@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90480>

On Mon, Jul 28, 2008 at 3:50 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 27 Jul 2008, Tom Werner wrote:
>> I find it a bit confusing that some here seem to have a strong dislike
>> for GitHub. It's true that we haven't been active on the developer list
>> or in the #git channel on freenode, but we are constantly in #github and
>> have answered a *great* many questions from developers that are new to
>> git.
>
> Speaking for myself, I will probably direct some users from #git to
> #github, then.
>
> The deeper reasoning: if you really do help by that channel, by all means
> I want to provide you with the opportunity to do so.

By all means! The users might be a bit confused about why you're
sending them to #github, but we're happy to help them out if you don't
care to. We actually employ a support person to man the channel and
help out where he can.

>> Perhaps it is the commercial aspect of GitHub that offends.
>
> In my opinion you can be as commercial as you want.  Nevertheless, I would
> like to see some direct benefit for me, too, for obvious reasons.  That
> does not need to be money; like Junio said, watching out for user
> questions on the Git list would already be very useful, in two respects:
>
> - the core developers have more time for hacking on Git itself (which
>  would be good both for the developers as well as for you),

Using this same logic, it follows that we GitHub developers would be
better suited to hacking on GitHub (which would be good for the git
community). There are only so many hours in the day. I've had many a
GitHub user tell me that the GitHub interface and functionality helped
them finally understand git and feel comfortable switching to it from
SVN or CVS. It seems we can help bigger populations of git users by
making the site as clear and easy to use as possible, so that is what
we choose to do.

> - if your advices can be enhanced (such as my gripe that "git show" is not
>  even so much as mentioned, in spite of being _the_ porcelain to inspect
>  objects in Git's object database, not cat-file, whose only role in
>  tutorials can be to shoo new users away) it will be early, which again
>  is a win-win situation for both core developers as well as for you, and

Can you clarify what you are referring to here? I'm not sure I understand.

> - just as in the past, I fully expect the main thrust of the major changes
>  in Git to be driven by user experience (just think of Git 1.5.0), and by
>  driving users away (and indeed, by driving yourself away, a bunch of
>  power-users), you would make that much more unlikely to happen in the
>  future.  So, having you closer to the Git mailing list and #git would
>  again be a win-win situation.

I totally agree with the direction that 1.5 has taken git. You guys
are doing an awesome job with user experience. As I come across
usability problems I'll be sure to bring them up here in the future.

>> Having had to implement a git-daemon replacement that fit our needs, I
>> have some ideas on how to improve git-daemon and fetch-pack with
>> regards to error messages and logging.
>
> I might mention here that I think you are committing one of the biggest
> sins in Open Source: you do not reap the full power of the community.
>
> I am sure, if you would have mentioned your needs first, possibly followed
> by an early version of a patch, git-daemon would already be enhanced to
> your liking, and these enhancements would be available to everyone
> (including me, for example).  But maybe that being available to everyone
> is not in the best interest of a commercial outfit?

The problem is that I'm only a casual C coder. It takes me a while to
figure out what's going on in the git source. We needed a way to serve
public git repositories from a hashed directory structure (e.g.
/a/b/c/user/repo.git) and we needed it fast. In a few days worth of
coding Erlang, I was able to meet that need (and also add logging and
better error messages returned to the client). If I had, as you
suggest, created a badly written patch and asked for help on the list,
I'd probably still be trying to solve the problem. It's dubious that
anyone other than us currently needs to satisfy the hashed directory
requirement, and as such I would not assume or expect that anyone
would be motivated to spend a bunch of time helping a C amateur
satisfy that need. In the end I was responsible for making it work,
and I did that the best and most efficient way I knew how.

Like I said before, I'm happy to share my suggestions for better error
messages and logging behavior, but I'm probably not going to be much
help with providing patches.

>> We like to design from first principles, see how good we can do, and
>> then get feedback from the users.
>
> Maybe this is so contrary to Open Source that many are uncomfortable with
> it.
>
> Also note that one of the major gripe with you making money off of Git
> could be the following: we have over 500 contributors, and most of them --
> first and foremost of all, the two major contributors, Junio and Shawn --
> cannot make money from Git.  Envy is wrong, but it is real.

This is clearly false and does not do Junio or Shawn justice. It's not
hard to imagine that these two (or any of the other contributors)
could make money doing training for git at companies that have adopted
it, or as consultants to firms that use git in novel ways, or as
authors of git books. Scott Chacon gets paid right now to work on
tools that use git as an underlying file system. In fact, by helping
bring corporate interest to git, GitHub is paving the way for more and
more people to make money from git if they so choose. I wouldn't be
surprised if, down the road, Junio could be paid to hack on git full
time via corporate sponsorship. The continuing advancement of git is
of interest to a great many people. Some of which would gladly pay for
it.

Tom Preston-Werner
github.com/mojombo

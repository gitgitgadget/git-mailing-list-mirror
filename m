From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Thu, 2 Dec 2010 20:30:01 +0100
Message-ID: <20101202203001.3793718d@jk.gs>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
	<20101201165043.GF26120@burratino>
	<87r5e1v2g8.fsf@picasso.cante.net>
	<7vzkspuw8g.fsf@alter.siamese.dyndns.org>
	<295D1E95-1C61-4960-8C9C-BDB0BD4A1A50@sb.org>
	<87mxopt8my.fsf@picasso.cante.net>
	<E02740CE-37EE-4701-BB2D-18AD493D1C05@sb.org>
	<87aakpt7uw.fsf@picasso.cante.net>
	<20101202095324.34237fb2@jk.gs>
	<87fwugs7pf.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 20:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POEr8-0005Zb-Rd
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 20:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642Ab0LBTaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 14:30:08 -0500
Received: from zoidberg.org ([88.198.6.61]:58333 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221Ab0LBTaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 14:30:07 -0500
Received: from jk.gs (xdsl-89-0-52-203.netcologne.de [::ffff:89.0.52.203])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 02 Dec 2010 20:30:04 +0100
  id 004002A0.4CF7F3BC.00007AAE
In-Reply-To: <87fwugs7pf.fsf@picasso.cante.net>
X-Mailer: Claws Mail 3.7.7 (GTK+ 2.22.0; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162739>

[Cc unculled again; I will ignore all further posts from you until you
stop culling or explain why you are ignoring all requests to stop
culling.]

--- Jari Aalto <jari.aalto@cante.net> wrote:

> Yes, that's the standard way of doing groups. Just like it's being
> done in other manual pages that are huge. But it is not being done in
> small manual pages. GNU project certainly doesn't in general.

What makes the GNU project the gold standard? They've got some pretty
weird conventions, such as their coding style.

> I agree tat doing "groups" makes only sense on pages that have large
> number of options. For a screenful, it's more distracting than worth.

You are "agreeing with" something I didn't say. That's not very helpful.

> Well. In my experience (having watched others to learn) the manual
> pages are not the source used for learning.

They were for me.

>     - They are technical documentation

I want related things in technical documentation to be grouped.

>     - They are reference documentation

I want related things in reference documentation to be grouped.

>     - They are visited, then discarded, visited and discarded.

Correct. Especially for that reason, I want related things to be
grouped. I don't want to scroll through the entire list of options just
to find everything related to what I want to do.

>     - Someone throws up a git command (IRC #git, Blogs, Web page).
> What do all those unreadable one letter options mean? Gosh they don't
>       even mean the save accross different git* programs.

The only realistic way around that is to stop using 

>       > He searches manual pages A-Z, easy to spot all options. Not
>       > interested in related things. He tries to understand the
>       > command, script etc.

Because everyone always knows whether the desired option is called
--skip-foo, --no-use-foo, --disable-foo, --no-foo, --antifoo or --bar?

In virtually all cases, I know what I want but not the name of the
option. It rarely happens that I know the name of the option but not
what it does.

>       This person just wants to solve a problem, get things done, the
>       faster the better. The easier the better, the less thinking the
>       better.

As mentioned, I believe that alphabetic ordering makes it harder and
take longer.

>       > He digestestes all. Related options, related pages, flipping
>       > form man to man as he knows all the glory details is just
>       > there.

Even then, learning works better if you learn things grouped by
similarities. Alphabetic ordering of the material just makes it harder.
You don't see the English teachers hand out vocabulary lessons in
alphabetic order, do you?

> There are 100+ manual pages in the git distribution. You get even
> disoriented in shere numbers of them. And you have to throw dice to
> figure out in what page that information might be you are currently in
> need.

That is correct, but none of your patches change anything about that.

> It's classical case of how to arrange information for easy retrieval.
> Think Libraries as model.

Have you ever been inside a library? The bookshelves are not ordered
alphabetically. There is a section for physics and a section for
zoology and a section for architecture. That makes it easier to find.

In fact, even before the advent of computers, the catalogs of libraries
were available in two forms: alphabetically ordered (which only helps
if you know the exact name of what you are looking for) and ordered by
category (which is pretty much the only way to find something if you
don't know exactly what you want, unless you want to read the whole
catalog back to front).



In any case, we can go around in circles forever on this. Our opinions
are different, and if we don't accept each others' arguments, nothing
will ever come of this. The next stage in a productive discussion is to
either stop bothering or to produce evidence. If you have any
scientific evidence that alphabetically ordered lists make it easier to
find things the names of which you don't know, I'll be happy to look at
it.

-Jan

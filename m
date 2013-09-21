From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Local tag killer
Date: Sat, 21 Sep 2013 08:42:26 +0200
Message-ID: <523D3FD2.4090002@alum.mit.edu>
References: <52327E62.2040301@alum.mit.edu> <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com> <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 21 08:49:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNH0c-0001t7-SZ
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 08:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551Ab3IUGtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 02:49:35 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55035 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752266Ab3IUGte (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Sep 2013 02:49:34 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Sep 2013 02:49:34 EDT
X-AuditID: 12074411-b7f3e6d0000034d1-01-523d3fd8b49e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id C6.36.13521.8DF3D325; Sat, 21 Sep 2013 02:42:32 -0400 (EDT)
Received: from [192.168.69.9] (p4FDD42BF.dip0.t-ipconnect.de [79.221.66.191])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r8L6gRPl001755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 21 Sep 2013 02:42:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqHvD3jbI4MVWCYvpXatZLLqudDNZ
	NPReYbaYd3cXk8XTzkoHVo9L614yeRz6M4Xd49LL72weFy8pe3zeJBfAGsVtk5RYUhacmZ6n
	b5fAnfFwRTtTwT+piq7WS0wNjM9Euxg5OSQETCS2nbzFDmGLSVy4t56ti5GLQ0jgMqPEz3sH
	mUESQgJnmSSerlTsYuTg4BXQlujtLAAJswioSqxrecUKYrMJ6Eos6mlmArFFBcIkdkyfyAZi
	8woISpyc+YQFxBYRUJOY2HaIBWQ+s8B2Ronb+yaCLRYWkJVYu/ksE8Ti+YwS3/ZMAuvgFLCW
	+HX1LdhUZgEdiXd9D5ghbHmJ7W/nME9gFJiFZMksJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqs
	W5ycmJeXWqRrqpebWaKXmlK6iRES4oI7GGeclDvEKMDBqMTD+zDEJkiINbGsuDL3EKMkB5OS
	KK+HpW2QEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHee3eAynlTEiurUovyYVLSHCxK4rx8S9T9
	hATSE0tSs1NTC1KLYLIyHBxKEryH7ICGChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZk
	xINiNb4YGK0gKR6gvc9tgNp5iwsSc4GiEK2nGHU5mjat+sooxJKXn5cqJc57HGSHAEhRRmke
	3ApYQnvFKA70sTDvDZAqHmAyhJv0CmgJE9CSUwusQJaUJCKkpBoYF717F5nBkhe0alu052OB
	CVGTFUI3t93e/ecDc/KHjFWVAoJOc5h+L9ruLRfTkfRSxCjj8/XcJ5ohJyJ1C8VX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235094>

On 09/21/2013 12:51 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster-vger@pobox.com> writes:
> 
>> I also agree that the documentation is misstated; "remote-tracking branch"
>> may have been a convenient and well understood phrase for whoever wrote
>> that part, but the --prune is designed to cull extra refs in the
>> hierarchies into
>> which refs would be fetched if counterparts existed on the other side, so
>> culling tags that do not exist on the remote side should also be described.
> 
> (gleaning-leftovers mode)

Thanks for following up on this with your proposed documentation patch.
 I have been researching and experimenting, and still find the use of
fetch confusing with respect to tags.  I think the problem is primarily
that the behavior is awkward, and that it would be better to change the
behavior than to document the awkward behavior.

I must have read an old version of the documentation, from which it
seemed that "git fetch --tags" fetches all tags from the remote *in
addition to* the references and tags that would otherwise be fetched.
This seems like a handy and safe feature, and I wish that this were
indeed the effect of "--tags".

But I see that the documentation for "--tags" has been changed and now
states explicitly that "--tags" is equivalent to specifying
"refs/tags/*:refs/tags/*" on the command line, overriding any configured
refspecs.  This doesn't seem like useful behavior; why would I want to
fetch tags from a remote without also updating the configured refspecs?
 And contrariwise, how can I fetch the configured refspecs *and* all
tags at the same time in a single fetch?

OK, one way to do it is to configure an explicit refspec for fetching
the tags:

[remote "origin"]
	url = [...]
	fetch = +refs/heads/*:refs/remotes/origin/*
	fetch = refs/tags/*:refs/tags/*

[Here is one oddity: even if the tags refspec doesn't have a "+" prefix,
"git fetch" will do non-ff updates to tags, presumably because of the
implicit tag-fetching behavior.]

But if I use this configuration and type "git fetch --prune", then any
local tags that are not present on the remote will be killed.

In short, when local tags are in use, or tags that are in one remote but
not another [1], then the current Git implementation makes it impossible to

- Configure "fetch.prune" or "remote.$REMOTE.prune" without preventing
the use of "fetch --tags"

- Configure default fetching of all tags (via a refspec or via
remote.$REMOTE.tagopt) without preventing the use of "fetch --prune"

- Configure "fetch.prune" or "remote.$REMOTE.prune" and the default
fetching of all tags (via a refspec or via remote.$REMOTE.tagopt) at the
same time.

This is unfortunate.

I think it would be preferable if "--prune" would *not* affect tags, and
if there were an extra option like "--prune-tags" that would have to be
used explicitly to cause tags to be pruned.  Would somebody object to
such a change?

Michael

[1] In fact, the scenario that bit my colleague was as follows: he had
just built a software release, which creates a new commit and a release
tag.  When he tried to push the commit, there was a non-ff failure due
to an upstream change.  So he ran "git fetch --prune" to get the
upstream change, and this caused the release tag (which hadn't been
pushed yet) to be lost.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

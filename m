From: "Aaron Cohen" <aaron@assonance.org>
Subject: Re: git-scm.com (was Re: Git graph on GitHub)
Date: Wed, 15 Oct 2008 17:04:36 -0400
Message-ID: <727e50150810151404i5c70b7d7u380da947169db6a7@mail.gmail.com>
References: <bab6a2ab0810150315l273d4ef3k95cda8f43a4745ca@mail.gmail.com>
	 <bab6a2ab0810150318pb616a6dj867efa36623ac12e@mail.gmail.com>
	 <20C9ABEC-52E5-405E-A755-C58A6359D7A9@wincent.com>
	 <bab6a2ab0810151136n4f997890qd418277ea8c4aea4@mail.gmail.com>
	 <20081015201230.GA9534@garry-x300.arpnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "PJ Hyett" <pjhyett@gmail.com>,
	"Wincent Colaiuta" <win@wincent.com>, git@vger.kernel.org
To: "Garry Dolley" <gdolley@arpnetworks.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 23:06:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqDZ5-0005ll-Ov
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 23:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025AbYJOVEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 17:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756018AbYJOVEi
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 17:04:38 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:8345 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbYJOVEh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 17:04:37 -0400
Received: by qw-out-2122.google.com with SMTP id 3so868538qwe.37
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=G4CrYGRPZO3LHyN1GXCa4OrSO5MOYiKlOgAZojccOjU=;
        b=qXmQZgoPtw5COhFJpbnurRN4CE/Tcyf6QY+mzTDbMWqr6fxlAZkyIQnGfabNSoNQrw
         2L80u5WIwQU3AjiZh+jklPheNN4kEflEs0bhMHDyGgWuusiBJ5+Hyg60SPopEpMRvb0H
         KSwXZcwVyf5CpHDCE41KzPeFhgV9Hs3c6a+jo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=HTb9SV36KA0ksJH6+uulRAt15njPM7hbgfnzGHaHAI49NkH8clnKgcZHJLGuTfanWO
         v3RDCdaXchBamFhBhv/GQAA8LcmjTaTZuIk+LJ1iewaItXMepdhorTgHE9tPYS0swZvH
         fzqBj1vmwx/kWSO7r0s4aCrsLXYeTWk5JM9uQ=
Received: by 10.214.81.9 with SMTP id e9mr1748059qab.30.1224104676122;
        Wed, 15 Oct 2008 14:04:36 -0700 (PDT)
Received: by 10.215.66.4 with HTTP; Wed, 15 Oct 2008 14:04:36 -0700 (PDT)
In-Reply-To: <20081015201230.GA9534@garry-x300.arpnetworks.com>
Content-Disposition: inline
X-Google-Sender-Auth: b184ca93e21b9e3b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98328>

On Wed, Oct 15, 2008 at 4:12 PM, Garry Dolley <gdolley@arpnetworks.com> wrote:
> On Wed, Oct 15, 2008 at 11:36:10AM -0700, PJ Hyett wrote:
>> > Coming up in news at 6...
>> >
>> > GitHub announces new maintainer for Git
>> >
>> > GitHub is proud to announce the replacement of the old Git maintainer with
>> > the "Git Core Team", comprising PJ Hyett, Scott Chacon, Tom Preston and some
>> > select personalities from the Ruby on Rails world. You'll be able to track
>> > all the latest updates to "Git Edge" over at GitHub. The former maintainer,
>> > Junio C Hamano, is being retired from service because the Git community (see
>> > git-scm.com) decided he wasn't as good-looking as David Heinemeier Hanson.
>> > For more information, see the official Git book (book.git-scm.com).
>>
>> In case there was any confusion, this is why we almost never bother
>> posting to the list, because no matter what the topic, it always turns
>> into why the git community hates GitHub.
>
> For the record, I'm a part of the git community and I like GitHub
> quite a bit. :)
>

For the record, I'm not part of either community and find things to
dislike about both of them.

git.or.cz: I personally prefer its plain style, but it has way too
much information on the front page (why is so much download
information on that page rather than hidden behind the "download" link
that currently just goes to an ftp directory?)

git-scm.com: Much better organized, but suffers from web 2.0
shininess.  Also, every time I look at it my eyes have to read
EVERYTHING to figure out what ANYTHING is.  For instance, why is there
that random column of "projects using git" that seems to only exist to
distract me from the important stuff?

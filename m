From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Next Git conference or meeting
Date: Wed, 3 Sep 2014 10:53:04 +0200
Message-ID: <CAP8UFD3x1Pm-+0GF+2CEFkZ34XDzZ95Wu0boPgGocE_8T7uk9g@mail.gmail.com>
References: <CAP8UFD1Jzy2jzRaFh35=y1yCJcMHKSkXbSXp1SuBL2R2bQAJqQ@mail.gmail.com>
	<1A6AAC8B-0C82-4296-B1C8-BF0739A28A80@gmail.com>
	<20140902112117.GB5049@thunk.org>
	<20140902135147.GC6232@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luca Milanesio <luca.milanesio@gmail.com>,
	git <git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 03 10:53:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XP6JY-0002xF-6G
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 10:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbaICIxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 04:53:09 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:64673 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaICIxG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 04:53:06 -0400
Received: by mail-ie0-f180.google.com with SMTP id rl12so9257598iec.39
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cwbiQCazr2QW8ezhcQdHhlDFL7SbxYS6cwYmYrZw62A=;
        b=ey/Zk3OD7KFZ2d8DWYTOmVqWqv9SBqcO93GdggnUbthxfnm5lgcckV93Z4SjiygIOI
         Vyz2qFszhGVolZ7TnThUkeVR3RXzZB+VOYaVcbqLHf71HPVkjj0884VfiLbwMQwsI3Od
         1fDQTkTR7yagoSKfv3RwSpRVjHZ6IUe9fif1NgqFH6F/y/e5HIVw5Ps9BEq4sn13bz1Y
         HSTHAGJimZeOTfdRB5uGCFecKUNB6rSqR2yFfVNq0j9VS4xkdOZ0dVgANHN87yIRMAy+
         uVCSdsX1qz59M1o8c9SSQIVGgjCPm+Py47VLn0B5j9K4Vz8BbMuhmg726n0INpAUWeib
         /7Lg==
X-Received: by 10.50.36.38 with SMTP id n6mr34261869igj.24.1409734384918; Wed,
 03 Sep 2014 01:53:04 -0700 (PDT)
Received: by 10.50.212.3 with HTTP; Wed, 3 Sep 2014 01:53:04 -0700 (PDT)
In-Reply-To: <20140902135147.GC6232@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256384>

On Tue, Sep 2, 2014 at 3:51 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, Sep 02, 2014 at 07:21:17AM -0400, Theodore Ts'o wrote:
>> On Tue, Sep 02, 2014 at 08:20:42AM +0100, Luca Milanesio wrote:
>> > Hi Chris,
>> > Seattle is a very inconvenient location for most of the people
>> > coming from Europe: somewhere in the Bay area would be better and
>> > less expensive for us.
>>
>> Well, the fact that Seattle is inconvnient might not matter that much
>> because apparently large numbers of Europeans are on vacation in
>> August, and some of them are already complaining that the Plumbers
>> Conference is going to be colocated with LinuxCon in Seattle.  :-)
>>
>> The Linux Foundation will be hosting its Collaboration Summit (which
>> is like LinuxCon, but which is invitation only to members of
>> developers community and LF members) in at the Hyatt Santa Rosa August
>> 21-25.
>
> Oops, sorry, I meant to say April 21-25; hence four months earlier
> than August, avoiding the European vacation season, and also requiring
> a flight into SFO.

I am ok with having the GitCon at Hyatt Santa Rosa around April 21-25
if people prefer or if it makes it easier for the LinuxFoundation.

It's true that it can be cheaper for Europeans as it may be easier to
find a free place to crash at (hi John!)
And April 21-25 is closer to the anniversary date. On the other hand
there might be fewer people around because the Collaboration Summit is
invitation only.

> If this is something that folks are interested in, I work with Angela
> pretty closely, since I organize the Kernel Summit, so I'm happy to
> put folks in touch with her.  But before I do that, I have one other
> question.  Has the Git conference/meeting outgrown Google's
> facilities?  Is that an option?

As far as I know, the big problem with using Google's facilities is
that someone working for Google needs to be involved and spend a lot
of time talking and organizing things with other Google people. And
unfortunately the Git developers working for Google are usually very
busy with other things like working on what they are supposed to work
at Google. Shawn used to organize the GitTogether meetings, but he has
been involved in Gerrit during the last years and therefore cannot do
it anymore.

That's why IMHO our best option is to have things organized by the
LinuxFoundation.

We could also ask Github to organize everything as for the Git merge
2013, but there are other benefits to the LinuxFoundation. It is a
neutral organization that is used to dealing with competing companies,
and as it could colocate us with a linux kernel meeting it would make
it easier for some kernel developers to come.

Best,
Christian.

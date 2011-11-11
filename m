From: Johan Herland <johan@herland.net>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Fri, 11 Nov 2011 02:17:58 +0100
Message-ID: <CALKQrgcJmPHZG0bbgwoH6_htQODYVJtXYyHgSb_7qRKkJkb2Yw@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org>
	<1319969101.5215.20.camel@dabdike>
	<CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
	<1320049150.8283.19.camel@dabdike>
	<CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
	<7vy5w1ow90.fsf@alter.siamese.dyndns.org>
	<CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
	<7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
	<CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
	<7vk47jld5s.fsf@alter.siamese.dyndns.org>
	<CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
	<CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
	<CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
	<CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
	<7v62j1gitn.fsf@alter.siamese.dyndns.org>
	<7vvcr1f38j.fsf@alter.siamese.dyndns.org>
	<CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
	<7v4nydurzh.fsf@alter.siamese.dyndns.org>
	<CALKQrgfZtELcK3H5ZYvmcW8RrtKMVRACFTvw3s5SidFvmFWkGw@mail.gmail.com>
	<7vaa84t3ek.fsf@alter.siamese.dyndns.org>
	<CALKQrgdxEXQGKQ3t9Sh82=U933ypHNg8duyVmG9uJbg2iST5fw@mail.gmail.com>
	<7v39dvuca4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Ted Ts'o" <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <junio@pobox.com>
X-From: linux-ide-owner@vger.kernel.org Fri Nov 11 02:18:10 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1ROfkv-00031E-T7
	for lnx-linux-ide@lo.gmane.org; Fri, 11 Nov 2011 02:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923Ab1KKBSI (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Thu, 10 Nov 2011 20:18:08 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:52679 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab1KKBSG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Nov 2011 20:18:06 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ROfko-000Egi-QU; Fri, 11 Nov 2011 02:18:02 +0100
Received: by iage36 with SMTP id e36so3593514iag.19
        for <multiple recipients>; Thu, 10 Nov 2011 17:17:58 -0800 (PST)
Received: by 10.42.129.137 with SMTP id q9mr10280127ics.18.1320974278781; Thu,
 10 Nov 2011 17:17:58 -0800 (PST)
Received: by 10.42.229.193 with HTTP; Thu, 10 Nov 2011 17:17:58 -0800 (PST)
In-Reply-To: <7v39dvuca4.fsf@alter.siamese.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185249>

On Thu, Nov 10, 2011 at 18:18, Junio C Hamano <junio@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> What about having one notes ref per branch? If/when the branch is merged,
>> the associated notes ref containing the annotations for the commits on that
>> branch would be merged as well (using "git notes merge").
>
> That is a crude workaround that you could (with help from users) make it
> work, but it does not change the fact that the current mechanism to
> transfer and integrate notes across repositories is a bad match for what
> the "signed commit" type annotations wants to achieve. In fact, the need
> for such a workaround is an illustration of how bad a match the mechanism
> is.
>
> When you merge a history that has commit A into another history that did
> not have that commit, the act of creating a merge commit itself should be
> enough to make the resulting history to contain that commit. The commit
> DAG already expresses it, and if a parallel "notes" mechanism needs to be
> futzed with to match that DAG, and command like "merge" needs to be told
> to help that process, that is a shortcoming of the "notes" mechanism.

[ ...and from elsewhere in this thread: ]

> Note that in this thread, I am not saying that "git notes" mechanism is
> not good for anything. A tree whose node names encode an object name is a
> valid way to store the mapping from that object to a set of other objects,
> and we already agreed that as the "local" storage mechanism, "git notes"
> may be used as-is for the purpose of this thread.
>
> But the transfer and merge semantics "git notes" mechanism offers treats
> the entire "notes" that appear in _one_ repository and merging that set to
> the entire "notes" in another repository and it is not a good match for
> the purpose of this thread.

Ok. Point taken.

Given that we need an alternative way to transfer annotations between
repos (using auto-follow to select the relevant set of annotations, and
then transferring only those annotations): Can we leverage existing
functionality in "notes" where useful (e.g. using existing notes merge
strategies to deal with colliding annotations), while at the same time
extending the current "notes" feature with this alternative transfer
mechanism? FWIW, I expect there are other "notes" use cases that
would also prefer the auto-follow only-relevant transfer behavior.

So, how can we use "notes" to better support the transfer semantics you
suggest? The mapping from the object being annotated to the annotation
object is already contained in the notes tree, but the "timestamp" you
describe (needed to efficiently calculate the set of annotations to
auto-follow) is not [1]. However, we could easily enough add a sorted
list of (timestamp,  annotated object name) pairs, to allow fast lookup
of annotations created after a given timestamp. We could even store this
list in a blob or tree object referenced directly from the notes tree [2].


Have fun! :)

...Johan


[1]: Although I did at some point experiment with using timestamps in the
internal organization of the notes tree (see for example
http://article.gmane.org/gmane.comp.version-control.git/127966 ), I ended
up using only the annotated object name (with flexible fanout). I don't
think that reintroducing timestamps in the notes tree organization will
pay off, because we need both lookup by annotated SHA1 and lookup by
newer-than-given-timestamp to be fast, and there's AFAIK no way to get
both from a single notes tree organzation.

[2]: E.g. accessible with "git cat-file refs/notes/foo:timestamps". When
a notes tree contains an entry that is obviously not an object name (SHA1),
the notes code will leave it alone/untouched in the tree (see "struct
non_note" and associated code in notes.c for further details).

-- 
Johan Herland, <johan@herland.net>
www.herland.net

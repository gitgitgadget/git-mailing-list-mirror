From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-scm.com
Date: Sun, 27 Jul 2008 15:01:54 -0700
Message-ID: <7vd4kzyoj1.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
 <7v3alxr0fd.fsf@gitster.siamese.dyndns.org>
 <d411cc4a0807251759m1d83d7c4w4724806b19f7c02a@mail.gmail.com>
 <7vsktwfu5z.fsf@gitster.siamese.dyndns.org>
 <20080727113707.GC32184@machine.or.cz>
 <7v3alv2n46.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 28 00:03:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNEL0-0004zH-Pa
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 00:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758297AbYG0WCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 18:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758170AbYG0WCD
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 18:02:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757727AbYG0WCD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 18:02:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BFAA43FEA3;
	Sun, 27 Jul 2008 18:02:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BDEC23FEA2; Sun, 27 Jul 2008 18:01:56 -0400 (EDT)
In-Reply-To: <7v3alv2n46.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 27 Jul 2008 11:33:29 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A383526A-5C27-11DD-BF35-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90372>

Junio C Hamano <gitster@pobox.com> writes:

> Petr Baudis <pasky@suse.cz> writes:
> ...
>> The point here is that the list is awfully long and also can contain
>> a lot of duplicates or people with broken unicode, etc. - it gets hard
>> to maintain, and it makes the about page too long. I would be of course
>> fine with a tiny link at the bottom "(show all contributors)".
>
> Your "incentive to move up" argument suggests otherwise.  Even if it takes
> efforts to maintain on somebody's part, it is worth to be inclusive, *IF*
> the purpose of that bottom list is to give credits to people.
>
> The list on the site originally was not utilizing .mailmap and I asked
> Scott to use it to merge duplicate entries, which he did.  People whose
> names are misspelled and/or split will now have incentive to tell Scott
> about the problem so that they can clean up *their* own names, and Scott
> can help maintaining .mailmap and feed the changes to me.
>
> This is my ulterior motive behind this suggestion; I can outsource the
> maintenance of .mailmap to people who care about it more than myself.

By the way, earlier Scott gave as explanation why he and others around
GitHub, people who are not very visible on this list, are not interacting
with us very much --- because they are not "C coders".

But maintenance of .mailmap (and Documentation/ area, too, of course) is a
good example of how involvement from non "C coders" would be a helpful and
healthy thing to have in the development process, and why we do not want
to fracture the user community in two.

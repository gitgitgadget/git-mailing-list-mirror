From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Are more and more patches getting lost lately?
Date: Wed, 03 Sep 2008 21:34:19 -0700
Message-ID: <7vd4jk8r78.fsf@gitster.siamese.dyndns.org>
References: <20080904083343.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 06:36:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb6aF-0007jU-Mn
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 06:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbYIDEe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 00:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbYIDEe1
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 00:34:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYIDEe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 00:34:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DCADF72CDD;
	Thu,  4 Sep 2008 00:34:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C1E5E72CD7; Thu,  4 Sep 2008 00:34:21 -0400 (EDT)
In-Reply-To: <20080904083343.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu, 04 Sep 2008 08:33:43 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C12C89C2-7A3A-11DD-98AC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94891>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I noticed that recently there are many patches sent to the list
> that are left unapplied (and many of them are from you).  Many
> of them look useful or at least promising to become useful.

Geez.  Well,... thanks.

Do you have particular ones in the list that you really want to see
in-tree early, do you want all of them, or what?

> What can we, the mailing list readers, do to help these patches
> applied?  Ask the authors of individual patches about their
> progress?

That would be the way to go.  I try to comment on all patches/topics that
interests me, and I refrain from applying what I commented on before I see
responses (and the response should not be "yes sir I'll obey blindly";
"No, the reason I did it that way was because..." to show that the
submitter has thought things through is much more preferred).  If there is
no progress in the discussion, it is very possible that I forget, even
when it is my turn to respond.  "I defended my position responding to
comments from you [or from the list] and I believe my argument was sound.
Did you forget to apply the patch, or do you want to discuss more?" from
the original submitter is very much appreciated.

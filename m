From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Website redesign
Date: Tue, 15 Apr 2008 11:04:56 -0700
Message-ID: <7vtzi35707.fsf@gitster.siamese.dyndns.org>
References: <3175605f-ff32-4fd6-bed3-7ae596ecbcde@q1g2000prf.googlegroups.com>
 <2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com>
 <56e37551-4b8f-4164-a71d-79dba8635b7d@l28g2000prd.googlegroups.com>
 <20080415115431.GA26302@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dill <sarpulhu@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Apr 15 20:19:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlpXf-0006J4-NF
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 20:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbYDOSFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 14:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbYDOSFM
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 14:05:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbYDOSFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 14:05:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 388502E14;
	Tue, 15 Apr 2008 14:05:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 71F342E10; Tue, 15 Apr 2008 14:05:03 -0400 (EDT)
In-Reply-To: <20080415115431.GA26302@machine.or.cz> (Petr Baudis's message of
 "Tue, 15 Apr 2008 13:54:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79614>

Petr Baudis <pasky@suse.cz> writes:

> I appreciate the effort, but frankly, I simply personally like the
> current layout much more - the design certainly has quirks, but I don't
> really find it bad; I also think that the current amount of content does
> not justify splitting to multiple pages. The newly proposed version
> looks to me just as barebone graphically as the old one, with the same
> level of navigability but wasting screen estate and requiring more
> clicks to get where you need.
>
> That said, this can (and quite probably does) merely mean that I simply
> have no taste at all and should be kept away from any kind of web
> design! :-) So, I do not want to inhibit progress at all, but before
> considering to adopt the new design, I would prefer to see wider
> feedback from the core members of the community to convince me that I'm
> wrong.

I always wish that any proposal for change is countered by silent
satisfied customers expressing why the current one is good, and this is a
perfect opportunity for me to do so as I am just a satisfied customer of
git.or.cz, who is not involved in the building side at all.

If I recall correctly, the old old site was split like how the sarpulhu
sample page shows, a sketchy top page with links to other pages.  It is
tempting to build a sparse scaffolding in the expectation that each page
will be filled with rich contents later, and the fear of having too many
things in one page drives people to make the initial scaffolding too
sparse.  But as you say, the current "single page that is not too long
describes all the necessary things and points people at outside resources"
format is much nicer.

I happen to also like one aspect of visual behaviour of git.or.cz better
than the sarpulhu sample page.  The former widens as I resize my browser
window, the latter doesn't.

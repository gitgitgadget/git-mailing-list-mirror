From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (Oct 2008, #03; Tue, 14)
Date: Wed, 15 Oct 2008 13:26:03 -0700
Message-ID: <7vhc7dr4f8.fsf@gitster.siamese.dyndns.org>
References: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org>
 <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil> <7vljwpr6lr.fsf@gitster.siamese.dyndns.org> <20081015202032.GD28802@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	Arjen Laarhoven <arjen@yaph.org>, Jeff King <peff@peff.net>,
	Mike Ralphson <mike@abacus.co.uk>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:27:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqCxr-0006y1-Ul
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbYJOU0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 16:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbYJOU0Q
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:26:16 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbYJOU0P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 16:26:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F5518BD3C;
	Wed, 15 Oct 2008 16:26:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B227E8BD3B; Wed, 15 Oct 2008 16:26:05 -0400 (EDT)
In-Reply-To: <20081015202032.GD28802@spearce.org> (Shawn O. Pearce's message
 of "Wed, 15 Oct 2008 13:20:32 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8370F25C-9AF7-11DD-BE3E-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98321>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> If we can add a test case to demonstrate the existing breakage, I think we
>> can (and should) cherry-pick it to 'maint'.
>
> Yes, it probably should have gone to maint.  No, it didn't go there.
> Temporary lapse in maintainer judgement.

That is Ok.  I do the same all the time (and I try to rewind and rebuild
when I spot it before pushing the results out, but I am not always
successful).

I just wanted to see if there was any particular reason not to have this
on 'maint'.

Thanks.

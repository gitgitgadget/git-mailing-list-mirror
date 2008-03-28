From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.5-rc2
Date: Fri, 28 Mar 2008 14:05:09 -0700
Message-ID: <7vtziq1rwa.fsf@gitster.siamese.dyndns.org>
References: <7viqz72we4.fsf@gitster.siamese.dyndns.org>
 <20080328181345.GB8299@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 22:06:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfLm0-0005cm-U2
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 22:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbYC1VFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 17:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754738AbYC1VFW
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 17:05:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbYC1VFV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 17:05:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 591421312;
	Fri, 28 Mar 2008 17:05:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BC454130C; Fri, 28 Mar 2008 17:05:16 -0400 (EDT)
In-Reply-To: <20080328181345.GB8299@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 28 Mar 2008 14:13:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78437>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 27, 2008 at 11:30:27PM -0700, Junio C Hamano wrote:
>
>> GIT 1.5.5-rc2 was tagged tonight, and it is available from the usual
>> places.
>
> I never got a response to my patches to fix encoding issues in
> "send-email --compose". It _is_ a bugfix, but I don't know if it is
> 1.5.5-worthy.  Forgotten (and I should resubmit now), or should I wait
> until after the release?

I was getting the impression that it was still in "ah, but this is
better", "you are right, but how about doing this", stage and was hoping
that "ok, based on the discussion here is the final one" will come soon.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multiple -M options for git-cvsimport
Date: Thu, 28 Feb 2008 12:07:46 -0800
Message-ID: <7vzltkj14d.fsf@gitster.siamese.dyndns.org>
References: <1204193904-3652-1-git-send-email-book@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 21:09:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUp3c-0001kc-9v
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbYB1UIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 15:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752503AbYB1UID
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:08:03 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbYB1UIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 15:08:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 355F2213A;
	Thu, 28 Feb 2008 15:07:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4573E2138; Thu, 28 Feb 2008 15:07:49 -0500 (EST)
In-Reply-To: <1204193904-3652-1-git-send-email-book@cpan.org> (Philippe
 Bruhat's message of "Thu, 28 Feb 2008 11:18:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75439>

"Philippe Bruhat (BooK)" <book@cpan.org> writes:

> Sending again my series of patches to git-cvsimport, which allow to
> use several -M options for giving the regular expressions capturing the
> source branch name when merging.

Could you be a bit more explicit than "Sending again", describe
if it is just a straight resend, or what problems were pointed
out in the earlier round (if any) and how they were addressed
(or ignored, if any)?

Also please Sign-off all your patches.  Cover letters do not
need one.

I'll take a look at them later, when I have enough time to fish
for messages and discussions from earlier round in the list
archive in order to process this.

Thanks.

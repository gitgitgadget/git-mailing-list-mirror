From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dubious format-patch options
Date: Thu, 12 Jun 2008 19:05:09 -0700
Message-ID: <7vzlpqxf6y.fsf@gitster.siamese.dyndns.org>
References: <E1K6xrt-00033S-2J@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Loeliger <jdl@jdl.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 04:06:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ygK-00030K-Tx
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 04:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbYFMCFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 22:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754525AbYFMCFY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 22:05:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbYFMCFY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 22:05:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A2F752BAC;
	Thu, 12 Jun 2008 22:05:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 107602BAA; Thu, 12 Jun 2008 22:05:18 -0400 (EDT)
In-Reply-To: <E1K6xrt-00033S-2J@jdl.com> (Jon Loeliger's message of "Thu, 12
 Jun 2008 20:14:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E5287F2-38ED-11DD-ACE1-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84822>

Jon Loeliger <jdl@jdl.com> writes:

> Git-ites,
>
> Hmmm... There are a ton of dubious options being accepted
> by the "git format-patch" command due to it being a skinny
> front to "git log".  Like, the -S and pick-axe crew:
> ...
> Oh yeah.
>
> And --color is a cool thing too.  I mean, I was pleasantly
> pleased with:

Amusing ;-).

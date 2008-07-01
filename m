From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch
 'origin/master' by 50 commits.
Date: Tue, 01 Jul 2008 02:32:14 -0700
Message-ID: <7vlk0mne5d.fsf@gitster.siamese.dyndns.org>
References: <20080701091347.GA11817@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Jul 01 11:33:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDcEp-00072S-5M
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 11:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207AbYGAJc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 05:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbYGAJc3
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 05:32:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbYGAJc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 05:32:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 586EF1DE74;
	Tue,  1 Jul 2008 05:32:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A07951DE73; Tue,  1 Jul 2008 05:32:24 -0400 (EDT)
In-Reply-To: <20080701091347.GA11817@elte.hu> (Ingo Molnar's message of "Tue,
 1 Jul 2008 11:13:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9E859C00-4750-11DD-A593-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87015>

Ingo Molnar <mingo@elte.hu> writes:

> i recently switched to 1.5.6.1.89.gd5446 and i'm getting this:
>
>   Switched to branch "master"
>   Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.
>
> it's a very useful detail! It's especially useful when two branches 
> diverge in a non-trivial way.
> ...
> but having a reminder at checkout time is even better (and faster as 
> well). Kudos.

Thanks for a rare positive usability feedback.  When I started reading
your message, I almost expected that I'd hear you say "I am getting this
useless cruft and it wastes extra cycles."

Somebody must have had a very bright idea that day in late February this
year.

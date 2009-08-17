From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "make quick-install-man" broke recently
Date: Sun, 16 Aug 2009 18:29:15 -0700
Message-ID: <7vy6pj449g.fsf@alter.siamese.dyndns.org>
References: <86my5z8cjd.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Mon Aug 17 03:29:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcr2V-0004GT-C2
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 03:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbZHQB3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 21:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbZHQB3U
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 21:29:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbZHQB3T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 21:29:19 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F00ED33B;
	Sun, 16 Aug 2009 21:29:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C924AD339; Sun, 16 Aug
 2009 21:29:16 -0400 (EDT)
In-Reply-To: <86my5z8cjd.fsf@blue.stonehenge.com> (Randal L. Schwartz's
 message of "Sun\, 16 Aug 2009 18\:16\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6288823C-8ACD-11DE-826D-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126103>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Something broke recently in "make quick-install-man".  It works
> fine if my mandir is empty, but not if a previous installation
> is there.

Broken how?

Sorry, but I obviously do not use the target myself, because I am the one
who builds manpages for real and stuff them in the 'man' branch for you to
check out after all.

"Something broke" is bit too vague a problem description if you expect me
to look into it.

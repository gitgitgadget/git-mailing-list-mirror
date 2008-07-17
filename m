From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 09:38:40 -0700
Message-ID: <7vzlogh3e7.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <487EF519.5070902@sneakemail.com> <20080717125536.GO2167@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Valdemar =?utf-8?Q?M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 17 18:39:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJWWC-00088A-6D
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 18:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbYGQQis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 12:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755178AbYGQQis
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 12:38:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbYGQQir (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 12:38:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6784739A18;
	Thu, 17 Jul 2008 12:38:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B285A39A13; Thu, 17 Jul 2008 12:38:42 -0400 (EDT)
In-Reply-To: <20080717125536.GO2167@mit.edu> (Theodore Tso's message of "Thu,
 17 Jul 2008 08:55:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D36F4044-541E-11DD-94B5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88878>

Theodore Tso <tytso@mit.edu> writes:

> Have you taken a look at the intro-level materials such as "Everyday
> Git in 20 commands or so"[1], the git tutorial[2], the official "Git's
> User Manual"[3], or the "Git-SVN crash course"[4]?  Those are probably
> the best place to begin --- and to basically treat the git man pages
> as reference materials with a huge number of controls that you won't
> use or need to use for a long time --- if ever.

Good advice.

One caution is that I wrote the Everyday quite a while ago, certainly way
before 1.5.0, and I suspect the set of best commands and best ways to do
what these sections demonstrate to do may have changed.  I do not think
old ways stopped working (that would be a regression), but there would be
better ways invented after the document was last updated.

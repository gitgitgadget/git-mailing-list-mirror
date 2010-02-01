From: Sergei Organov <osv@javad.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 20:58:56 +0300
Message-ID: <87aavsu9b3.fsf@osv.gnss.ru>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
	<7vpr4o3lg9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 19:05:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc0eq-0004yo-WD
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 19:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901Ab0BASFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 13:05:41 -0500
Received: from javad.com ([205.178.136.214]:47806 "EHLO 02aef2d.netsolvps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab0BASFk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 13:05:40 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2010 13:05:40 EST
Received: (qmail 15473 invoked from network); 1 Feb 2010 17:58:58 +0000
Received: from unknown (HELO osv.gnss.ru) (89.175.180.246)
  by javad.com with (AES256-SHA encrypted) SMTP; 1 Feb 2010 17:58:58 +0000
Received: from osv by osv.gnss.ru with local (Exim 4.69)
	(envelope-from <osv@osv.gnss.ru>)
	id 1Nc0Y4-0000o4-WA; Mon, 01 Feb 2010 20:58:56 +0300
In-Reply-To: <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 01 Feb 2010 09\:38\:46 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138635>

Junio C Hamano <gitster@pobox.com> writes:
> Steve Diver <squelch2@googlemail.com> writes:

[...]

> If read carefully (some may argue that it does not need a very careful
> reading to get it, though), this hints that "detached HEAD" state is a
> substitute for using a temporary branch, but it may not be strong
> enough.

For my rather fresh eye it looks more like unnamed (anonymous?) branch
than a temporary one. Doesn't detached HEAD behave exactly like a
regular HEAD but pointing to the tip of an unnamed branch?

-- Sergei.

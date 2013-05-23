From: Andreas Krey <a.krey@gmx.de>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 12:29:59 +0200
Message-ID: <20130523102959.GP9448@inner.h.apk.li>
References: <20130522115042.GA20649@inner.h.apk.li> <7v4ndukhx0.fsf@alter.siamese.dyndns.org> <20130523090657.GB23933@inner.h.apk.li> <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu May 23 12:32:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfSoq-0002bh-NB
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 12:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758048Ab3EWKcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 06:32:21 -0400
Received: from continuum.iocl.org ([217.140.74.2]:38784 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757977Ab3EWKcU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 06:32:20 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4NAU0601270;
	Thu, 23 May 2013 12:30:00 +0200
Content-Disposition: inline
In-Reply-To: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225233>

On Thu, 23 May 2013 05:48:38 +0000, John Szakmeister wrote:
...
> This is a feature of `git pull` that I really despise.  I really wish
> `git pull` treated the remote as the first parent in its merge
> operation.

I'd actually only like it that way when pulling from
the tracking branch, not for any pull.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800

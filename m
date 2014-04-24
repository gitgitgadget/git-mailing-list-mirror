From: David Kastrup <dak@gnu.org>
Subject: Re: Harmful LESS flags
Date: Thu, 24 Apr 2014 07:06:12 +0200
Message-ID: <87lhuvb9kr.fsf@fencepost.gnu.org>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: d9ba@mailtor.net
X-From: git-owner@vger.kernel.org Thu Apr 24 07:06:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdBrW-0004ye-4o
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 07:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbaDXFGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 01:06:14 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:39391 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaDXFGN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 01:06:13 -0400
Received: from localhost ([127.0.0.1]:38434 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WdBrQ-0000lY-TB; Thu, 24 Apr 2014 01:06:13 -0400
Received: by lola (Postfix, from userid 1000)
	id 81575E04DB; Thu, 24 Apr 2014 07:06:12 +0200 (CEST)
In-Reply-To: <4dc69237123e8962b2b2b901692ea78e.id@mailtor> (d9ba@mailtor.net's
	message of "Wed, 23 Apr 2014 23:46:02 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246938>

d9ba@mailtor.net writes:

> It would be nice if we could change the flags to either
>
>  a) avoid cutting off
>  b) indicate something has been cut off (<- I prefer this)
>
> I assume there are more people with a similar workflow who're still
> unaware of this feature.
>
> I would joke about how 3 letter agencies introduced this flag to
> backdoor open source projects, but, well..

Most terminals are wider than three letters.

Still, it is a total nuisance.  I am constantly doing

-S RET

on my git output.  This should be left alone as an entirely personal
preference quite unrelated to Git.  There is no point in having Git
configure a default different from what is used elsewhere.

-- 
David Kastrup

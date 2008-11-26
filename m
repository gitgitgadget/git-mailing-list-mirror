From: Hannu Koivisto <azure@iki.fi>
Subject: Re: French git user
Date: Wed, 26 Nov 2008 18:22:23 +0200
Message-ID: <83zljmo3sw.fsf@kalahari.s2.org>
References: <492B9985.10103@morey-chaisemartin.com>
	<200811260955.57421.johan@herland.net>
	<492D1779.8040807@morey-chaisemartin.com>
	<200811261123.56317.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: devel@morey-chaisemartin.com, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 17:23:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5NB1-0003Hu-CN
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 17:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190AbYKZQW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 11:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbYKZQW1
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 11:22:27 -0500
Received: from s2.org ([195.197.64.39]:44738 "EHLO kalahari.s2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754109AbYKZQW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 11:22:26 -0500
Received: from azure by kalahari.s2.org with local (Exim 4.69)
	(envelope-from <azure@iki.fi>)
	id 1L5N9j-0006xI-Ed; Wed, 26 Nov 2008 18:22:23 +0200
In-Reply-To: <200811261123.56317.johan@herland.net> (Johan Herland's message
	of "Wed, 26 Nov 2008 11:23:56 +0100")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: azure@iki.fi
X-SA-Exim-Scanned: No (on kalahari.s2.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101743>

Johan Herland <johan@herland.net> writes:

> On Wednesday 26 November 2008, Nicolas Morey-Chaisemartin wrote:
>> Yes I say in french that git-foo is deprecated.
>> However I'm still using it in the following slides because people
>> have directly the good command to look at the man.
>> I know it's not really consistent but asI'd rahter keep it that way
>> and insist while presenting it, it should only be used for man pages.
>
> The man pages are also accessible _without_ using the "git-foo" form, 
> either by doing "git foo --help" or "git help foo". I'd suggest using 
> the "git foo" form, and using "git help foo" instead of "man git-foo".

Depending on the audience, one might want to mention that if you
are using a modern version of zsh as your shell and have activated
its run-help function (see
http://zsh.dotsrc.org/Doc/Release/zsh_24.html#SEC218), you can just
say

git foo -bar <M-h>

and you'll get git-foo manual page.  When you exit man, you'll get
your command line back just like it was when you hit M-h.  I think
it handles even "echo dum ; git foo <M-h>" kind of cases.  You
can't live without it once you have tried it.  Or the completion
with descriptions for options etc.

-- 
Hannu

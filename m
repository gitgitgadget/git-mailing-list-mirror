From: david@lang.hm
Subject: Re: [ANNOUNCE] codeBeamer MR - Easy ACL for Git
Date: Wed, 18 Nov 2009 22:06:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0911182205590.5646@asgard.lang.hm>
References: <4B03B153.1020302@intland.com> <20091118120936.GL17748@machine.or.cz> <4B03F451.4050709@intland.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Intland Software <marketing@intland.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 07:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB0AL-0006SL-Ia
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 07:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbZKSGGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 01:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbZKSGGf
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 01:06:35 -0500
Received: from mail.lang.hm ([64.81.33.126]:33342 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbZKSGGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 01:06:34 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id nAJ66X79021492;
	Wed, 18 Nov 2009 22:06:33 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <4B03F451.4050709@intland.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133212>

On Wed, 18 Nov 2009, Intland Software wrote:

> More precisely: parts of the source code are actually open, including
> the wiki plugins and the remote clients, for instance. The core source
> is closed, because the same core is also used in our commercial offerings, 
> and
> our commercial license doesn't (currently) allow publishing the
> complete code. We have quite some large customers from the defense space
> that would not be happy if we opened everything ;)

are you sure? did you see the recent memo about OpenSource by the DOD?

David Lang

> We are currently in the midst of rethinking our licensing scheme
> in general, to make things more liberal or to set up some kind of a
> dual license.
>
>> I think a lot of people wonder now, how does this compare to existing
>> solutions; from your announcement I thought it's something like
>> Gitosis/Gitolite, but in fact it seems more similar to Gitorious or
>> GitHub (if it was publicly available, of course); perhaps it would be
>> good idea to present comparison to these on the project homepage.
> Good point. More on this later.
> ---
> Intland
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

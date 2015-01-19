From: Adam Spiers <git@adamspiers.org>
Subject: [ANNOUNCE] git-deps: commit dependency analysis / visualization
Date: Mon, 19 Jan 2015 00:11:39 +0000
Message-ID: <20150119001139.GA23327@pacific.linksys.moosehall>
References: <20150104010803.GD4108@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 19 01:11:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCzwb-0002Pv-RE
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 01:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbbASALn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 19:11:43 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:34536 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbbASALm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2015 19:11:42 -0500
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 6AB432E006
	for <git@vger.kernel.org>; Mon, 19 Jan 2015 00:11:40 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20150104010803.GD4108@pacific.linksys.moosehall>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262606>

On Sun, Jan 04, 2015 at 01:08:03AM +0000, Adam Spiers wrote:
> Hi all,
> 
> Thanks to my employer's generous "Hack Week" policy[0], I have the
> luxury of being able to spend most of next week hacking on a git
> commit dependency inference tool which I built 14 months ago but never
> got round to polishing up or publically announcing.  In this email
> I'll briefly explain the tool and some ideas I have for adding a
> web-based UI to it next week - any feedback is most welcome.

[snipped]

> Request for feedback
> ====================
> 
> Any kind of feedback is very welcome - obviously sooner rather than
> later, as my Hack Week starts on Monday.  Here's the project page:
> 
>     https://hackweek.suse.com/11/projects/366
> 
> Many thanks in advance!
> Adam

Noone told me this was a stupid idea, so I went ahead and added a web UI
to the tool :-)

I'm pleased to announce this is ready for testing; here are more
details along with a short screencast demonstration:

    http://blog.adamspiers.org/2015/01/19/git-deps/

Cheers,
Adam

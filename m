From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: Topics currently in the Stalled category
Date: Wed, 21 Nov 2012 09:55:12 -0500
Message-ID: <50ACEB50.2060107@xiplink.com>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org> <7vy5hvq1ey.fsf@alter.siamese.dyndns.org> <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 16:01:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbBoG-0007Ko-IG
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 16:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015Ab2KUPBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 10:01:35 -0500
Received: from smtp162.dfw.emailsrvr.com ([67.192.241.162]:42247 "EHLO
	smtp162.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012Ab2KUPBf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 10:01:35 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2012 10:01:35 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp16.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 0B34141033
	for <git@vger.kernel.org>; Wed, 21 Nov 2012 09:55:18 -0500 (EST)
X-Virus-Scanned: OK
Received: from smtp146.ord.emailsrvr.com (smtp146.ord.emailsrvr.com [173.203.6.146])
	by smtp16.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id C366E41039
	for <git@vger.kernel.org>; Wed, 21 Nov 2012 09:55:17 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp15.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 6EF5B27009C;
	Wed, 21 Nov 2012 09:54:46 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp15.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 11A5A270089;
	Wed, 21 Nov 2012 09:54:46 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210151>

On 12-11-20 07:05 PM, Junio C Hamano wrote:
> Here is a list of stalled topics I am having trouble deciding what
> to do (the default is to dismiss them around feature freeze).
> 

[ snip ]

> 
> * mb/remote-default-nn-origin (2012-07-11) 6 commits
>  - Teach get_default_remote to respect remote.default.
>  - Test that plain "git fetch" uses remote.default when on a detached HEAD.
>  - Teach clone to set remote.default.
>  - Teach "git remote" about remote.default.
>  - Teach remote.c about the remote.default configuration setting.
>  - Rename remote.c's default_remote_name static variables.
> 
>  When the user does not specify what remote to interact with, we
>  often attempt to use 'origin'.  This can now be customized via a
>  configuration variable.
> 
>  Expecting a re-roll.
> 
>  "The first remote becomes the default" bit is better done as a
>  separate step.

This is still on my list of things to do soon.  Unfortunately "soon" seems to
be rather perpetual these days.

If you're tired of carrying the branch feel free to dismiss it and I'll
resurrect the topic when "soon" finally comes around.

		M.

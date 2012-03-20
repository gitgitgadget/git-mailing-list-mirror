From: Ben Tebulin <nntp.20.jexpert@spamgourmet.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 13:00:25 +0100
Message-ID: <4F687159.20107@spamgourmet.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <CA+7g9JzfFg9U9qiWtjX5OgA5c=dS1bPWaXqMbmxAtzaQeKRF8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 13:15:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9xy8-00084C-Jy
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 13:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759846Ab2CTMPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 08:15:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:57724 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759083Ab2CTMPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 08:15:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S9xxw-0007xp-Jk
	for git@vger.kernel.org; Tue, 20 Mar 2012 13:15:04 +0100
Received: from 217.6.238.194 ([217.6.238.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 13:15:04 +0100
Received: from nntp.20.jexpert by 217.6.238.194 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 13:15:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 217.6.238.194
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <CA+7g9JzfFg9U9qiWtjX5OgA5c=dS1bPWaXqMbmxAtzaQeKRF8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193501>

> +1 for 'upstream'.  "Push" should mirror "pull" by the principle of
> least surprise.

One more +1 for 'upstream'!

After setting up remotes for a branch, 'matching' is convenient, but 
simply does not match the expectations of a newbie user.

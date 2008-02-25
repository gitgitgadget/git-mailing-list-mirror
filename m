From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH] Refresh history when "Refresh" is clicked in the
 history viewer.
Date: Sun, 24 Feb 2008 21:07:11 -0300
Message-ID: <47C206AF.8050904@intelinet.com.br>
References: <1203895097-3742-1-git-send-email-rogersoares@intelinet.com.br> <200802242340.09606.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 01:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTQsf-0005YF-Pd
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 01:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbYBYAHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 19:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbYBYAHF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 19:07:05 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1088 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752068AbYBYAHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 19:07:03 -0500
Received: (qmail 32781 invoked by uid 0); 24 Feb 2008 21:09:13 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.38029 secs); 25 Feb 2008 00:09:13 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 25 Feb 2008 00:09:11 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20080213)
In-Reply-To: <200802242340.09606.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74976>


Robin Rosenberg escreveu:
> Looks ok, but what is the effect of refresh, besides possibly working around
> other bugs? I would expect to to refresh with the selected resource as "filter",
> but it doesn't.
>   
If you checkout a branch in gitk or commit something using git-gui or 
git command line, egit will be out of sync. Refresh updates the history 
view to the current status.

I'm not sure I understand what you were expecting, what do you mean by 
"filter"?

[]s,
Roger.

From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: faster egit history page and a pure java "gitk"
Date: Mon, 24 Mar 2008 10:33:23 -0300
Message-ID: <47E7ADA3.2060906@intelinet.com.br>
References: <20080324092726.GQ8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 14:37:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdmrP-0005ZZ-Sk
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 14:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757131AbYCXNg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 09:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758047AbYCXNg3
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 09:36:29 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1850 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757056AbYCXNg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 09:36:28 -0400
Received: (qmail 28212 invoked by uid 0); 24 Mar 2008 10:38:52 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.995968 secs); 24 Mar 2008 13:38:52 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 24 Mar 2008 13:38:50 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20080213)
In-Reply-To: <20080324092726.GQ8410@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78033>


Shawn O. Pearce escreveu:
> OK, so I decided a few weeks back that the history page was not fast
> enough.  I think I've spent the past 3 weeks writing true revision
> machinary for jgit, and now connecting it up to a UI visualizer.
>
>   git://repo.or.cz/egit/spearce.git plotter
>
> The history page has been completely replaced.  I saw Roger has
> some patches against the current history page.  :-|
>   
Hi Shawn. This is awesome, I can't wait to see this integrated in the 
main repo :)

I don't spend much time working on egit so I usually take a while to 
make small things, but I can certainly merge my patches on top of yours.

Robin, how should I proceed, resend all my patches from the weekend on 
top of Shawn's tree?

[]s,
Roger.

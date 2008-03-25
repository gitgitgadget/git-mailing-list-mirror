From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: faster egit history page and a pure java "gitk"
Date: Tue, 25 Mar 2008 09:33:44 -0300
Message-ID: <47E8F128.1080609@intelinet.com.br>
References: <20080324092726.GQ8410@spearce.org> <47E7ADA3.2060906@intelinet.com.br> <20080325044308.GA4759@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 13:37:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je8PH-0005K1-Hf
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 13:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbYCYMgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 08:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbYCYMgy
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 08:36:54 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1070 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753668AbYCYMgx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 08:36:53 -0400
Received: (qmail 30467 invoked by uid 0); 25 Mar 2008 09:39:14 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.010879 secs); 25 Mar 2008 12:39:14 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 25 Mar 2008 12:39:14 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20080213)
In-Reply-To: <20080325044308.GA4759@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78185>

Shawn O. Pearce escreveu:
> I just pushed a newer version out that contains support for showing
> commits using a bold font if the commit has the highlightFlag set
> on it.  I assume you were trying to work on a feature like gitk
> has where you can type in a string and have gitk bold all of the
> commits that contain that string in the message, right?
>   
Yep, the find toolbar highlights the commits in bold. It's probably the 
first thing that I'll try to port. Thanks for the info.

[]s,
Roger.

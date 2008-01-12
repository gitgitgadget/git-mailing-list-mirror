From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH] Showing abbreviated commit hash of the versions
 in Compare editor.
Date: Sat, 12 Jan 2008 01:02:19 -0200
Message-ID: <47882DBB.2000308@intelinet.com.br>
References: <200801072315.30122.rogersoares@intelinet.com.br> <200801082312.00329.robin.rosenberg.lists@dewire.com> <4784247B.10604@intelinet.com.br> <200801110046.41786.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 04:02:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDWdg-00023v-Lb
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 04:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756395AbYALDCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 22:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755757AbYALDB7
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 22:01:59 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1207 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751645AbYALDB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 22:01:59 -0500
Received: (qmail 61944 invoked by uid 0); 12 Jan 2008 01:04:06 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.344153 secs); 12 Jan 2008 03:04:06 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 12 Jan 2008 03:04:05 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20071129)
In-Reply-To: <200801110046.41786.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70256>


Robin Rosenberg escreveu:
> I pushed my doc-branch as pu, you can look at it. My intention is take a look again
> and then push it as master if there are no objections. Is it ok and good to flags 
> public stuff without javadoc as an error (tip pu commit)?
>
> The abbr commit patch is already pushed to master.
>   
Looks good to me. You actually took some time to explain things, it will 
be usefull, thanks!
If we really want to document all the public methods then I think it's 
nice to flag it's absence as an error. It would have made me document 
GitResourceNode.getContentIdentifier(), it's now one more comment for 
you to add before pushing to master ;)

[]s,
Roger.

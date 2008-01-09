From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH] Showing abbreviated commit hash of the versions
 in Compare editor.
Date: Tue, 08 Jan 2008 23:33:47 -0200
Message-ID: <4784247B.10604@intelinet.com.br>
References: <200801072315.30122.rogersoares@intelinet.com.br> <200801082312.00329.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 02:33:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCPp4-0007Mw-Kg
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 02:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756680AbYAIBcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 20:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbYAIBcp
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 20:32:45 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1747 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757415AbYAIBcn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 20:32:43 -0500
Received: (qmail 13769 invoked by uid 0); 8 Jan 2008 23:35:06 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.013015 secs); 09 Jan 2008 01:35:06 -0000
Received: from unknown (HELO localhost.localdomain) (189.63.230.250)
  by cvxbsd.convex.com.br with SMTP; 9 Jan 2008 01:35:05 -0000
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <200801082312.00329.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69941>

Robin Rosenberg escreveu:
> I'm implementing fetch (with some help from Shawn). Progress in
> place. I still need to update refs and get in consistent with native
> git behaviour.
>
> I'm also updating the javadocs.
Cool.

I use a lot the eclipse feature that highlights all occurences of a 
variable or method but with all the warnings in the project it is 
difficult to visually find these occurences. So I'm anxious to remove a 
lot of warnings. Public methods without documentation are one of them. 
Is it ok if I send you a patch removing all the warnings I know how but 
the ones about public methods needing documentation as you're already 
documenting them? I also want to remove the auto generated TODOs, as 
they don't actually say what to do, like this one:
// TODO Auto-generated catch block

[]s,
Roger.

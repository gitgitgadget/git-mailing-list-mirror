From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT RFC] Git Repository Exploring
Date: Wed, 06 Feb 2008 22:35:47 -0200
Message-ID: <47AA5263.5060406@intelinet.com.br>
References: <47A8841E.7050009@intelinet.com.br> <200802052304.48382.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 01:35:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMujo-0007ES-6Y
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 01:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934461AbYBGAen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 19:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934013AbYBGAel
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 19:34:41 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1195 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1765279AbYBGAej (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 19:34:39 -0500
Received: (qmail 61260 invoked by uid 0); 6 Feb 2008 22:37:56 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.223484 secs); 07 Feb 2008 00:37:56 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 7 Feb 2008 00:37:55 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20071129)
In-Reply-To: <200802052304.48382.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72882>



Robin Rosenberg escreveu:
> Yes, but what infrastructure would that exploring facility work on? 
> Known gitweb's? 
>
> Anyway, by that time my fetch might be there. I was thinking about integrating
> it with File/Import and add a new Git>Clone source and just have a dialog where
> one could paste a URL-ish, user/password, or ssh public key. If you want to have
> go at the dialog, I'd appreciate that.
>
> I need to do at least basic local ref management in the fetching first, and maybe
> some more test cases. Speed is slightly slower than the C version, but not terribly
> so.
>   
I didn't really think about implementing anything for the exploring 
facility, at least not now. At the moment I like your dialog idea a lot 
more, so I'll give it a try.

[]s,
Roger.

From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH] Showing commit info like the CVS plugin instead
 of tooltips.
Date: Wed, 09 Jan 2008 22:17:37 -0200
Message-ID: <47856421.3070907@intelinet.com.br>
References: <200801072320.26987.rogersoares@intelinet.com.br> <200801082320.52548.robin.rosenberg.lists@dewire.com> <4784209D.6080100@intelinet.com.br> <200801091912.37723.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 01:17:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCl79-0005GA-3K
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 01:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbYAJARG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 19:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbYAJARF
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 19:17:05 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1914 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752635AbYAJARE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 19:17:04 -0500
Received: (qmail 53611 invoked by uid 0); 9 Jan 2008 22:19:20 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.220182 secs); 10 Jan 2008 00:19:20 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 10 Jan 2008 00:19:20 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20071129)
In-Reply-To: <200801091912.37723.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70029>



Robin Rosenberg escreveu:
>> Showing the tooltips when you press F2 makes more sense to me. What I'm 
>>     
> Actually not what I meant. Javadoc tooltips popup as a tooltip. When it is 
> active you can press F2 to see more information,
> copy text etc.
>   
Humnmn, I see...

>> For the search bar, I would like to make it visible by pressing ctrl-f 
>> when the history panel has the focus. 
>>     
> You're free to experiment. I'm quite fond of the search field in kmail. It is 
> a textfield that filters mail on
> header fields as I type.
>   
Yep, I'm willing to do something in this direction. The behavior I'm 
thinking right now won't be to hide the lines that don't match but to do 
more like gitk. Highlight rows and have next/previous buttons, and if 
possible show where I am (like 3/10 or 3 of 10).

> I found a bug. When you travel down the histtory using arrow keys all of the 
> sudden the commit info disappears.
>   
Cool, thanks, I'll investigate it.

[]s,
Roger.

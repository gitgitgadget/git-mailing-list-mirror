From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Sending a thread of patches
Date: Mon, 5 Mar 2007 02:42:05 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703050240360.5733@beast.quantumfyre.co.uk>
References: <45EB4F98.7030206@issaris.org> <Pine.LNX.4.64.0703042354250.15433@beast.quantumfyre.co.uk>
 <Pine.LNX.4.63.0703050324220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Panagiotis Issaris <takis@issaris.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 03:42:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO39Q-0002N9-09
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 03:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbXCECmI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 21:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbXCECmI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 21:42:08 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:43196 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbXCECmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 21:42:07 -0500
Received: (qmail 1321 invoked by uid 103); 5 Mar 2007 02:42:05 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2713. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.031189 secs); 05 Mar 2007 02:42:05 -0000
Received: from unknown (HELO beast.quantumfyre.co.uk) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 5 Mar 2007 02:42:05 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.63.0703050324220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41396>

On Mon, 5 Mar 2007, Johannes Schindelin wrote:

> Hi,
>
> On Sun, 4 Mar 2007, Julian Phillips wrote:
>
>> As far as I can figure, you don't want to use the --thread option to
>> git-format-patch when using git-send-email.
>
> That might be true. However, I consider it a bug when git-send-email does
> not replace the In-Reply-To: header, but adds a second one.

I wouldn't disagree with that.

FWIW, I seem to remember noticing that it did the same for References too 
...

-- 
Julian

  ---
BOFH Excuse #323:

Your processor has processed too many instructions.  Turn it off immediately, do not type any commands!!

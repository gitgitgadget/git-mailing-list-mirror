From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 0/2] Controversial blob munging series
Date: Mon, 23 Apr 2007 17:29:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704231725520.22673@reaper.quantumfyre.co.uk>
References: <11772221041630-git-send-email-junkio@cox.net>
 <Pine.LNX.4.64.0704231540580.8822@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:29:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg1QF-0002DX-0W
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 18:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbXDWQ3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 12:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbXDWQ3s
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 12:29:48 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:42848 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030188AbXDWQ3q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 12:29:46 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 1E3C4C613B
	for <git@vger.kernel.org>; Mon, 23 Apr 2007 17:29:45 +0100 (BST)
Received: (qmail 13414 invoked by uid 103); 23 Apr 2007 17:28:48 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3147. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.040191 secs); 23 Apr 2007 16:28:48 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 23 Apr 2007 17:28:48 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0704231540580.8822@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45332>

On Mon, 23 Apr 2007, Johannes Schindelin wrote:

> Being stuck with Pine, which still does not do Maildir, and wanting
> to be able to read my mails as distributed as I am working on documents
> and software projects, I always dreamt of having all my mail in Git.
>
> With filters, it should be relatively easy to do that. Before checking in,
> the individual mailbox files are split, the contents are put into the
> object database, and the mailbox file is replaced by a text file
> consisting of the SHA1s of the mails.
>
> Ideally, I would eventually not only teach Pine to understand Maildir
> format, but read and store the mails in a Git backend. Alas, I am way too
> lazy for that.

You do know about Eduardo Chappa's patches for pine?  In particular 
http://staff.washington.edu/chappa/pine/info/maildir.html.

-- 
Julian

  ---
Windows contains FAT.
Use Linux -- you won't ever have to worry about your weight.

    -- Ewout Stam

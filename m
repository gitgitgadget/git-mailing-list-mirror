From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Checklist clarifications: added "Commits", "Patch:"
 headings
Date: Mon, 30 Apr 2007 13:09:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704301306340.2279@reaper.quantumfyre.co.uk>
References: <r6q2xgws.fsf@cante.net> <Pine.LNX.4.64.0704301333400.29859@racer.site>
 <abwqxe6t.fsf@cante.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 14:09:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiUhC-0001IB-Cu
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 14:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423189AbXD3MJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 08:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423182AbXD3MJb
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 08:09:31 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:38680 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423189AbXD3MJa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2007 08:09:30 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id D2F2FC66CF
	for <git@vger.kernel.org>; Mon, 30 Apr 2007 13:09:28 +0100 (BST)
Received: (qmail 9331 invoked by uid 103); 30 Apr 2007 13:08:15 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3179. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.036058 secs); 30 Apr 2007 12:08:15 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 30 Apr 2007 13:08:15 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <abwqxe6t.fsf@cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45864>

On Mon, 30 Apr 2007, Jari Aalto wrote:

> Is this workding okay?
>
>        - send your patch to <git@vger.kernel.org> by using
>          git-format-patch(1) with option "-M". If you use
>          git-send-email(1), please test it first by sending
>          email to yourself.

I don't want to seem picky, but that wording suggests to me that the -M 
option to format-patch magically sends patches to the list.  Why not just 
have:

 	- use "git format-patch -M" to create the patch
 	- send your patch to <git@vger.kernel.org>. If you use
 	  git-send-email(1), please test it first by sending
 	  email to yourself.

-- 
Julian

  ---
My mother loved children -- she would have given anything if I had been one.
 		-- Groucho Marx

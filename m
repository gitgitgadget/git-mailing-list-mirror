From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 0/9] a couple cleanups and fixes to pack-objects
Date: Mon, 16 Apr 2007 17:40:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704161739100.22832@reaper.quantumfyre.co.uk>
References: <11767005762964-git-send-email-nico@cam.org>
 <7vslb0x4ww.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704161202320.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:40:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdUFO-0004gW-U3
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbXDPQkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbXDPQkF
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:40:05 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:43586 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752995AbXDPQkC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2007 12:40:02 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 2D424C62A6
	for <git@vger.kernel.org>; Mon, 16 Apr 2007 17:40:01 +0100 (BST)
Received: (qmail 27691 invoked by uid 103); 16 Apr 2007 17:39:22 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3087. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.036349 secs); 16 Apr 2007 16:39:22 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 16 Apr 2007 17:39:22 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.LFD.0.98.0704161202320.4504@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44676>

On Mon, 16 Apr 2007, Nicolas Pitre wrote:

> On Sun, 15 Apr 2007, Junio C Hamano wrote:
>
>> We probably found a bug in send-email.
>>
>>    Date: Mon, 16 Apr 2007 01:16:07 -0400
>>    From: Nicolas Pitre <nico@cam.org>
>>    Subject: [PATCH 0/9] a couple cleanups and fixes to pack-objects
>>    To: Junio C Hamano <junkio@cox.net>, "--cc git"@vger.kernel.org
                                            ^^^^^^^^^^
>>    Cc:
>>    Message-id: <11767005762964-git-send-email-nico@cam.org>
>>    X-Mailer: git-send-email 1.5.1.1.781.g65e8
>>    Content-transfer-encoding: 7BIT
>>    Xref: gitster.siamese.dyndns.org git-mail:23396
>>    Lines: 6
>>
>>    Here's a couple patches to clean up pack-objects which should also provide
>>    small performance gains, probably more visible on really large repositories.
>>
>>    Nicolas
>>
>> Your patches did not reach the list.
>
> Well... I guess I, too, should avoid git-send-email from now. I don't
> have enough knowledge of the mail/anti-spam protocol/pitfalls to fix it
> myself.

Looks more like finger trouble on the command line ... see above.

-- 
Julian

  ---
Necessity is a mother.

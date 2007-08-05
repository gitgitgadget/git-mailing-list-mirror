From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 16:24:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051622290.10235@beast.quantumfyre.co.uk>
References: <854pjfin68.fsf@lola.goethe.zz> <7v8x8qfnev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0708051519400.7631@beast.quantumfyre.co.uk>
 <85ps226mrc.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 17:24:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHhy6-0004nj-SG
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 17:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbXHEPYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 11:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbXHEPYa
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 11:24:30 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:52758 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751735AbXHEPYa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 11:24:30 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 2E622B8D62
	for <git@vger.kernel.org>; Sun,  5 Aug 2007 16:24:29 +0100 (BST)
Received: (qmail 25799 invoked by uid 103); 5 Aug 2007 16:24:28 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3855. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.030819 secs); 05 Aug 2007 15:24:28 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 5 Aug 2007 16:24:28 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <85ps226mrc.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55033>

On Sun, 5 Aug 2007, David Kastrup wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> On Sun, 5 Aug 2007, Junio C Hamano wrote:
>>> We would need an official terminology for it.
>>
>> Following was mentioned earlier in this thread ... could we use that?
>>
>> tracking branch:
>>   ref always points at a commit from the remote repo branch
>>
>> following branch:
>>   ref either points at a commit from the remote repo branch, or a
>>   local commit with a commit from the remote repo branch in the history
>>
>> perhaps?
>
> An auto-merging branch?  The term is somewhat more technical so that
> people are less likely to think it just a colloquial alternative
> expression for "tracking".

Personally I don't like auto-merging as it doesn't have any connotations 
of _what_ is auto-merged ... and it's not really an automatic merge 
anyway, you have to ask for it (by running pull).

-- 
Julian

  ---
Don't look back, the lemmings are gaining on you.

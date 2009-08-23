From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git-mail-commits (Re: What's a good setup for submitting patches
 to the list properly?)
Date: Mon, 24 Aug 2009 00:05:21 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0908232357590.15613@reaper.quantumfyre.co.uk>
References: <alpine.DEB.2.00.0908191849220.2012@GWPortableVCS> <200908222220.35354.chriscool@tuxfamily.org> <20090822205656.GA3526@vidovic> <200908230911.07218.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 01:09:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfMBX-0001z0-HX
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 01:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbZHWXI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 19:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbZHWXI6
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 19:08:58 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:48931 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750834AbZHWXI5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2009 19:08:57 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 6E4602759AD
	for <git@vger.kernel.org>; Mon, 24 Aug 2009 00:08:58 +0100 (BST)
Received: (qmail 1358 invoked by uid 103); 24 Aug 2009 00:05:21 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9727. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.035966 secs); 23 Aug 2009 23:05:21 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 24 Aug 2009 00:05:21 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <200908230911.07218.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126895>

On Sun, 23 Aug 2009, Christian Couder wrote:

> On Saturday 22 August 2009, Nicolas Sebrecht wrote:
>> The 22/08/09, Christian Couder wrote:
>>> There is "git send-email" that is bundled with git. But I use
>>> git-mail-commits from Julian Philips. I am very happy with it. Thanks
>>> Julian!
>>
>> Isn't there any public repo for it?
>
> Not that I know of, but I think it would be a good idea to publish it
> (perhaps in contrib/).
>
> Julian?

Using the awsome power of git I have managed to extract it from my random 
tools private repo to here as if I had written it to be a separate entity 
from the start:

git://git.q42.co.uk/mail_commits.git
(gitweb: http://git.q42.co.uk/w/mail_commits.git)

If it would be considered useful, then I can also create a patch to add it 
to contrib (there is a master branch in the above repo where I have 
subtree merged it in already - though that was more to experiment with 
doing subtree merging)

-- 
Julian

  ---
The means-and-ends moralists, or non-doers, always end up on their ends
without any means.
 		-- Saul Alinsky

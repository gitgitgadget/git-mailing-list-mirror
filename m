From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git-mail-commits (Re:What's a good setup for submitting patches
 to the list properly?)
Date: Tue, 25 Aug 2009 01:06:30 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0908250102580.28400@reaper.quantumfyre.co.uk>
References: <alpine.DEB.2.00.0908191849220.2012@GWPortableVCS> <200908222220.35354.chriscool@tuxfamily.org> <20090822205656.GA3526@vidovic> <200908230911.07218.chriscool@tuxfamily.org> <alpine.LNX.2.00.0908232357590.15613@reaper.quantumfyre.co.uk>
 <20090823234108.GB3526@vidovic>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Aug 25 02:07:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfjZ9-0004st-9P
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 02:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbZHYAHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 20:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381AbZHYAHA
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 20:07:00 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:37205 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753267AbZHYAHA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 20:07:00 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 2C7D0279B7C
	for <git@vger.kernel.org>; Tue, 25 Aug 2009 01:07:01 +0100 (BST)
Received: (qmail 26395 invoked by uid 103); 25 Aug 2009 01:06:30 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9729. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.035891 secs); 25 Aug 2009 00:06:30 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 25 Aug 2009 01:06:30 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20090823234108.GB3526@vidovic>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126982>

On Mon, 24 Aug 2009, Nicolas Sebrecht wrote:

> The 24/08/09, Julian Phillips wrote:
>> On Sun, 23 Aug 2009, Christian Couder wrote:
>>
>> Using the awsome power of git I have managed to extract it from my random
>> tools private repo to here as if I had written it to be a separate entity
>> from the start:
>>
>> git://git.q42.co.uk/mail_commits.git
>> (gitweb: http://git.q42.co.uk/w/mail_commits.git)
>
> Thanks a lot.
>
>> If it would be considered useful, then I can also create a patch to add
>> it to contrib
>
> I think it worth. That said, I would first add some config options like
> mail-commits.cc (not reviewed that much yet) to be a bit more consistent
> with the send-email program. I would also add README and INSTALL files.

Yeah ... it would be nice to have more options settable via config.  Some 
form of documentation would also be a good idea, and I would like to tidy 
the code up a bit.  Kinda sort on tuits just at the moment though ... :(

> Could you please consider to place your code under GPLv2?

I have added a license statement.

-- 
Julian

  ---
Thus spake the master programmer:
 	"When a program is being tested, it is too late to make design changes."
 		-- Geoffrey James, "The Tao of Programming"

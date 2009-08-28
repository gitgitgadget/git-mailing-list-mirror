From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Fri, 28 Aug 2009 13:10:02 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0908281238350.18415@reaper.quantumfyre.co.uk>
References: <87praj90n8.wl%catap@catap.ru> <1251228341-29434-1-git-send-email-catap@catap.ru> <4A97B1F3.5060408@gmail.com> <46a038f90908280405o1e86bf4fo60eb07957ce9158a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>,
	"Kirill A. Korinskiy" <catap@catap.ru>, gitster@pobox.com,
	git@vger.kernel.org, peff@peff.net, B.Steinbrink@gmx.de
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 14:11:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh0IU-0006ZB-NT
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 14:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbZH1MLC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 08:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbZH1MLC
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 08:11:02 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:50917 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750975AbZH1MLB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 08:11:01 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id B189D288C96
	for <git@vger.kernel.org>; Fri, 28 Aug 2009 13:11:02 +0100 (BST)
Received: (qmail 15116 invoked by uid 103); 28 Aug 2009 13:10:02 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9751. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.03465 secs); 28 Aug 2009 12:10:02 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 28 Aug 2009 13:10:02 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <46a038f90908280405o1e86bf4fo60eb07957ce9158a@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127292>

On Fri, 28 Aug 2009, Martin Langhoff wrote:

> On Fri, Aug 28, 2009 at 12:31 PM, Tor Arne Vestb?<torarnv@gmail.com> wrote:
>> Glad to see this topic being revised. Here's the original discussion for
>> reference:
>
> ISTR that early git supported this -- maybe just on the HTTP
> implementation? I sure remember writing
>
>   git clone http://host/foo.git#branchname
>
> and getting a cloned repo where 'branchname' was tracking
> 'origin/branchname', and was checked out as HEAD.

Did you use cogito perhaps?  That had #branch syntax IIRC ...

> It would have been dropped by the switch to C builtins :-/
>
> cheers,
>
>
>
> m
>

-- 
Julian

  ---
"What duck?"
         -- (Terry Pratchett, Soul Music)

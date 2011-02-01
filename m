From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: moving to a git-backed wiki
Date: Tue, 01 Feb 2011 14:48:45 -0800
Message-ID: <4D488DCD.3080305@eaglescrag.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org> <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org> <20110131225529.GC14419@sigill.intra.peff.net> <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com> <20110201201144.GA16003@sigill.intra.peff.net> <AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 23:49:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkP2I-0007F2-5c
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 23:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab1BAWtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 17:49:15 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:55039 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab1BAWtP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 17:49:15 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id p11Mmk0d007455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 1 Feb 2011 14:48:47 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Tue, 01 Feb 2011 14:48:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165873>

On 02/01/2011 02:36 PM, Jay Soffian wrote:
> On Tue, Feb 1, 2011 at 3:11 PM, Jeff King <peff@peff.net> wrote:
>>  https://github.com/peff/foo/wiki
> 
> A git-backed git wiki would be great. As a related matter, the hosting
> infrastructure for https://git.wiki.kernel.org/index.php/Main_Page
> seems overloaded. About half the time I try to access it, it's either
> down completely or very slow to respond. If the wiki were git-backed I
> could get to it even if the central site were down. :-)

The wiki will almost universally have a "central site" no matter what
the backend.  Personally I see little advantage to having a git backed
wiki myself.

Speaking to the slowness, it's caused by at least 2 different kernel
related bugs on the two boxes that run the wikis that I haven't had
enough time to track down to nail to specific developers to fix.  I have
20u of equipment sitting in my apartment that is heading to Portland in
the next two weeks to eliminate the bits I'm pretty sure are the root
cause of the problems.

Trust me when I say it's not only been a thorn in my side, and something
I've been rather angry at several people about, but it's something that
has kept me up at night trying to get fixed.

> That said, didn't the wiki just migrate to Mediawiki recently?

It did.

- John 'Warthog9' Hawley

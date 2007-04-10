From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [OT] Re: Feature request - Subtree checkouts
Date: Tue, 10 Apr 2007 15:56:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704101554500.27318@qynat.qvtvafvgr.pbz>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net><2007041013
 2011.GH5436@spearce.org>  <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.64.0704101338060.6730@
 woody.linux-foundation.org><Pine.LNX.4.64.0704101414330.15823@blackbox.fnor
 dora.org><Pine.LNX.4.64.0704101501590.6730@woody.linux-foundation.org><m3wt
 0j7sm6.fsf@zoo.weinigel.se> <Pine.LNX.4.64.0704101614370.17260@blackbox.fnordora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Christer Weinigel <christer@weinigel.se>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 08:35:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbPjp-0001vJ-FM
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 01:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbXDJX06 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 19:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbXDJX06
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 19:26:58 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:41465 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753674AbXDJX04 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 19:26:56 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 10 Apr 2007 16:26:56 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 10 Apr 2007 16:26:24 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0704101614370.17260@blackbox.fnordora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44198>

On Tue, 10 Apr 2007, alan wrote:

> 
> On Tue, 11 Apr 2007, Christer Weinigel wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>>> It's also possible to just not accept mail if the reverse lookup indicates
>>> that the sending IP address is a dynamic address, which you can sometimes
>>> see from the hostname. I would suggest you *not* name your hosts to
>>> contain a lot of numbers and the string "dhcp", for example ;)
>> 
>> That would be a very bad idea I think.  Doing that would lose quite a
>> lot of small companies and individuals such as me that run a mail
>> server but are unable to get the ISP to change the reverse DNS.  For
>> example I do have a fixed IP, but have an reverse DNS pointer which
>> looks like 1-2-3-4-5a.foo.bar.bostream.se.
>
> I am in the same situation.  I also have three domains.  Which one do I pick? 
> I can't afford to get an individual ip address for each.  Virtual servers on 
> a single ip also will have similar problems.

this isn't a problem. as long as you can lookup 1-2-3-4-5a.foo.bar.bostream.se. 
and get your IP address you pass this test.

David Lang

From: David Kastrup <dak@gnu.org>
Subject: Re: [msysGit] Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 17:21:09 +0100
Message-ID: <861w7ospoq.fsf@lola.quinscape.zz>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org>
	<CFB8A272-863C-4758-91F7-E9669D70A200@zib.de>
	<20080207123108.GA12009@bit.office.eurotux.com>
	<alpine.LSU.1.00.0802071255110.8543@racer.site>
	<20080207130715.GA14000@bit.office.eurotux.com>
	<alpine.LFD.1.00.0802070949460.2732@xanadu.home>
	<20080207155946.GA20459@bit.office.eurotux.com>
	<fofalu$gpo$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 17:22:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN9Vg-000836-QC
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 17:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbYBGQVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 11:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755277AbYBGQVZ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 11:21:25 -0500
Received: from main.gmane.org ([80.91.229.2]:44420 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224AbYBGQVY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 11:21:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JN9V0-0002dO-5N
	for git@vger.kernel.org; Thu, 07 Feb 2008 16:21:18 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 16:21:18 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 16:21:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:5s8qI/aoaWaGFkBVJCidDz0pCmo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72963>

Jakub Narebski <jnareb@gmail.com> writes:

> Luciano Rocha wrote:
>> On Thu, Feb 07, 2008 at 09:53:05AM -0500, Nicolas Pitre wrote:
>>> On Thu, 7 Feb 2008, Luciano Rocha wrote: 
>
>>>> I like and use GPL, but I won't force my users to accept the GPL in
>>>> order to use programs released under it.
>>> 
>>> What are they forced into if they indeed only want to _use_ Git?
>> 
>> The msys git installer forces me to accept the GNU GPL in order to
>> proceed.
>> 
>> Of course, I can use another installer, or compile my own set of
>> binaries. I just wanted to bring that case to attention, nothing else.
>> 
>>> They nevertheless must be made aware of the rules they have to follow in 
>>> case the idea of redistributing it crosses their mind.
>> 
>> I don't dispute that, only that I can't continue with the install unless
>> I click on "I Accept" to the GNU GPL.
>
> So, would you prefer to be presented with GNU GPL with two buttons:
> "That's great" and "Oh, f**k", instead of "I Accept" and "Cancel",
> both of which would allow to install msysGit? ;-ppppppp

"That's great" and "I don't mind" would probably be more appropriate.
If the installer will have one button abort, the easiest solution would
be probably to offer

"Continue" "Abort"

That shows what will happen when clicking the respective button without
insinuating legal repercussions.

-- 
David Kastrup

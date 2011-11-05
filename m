From: Gelonida N <gelonida@gmail.com>
Subject: Re: share object storage for multiple clones of different repositories
Date: Sat, 05 Nov 2011 17:20:25 +0100
Message-ID: <j93no9$htt$1@dough.gmane.org>
References: <j91rcq$1uo$1@dough.gmane.org> <7vobwr9uf0.fsf@alter.siamese.dyndns.org> <op.v4gp4mai0aolir@keputer.lokaal> <j93mu2$ce7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 17:20:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMiz5-0000H4-Hq
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 17:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab1KEQUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 12:20:39 -0400
Received: from lo.gmane.org ([80.91.229.12]:52839 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab1KEQUi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 12:20:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RMiyz-0000EG-OV
	for git@vger.kernel.org; Sat, 05 Nov 2011 17:20:37 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 17:20:37 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 17:20:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <j93mu2$ce7$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184857>

On 11/05/2011 05:06 PM, Gelonida N wrote:
> Thanks for both of your replies,
> 
> 
> I'll probably mix both approaches and try out how it works.
> I didn't know about git.git
> What is the best url for an intrudoction into git.git?
> 
> 
>>
>> Alternatively there's the git-new-workdir script in contrib/workdir in
>> git.git. Haven't tested it, but it seems like it does what you want.
>>
>> Frans
> 
> 

In an installed git (at least on Ubuntu) the contrib directory can be
found at /usr/share/doc/git/contrib

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Fri, 04 Aug 2006 22:37:56 +0200
Organization: At home
Message-ID: <eb0b5r$lav$1@sea.gmane.org>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com> <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org> <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com> <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org> <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org> <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com> <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com> <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org> <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com> <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org> <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com> <Pine.LNX.4.64.0608041027530.5167@g5.osdl.org> <Pine.LNX.4.64.0608041052030.5167@g5.osdl.org> <7v64h8l5om.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0608041218390.5167@g5.osdl.org> <87d5bgmh5r.wl%cworth@cworth.org> <7vodv0i89m.fsf@assigned-by-dhcp.cox.net> <eb09ln$h7k$1@sea.gmane.o
 rg> <7vd5bgi6qt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 04 22:38:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G96Qn-0002eg-Fi
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 22:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161401AbWHDUhw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 16:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161403AbWHDUhw
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 16:37:52 -0400
Received: from main.gmane.org ([80.91.229.2]:7085 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161401AbWHDUhw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 16:37:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G96QO-0002aN-Ee
	for git@vger.kernel.org; Fri, 04 Aug 2006 22:37:40 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 22:37:40 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 22:37:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24837>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Junio C Hamano wrote:
>>
>>> There _already_ is a command called git-show-index, since early
>>> July last year ;-).
>>
>> Parhaps it should be renamed then, for consistency? 
> 
> There isn't anything to make consistent.  We use the word 
> "index" to mean both dircache and the pack index files.
> Usually you can tell between the two usage from context.

Oops. I should say, for better readibility (to not depend on context), then.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

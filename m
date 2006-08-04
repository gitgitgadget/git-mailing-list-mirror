From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Fri, 04 Aug 2006 22:12:16 +0200
Organization: At home
Message-ID: <eb09ln$h7k$1@sea.gmane.org>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com> <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org> <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com> <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org> <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org> <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com> <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com> <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org> <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com> <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org> <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com> <Pine.LNX.4.64.0608041027530.5167@g5.osdl.org> <Pine.LNX.4.64.0608041052030.5167@g5.osdl.org> <7v64h8l5om.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0608041218390.5167@g5.osdl.org> <87d5bgmh5r.wl%cworth@cworth.org> <7vodv0i89m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 04 22:12:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9620-00075B-CL
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 22:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161396AbWHDUME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 16:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161397AbWHDUME
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 16:12:04 -0400
Received: from main.gmane.org ([80.91.229.2]:15801 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161396AbWHDUMC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 16:12:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G961O-0006zP-IU
	for git@vger.kernel.org; Fri, 04 Aug 2006 22:11:50 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 22:11:50 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 22:11:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24834>

Junio C Hamano wrote:

> Carl Worth <cworth@cworth.org> writes:
> 
>> On Fri, 4 Aug 2006 12:20:36 -0700 (PDT), Linus Torvalds wrote:
>>> > > To get a list of all object names in a pack-file, you'd basically do
just
>>> > > something like the appended.
>>> >
>>> > git-show-index?
>>>
>>> Yeah, that might be good.
>>
>> That clashes pretty badly with update-index. git-show-pack-index
>> perhaps?
> 
> There _already_ is a command called git-show-index, since early
> July last year ;-).

Parhaps it should be renamed then, for consistency? 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

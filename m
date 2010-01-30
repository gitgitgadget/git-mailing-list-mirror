From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 22:25:09 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-B18EFA.22250929012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <7vaavwh6yh.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001291833580.1681@xanadu.home> <7vy6jgcutb.fsf@alter.siamese.dyndns.org> <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com> <7viqakcu56.fsf@alter.siamese.dyndns.org> <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com> <alpine.LFD.2.00.1001292013150.1681@xanadu.home> <ron1-F006CF.18381129012010@news.gmane.org> <7vbpgc8fhb.fsf@alter.siamese.dyndns.org> <76718491001292052x7f46d479lfeff7b66121502c3@mail.gmail.com> <alpine.LFD.2.00.1001300011290.1681@xanadu.home> <7v1vh8417w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 07:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb6qa-0003V1-SG
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 07:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab0A3GaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 01:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484Ab0A3GaN
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 01:30:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:40006 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab0A3GaM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 01:30:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nb6qJ-0003Ki-Ut
	for git@vger.kernel.org; Sat, 30 Jan 2010 07:30:03 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 07:30:03 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 07:30:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138455>

In article <7v1vh8417w.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Could you please take this really nice explanation and make it into a 
> > patch adding a "Detached HEAD" section in the git-checkout.txt manual 
> > page please?
> 
> Good suggestion.
> 
> I'd be happier if the description didn't say "SHA-1", but instead said
> "object name".
> 
> Also it would be nicer (just a personal preference) if a picture that
> forks only one branch forks it upwards, like this:
> 
>              o---o
>             /    
>     ---o---o---o
> 
> not downwards, like this:
> 
>     ---o---o---o
>             \
>              o---o

Just out of curiosity, why does this matter to you?  Downwards seems 
more intuitive to me.  Time should advance left to right and top to 
bottom IMHO.

rg

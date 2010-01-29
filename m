From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 14:18:40 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-D5CC8E.14184029012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com> <alpine.DEB.1.00.1001292131330.3749@intel-tinevez-2-302> <ron1-F6943B.13162129012010@news.gmane.org> <8c9a061001291325i4b8898b9m46054040c69f8fc6@mail.gmail.com> <ron1-A90E72.13434029012010@news.gmane.org> <7veil8h8rk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 23:19:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NazBK-00060q-GS
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741Ab0A2WTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755061Ab0A2WTG
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:19:06 -0500
Received: from lo.gmane.org ([80.91.229.12]:36387 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139Ab0A2WTE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:19:04 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NazB6-0005si-B7
	for git@vger.kernel.org; Fri, 29 Jan 2010 23:19:00 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 23:19:00 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 23:19:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138386>

In article <7veil8h8rk.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Ron Garret <ron1@flownet.com> writes:
> 
> > Of course it's possible.  It git can complain and do something (which is 
> > what it does now) then it can just as easily complain and do nothing.
> 
> It is not complaining.  It is telling you that you might have triggered an
> advanced feature you may not be prepared to use yet.
> 
> So forbidding the advanced feature from everybody won't be a solution.

s/complain/warn/

I'm just suggesting that maybe triggering the advanced feature ought not 
to be such an easy thing to do by accident.  It's certainly possible to 
make that change.  Reasonable people could disagree over whether this is 
desirable, or whether it would be better to just add this to a FAQ 
somewhere, or maybe even just leave this as a rite of passage.  
Apparently I'm the first person to ever have this problem or it would 
not have triggered so much discussion.

rg

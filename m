From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/28] clean-ups of static functions and returns
Date: Mon, 14 Aug 2006 23:22:36 +0200
Organization: At home
Message-ID: <ebqphe$1ga$1@sea.gmane.org>
References: <Pine.LNX.4.63.0608141314350.19383@chino.corp.google.com> <ebqmlk$npt$1@sea.gmane.org> <Pine.LNX.4.63.0608141345530.19669@chino.corp.google.com> <Pine.LNX.4.63.0608142257130.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 14 23:22:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCjtP-0001Zx-Dq
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 23:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWHNVW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 17:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWHNVW0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 17:22:26 -0400
Received: from main.gmane.org ([80.91.229.2]:24769 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964955AbWHNVWY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 17:22:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GCjsr-0001SK-So
	for git@vger.kernel.org; Mon, 14 Aug 2006 23:22:05 +0200
Received: from host-81-190-23-158.torun.mm.pl ([81.190.23.158])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 23:22:05 +0200
Received: from jnareb by host-81-190-23-158.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 23:22:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-158.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25412>

Johannes Schindelin wrote:

> On Mon, 14 Aug 2006, David Rientjes wrote:
> 
>> On Mon, 14 Aug 2006, Jakub Narebski wrote:
>> > Could you please make description of patch series email to be parent
>> > (ancestor) of all patches emails, i.e. for patches either to be 
>> > chain-replied to introduction email, or all be replies to introduction
>> > email.
>> > 
>> > It makes for easier reading/viewing/applying/ignoring the series.
>> > 
>> 
>> Sure, but you might also want to include this request explicitly in 
>> Documentation/SubmittingPatches.
> 
> Well... there are people (like yours truly), who still hack there mails in 
> pine, and who do not use git-send-email (I had too many problems with 
> Perl, and git-send-email _is_ in Perl)... For me, it would be an undue 
> burden.

I also not always use git-send-email (because of the box connection to the
net); mu latest series of patches was send using KMail; still it is not
that hard to send patches as reply to introductory letter, or
chain-replied; just reply-all (without quoting) from your "sent" folder.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

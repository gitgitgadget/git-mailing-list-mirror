From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range	completion
Date: Tue, 15 Jul 2008 10:17:37 +0200
Message-ID: <487C5D21.2040703@op5.se>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org> <20080714000021.GB13066@spearce.org> <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org> <20080714062755.GA15992@spearce.org> <alpine.LFD.1.10.0807140741580.3305@woody.linux-foundation.org> <20080715042553.GD2432@spearce.org> <487C5A2D.3000707@op5.se> <487C5B72.5040502@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 10:19:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIfkx-0005JF-Iq
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 10:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbYGOISc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 04:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754120AbYGOISb
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 04:18:31 -0400
Received: from mail.op5.se ([193.201.96.20]:60728 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbYGOISa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 04:18:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2ADC024B0011;
	Tue, 15 Jul 2008 10:18:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.358
X-Spam-Level: 
X-Spam-Status: No, score=-4.358 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.041, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E4K+Sns3UaFE; Tue, 15 Jul 2008 10:18:33 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.154])
	by mail.op5.se (Postfix) with ESMTP id 7B1B524B0009;
	Tue, 15 Jul 2008 10:18:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <487C5B72.5040502@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88539>

Andreas Ericsson wrote:
> Andreas Ericsson wrote:
> 
> [ a whitespace damaged patch ]
> 
> Sorry about that. I'll try again in a short while. It seems sending
> patches with thunderbird no longer works like it used to.
> 

Apparently it wasn't ws-damaged after all. Just my font-settings
acting up on me.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Thu, 16 Feb 2006 11:10:45 +0000
Message-ID: <tnxfymjd0ei.fsf@arm.com>
References: <43F1F5CB.10402@citi.umich.edu>
	<20060214160747.GA6350@diana.vm.bytemark.co.uk>
	<43F2445A.6020109@citi.umich.edu> <20060214222913.GK31278@pasky.or.cz>
	<43F2745D.4010800@vilain.net> <20060215003510.GA25715@spearce.org>
	<20060215041142.GA21048@fieldses.org>
	<20060215065411.GB26632@spearce.org>
	<7vbqx7bnz7.fsf@assigned-by-dhcp.cox.net>
	<b0943d9e0602160233i68fe5879y@mail.gmail.com>
	<20060216104224.GA29192@ferdyx.org>
	<7v64nfbmo6.fsf@assigned-by-dhcp.cox.net>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Fernando J. Pereda" <ferdy@ferdyx.org>,
	Shawn Pearce <spearce@spearce.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,
	Chuck Lever <cel@citi.umich.edu>,
	=?iso-8859-1?q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 12:12:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9h3i-0005iA-D3
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 12:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWBPLMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 06:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWBPLMW
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 06:12:22 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:52632 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751330AbWBPLMU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 06:12:20 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k1GBAp6s028257;
	Thu, 16 Feb 2006 11:10:52 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 16 Feb 2006 11:10:51 +0000
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64nfbmo6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 16 Feb 2006 02:52:41 -0800")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 16 Feb 2006 11:10:51.0693 (UTC) FILETIME=[A5CAADD0:01C632E9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16294>

Junio C Hamano <junkio@cox.net> wrote:
> "Fernando J. Pereda" <ferdy@ferdyx.org> writes:
>
>> That's because you told mutt you are subscribed to that list, so mutt
>> won't add you to Mail-Followup-To:, so you don't get duplicates. If you
>> don't tell mutt you are subscribed to the list, It will add your own
>> addres there.
>>
>> I think it is a nice feature, although it seems to annoy Junio :)
>
> Rightfully so.
>
> Last I heard that was a feature mutt people regret.  Go back to
> the mail archive for details -- you robbed me 30 seconds so I
> won't do a research for you this time as I usually do ;-).

For Gnus users:

(setq message-use-mail-followup-to nil)

-- 
Catalin

From: Pedro Melo <melo@simplicidade.org>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Thu, 16 Oct 2008 10:43:01 +0100
Message-ID: <B6E3AB69-374D-403A-8451-341C4B516506@simplicidade.org>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lars Hoss <lars@woeye.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 11:44:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqPP5-0004Lr-OL
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 11:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbYJPJnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 05:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752840AbYJPJnJ
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 05:43:09 -0400
Received: from speed.simplicidade.org ([81.92.204.129]:43975 "HELO
	speed.simplicidade.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752046AbYJPJnI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 05:43:08 -0400
Received: (qmail 1263 invoked from network); 16 Oct 2008 09:43:10 -0000
Received: from bl4-247-138.dsl.telepac.pt (HELO [192.168.0.201]) (81.193.247.138)
  (smtp-auth username melo@simplicidade.org, mechanism cram-md5)
  by speed.simplicidade.org (qpsmtpd/0.43rc1) with (AES256-SHA encrypted) ESMTPSA; Thu, 16 Oct 2008 10:43:10 +0100
In-Reply-To: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
X-Priority: 3 (Normal)
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98356>

Hi,

On Oct 15, 2008, at 1:07 PM, Lars Hoss wrote:

> Greetings all,
>
> two days ago I posted about an issue:
> http://thread.gmane.org/gmane.comp.version-control.git/98171
>
> After more testing I can confirm it is indeed a bug.
>
> 1.6.0.2 on OSX Leopard doesn't work. After adding a submodule
> the folder of the submodule will always get listed under
> "Untracked files" when calling git status.

I'm using  1.6.0.2.526.g5c283 on Leopard with lots of submodules  
without any problems at all.

I was going to reply to your original message but it slipped my mind  
(commuting et al).

Can you provide a sequence of commands that demonstrate the problem so  
that I can try?

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!

From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 6/5] NUL hack to create_file()
Date: Thu, 29 May 2008 19:44:00 +0200
Message-ID: <20080529174400.GA5596@steel.home>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com> <1212020246-26480-2-git-send-email-gitster@pobox.com> <1212020246-26480-3-git-send-email-gitster@pobox.com> <1212020246-26480-4-git-send-email-gitster@pobox.com> <1212020246-26480-5-git-send-email-gitster@pobox.com> <1212020246-26480-6-git-send-email-gitster@pobox.com> <1212020246-26480-7-git-send-email-gitster@pobox.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 19:45:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1mBM-00076j-FW
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 19:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbYE2RoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 13:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbYE2RoE
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 13:44:04 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:16185 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbYE2RoD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 13:44:03 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarAeHyO1Gg==
Received: from tigra.home (Faca8.f.strato-dslnet.de [195.4.172.168])
	by post.webmailer.de (klopstock mo40) (RZmta 16.38)
	with ESMTP id L027d9k4THU5YF ; Thu, 29 May 2008 19:44:01 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0E654277BD;
	Thu, 29 May 2008 19:44:01 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D473F56D28; Thu, 29 May 2008 19:44:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1212020246-26480-7-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83226>

Junio C Hamano, Thu, May 29, 2008 02:17:26 +0200:
> This is not meant for application to the mainline. ...

That's good. No one besides Windows has such a stupid filesystem.

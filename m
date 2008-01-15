From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] parse_commit_buffer: don't parse invalid commits
Date: Tue, 15 Jan 2008 08:32:59 +0100
Message-ID: <478C61AB.2040103@viscovery.net>
References: <12003456313661-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Jan 15 08:33:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEgIi-0000K5-Ei
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 08:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbYAOHdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 02:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbYAOHdH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 02:33:07 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21741 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbYAOHdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 02:33:06 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JEgI3-000867-Ur; Tue, 15 Jan 2008 08:32:56 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C70074E4; Tue, 15 Jan 2008 08:32:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <12003456313661-git-send-email-mkoegler@auto.tuwien.ac.at>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70506>

Martin Koegler schrieb:
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>

Quite a lot has been said about this change and you had a hard time
defending it. Why doesn't *anything* of that discussion end up in the
commit message? The absolute minimum that belongs there is your definition
of "invalid commit".

-- Hannes

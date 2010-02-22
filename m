From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Feb 2010, #05; Sun, 21)
Date: Mon, 22 Feb 2010 08:35:58 +0100
Message-ID: <4B8233DE.7050106@viscovery.net>
References: <7vtytacebd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 09:40:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjSq4-0002L2-3x
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 08:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab0BVHgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 02:36:08 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:11056 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751292Ab0BVHgG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 02:36:06 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NjSpj-0003v9-B4; Mon, 22 Feb 2010 08:35:59 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 182151660F;
	Mon, 22 Feb 2010 08:35:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vtytacebd.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140643>

Since you do not publish your topic branches, I'd appreciate if you could
include the SHA1 of the topic heads in the headlines, for example:

* jn/maint-fix-pager 2d3ca21 (2010-02-20) 7 commits

This way I could copy-paste the branch name and SHA1 to a 'git branch -f'
command to track the topic manually.

-- Hannes

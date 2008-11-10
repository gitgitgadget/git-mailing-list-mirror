From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 08:26:56 +0100
Message-ID: <4917E240.1060409@viscovery.net>
References: <87ljvsjuq7.fsf@erwin.mina86.com>	<bd6139dc0811091643m31ff6f49o55a4c581be7f38b2@mail.gmail.com> <87hc6gjs7v.fsf@erwin.mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, git@vger.kernel.org
To: Michal Nazarewicz <mina86@tlen.pl>
X-From: git-owner@vger.kernel.org Mon Nov 10 08:28:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzRCC-0000ul-3K
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 08:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbYKJH1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 02:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbYKJH1D
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 02:27:03 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39295 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbYKJH1B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 02:27:01 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KzRAm-0002Tk-LT; Mon, 10 Nov 2008 08:26:57 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 590974FB; Mon, 10 Nov 2008 08:26:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <87hc6gjs7v.fsf@erwin.mina86.com>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100494>

Michal Nazarewicz schrieb:
> (Besides I would prefer
> $Date$ more but I can live with $Id$ I guess ;) ).

Just FYI: The $Id$ that git produces is completely different from what CVS
produces and probably not what you expect: 'man gitattributes'

-- Hannes

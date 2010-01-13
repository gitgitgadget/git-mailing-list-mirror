From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add `format.to` configuration variable.
Date: Wed, 13 Jan 2010 09:20:58 +0100
Message-ID: <4B4D826A.7090405@viscovery.net>
References: <alpine.LNX.2.00.1001132054380.24673@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Jan 13 09:21:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUyTZ-0002wF-Rv
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 09:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab0AMIVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 03:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578Ab0AMIVF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 03:21:05 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13768 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932070Ab0AMIVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 03:21:04 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NUyTL-0005eh-1B; Wed, 13 Jan 2010 09:20:59 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A7B0B1660F;
	Wed, 13 Jan 2010 09:20:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.LNX.2.00.1001132054380.24673@vqena.qenxr.bet.am>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136789>

You submitted a number of patches in the last hours, but you gave *zero*
motivation for them, i.e., the commit messages lack words about *why* the
changes are good (and what they are good for).

This particular patch lacks documentation, in particular, it's worth to
mention that format.to could be given more than once.

-- Hannes

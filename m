From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] rev-parse --branches/--tags/--remotes=pattern
Date: Thu, 21 Jan 2010 13:51:41 +0100
Message-ID: <4B584DDD.7060701@viscovery.net>
References: <1263980906-11058-1-git-send-email-ilari.liusvaara@elisanet.fi> <1263980906-11058-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Jan 21 13:51:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXwVr-0007mJ-3V
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 13:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab0AUMvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 07:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466Ab0AUMvq
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 07:51:46 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30731 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab0AUMvq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 07:51:46 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NXwVi-00073E-0j; Thu, 21 Jan 2010 13:51:42 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A4E601660F;
	Thu, 21 Jan 2010 13:51:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1263980906-11058-2-git-send-email-ilari.liusvaara@elisanet.fi>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137653>

Works for me, thank you very much!

Junio, kindly squash in these speeling fixes in both patches:

sed -i 's/impiled/implied/g' `git diff HEAD^ --name-only Documentation/`

-- Hannes

From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Make 'rerere forget' work from a subdirectory.
Date: Thu, 21 Jan 2010 10:31:18 +0100
Message-ID: <4B581EE6.70601@viscovery.net>
References: <7veill3wgc.fsf@alter.siamese.dyndns.org> <4B56F916.7090503@viscovery.net> <4B580F14.5060105@viscovery.net> <7v7hrbx31c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 10:31:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXtNw-0001B9-U1
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 10:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962Ab0AUJbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 04:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754901Ab0AUJbY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 04:31:24 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35809 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777Ab0AUJbY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 04:31:24 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NXtNn-0008Eg-7S; Thu, 21 Jan 2010 10:31:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F06B91660F;
	Thu, 21 Jan 2010 10:31:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7v7hrbx31c.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137645>

Junio C Hamano schrieb:
> Thanks; will squash this in (which fails without and passes with your patch). 

Thanks; it catches the breakage and verifies the fix here on Windows
as well.

-- Hannes

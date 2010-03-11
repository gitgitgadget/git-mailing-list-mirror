From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: using gvim as editor on Windows
Date: Thu, 11 Mar 2010 10:36:48 +0100
Message-ID: <4B98B9B0.2010806@viscovery.net>
References: <20100306070628.GM2480@ece.pdx.edu> <201003061317.38422.markus.heidelberg@web.de> <20100308185439.GO2480@ece.pdx.edu> <201003090032.10037.markus.heidelberg@web.de> <20100309024523.GU2480@ece.pdx.edu> <7vzl2hw972.fsf@alter.siamese.dyndns.org> <20100311090424.GV2480@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 10:37:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpepA-0005WF-Pd
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 10:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab0CKJgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 04:36:55 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:23557 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752484Ab0CKJgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 04:36:54 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Npeoz-0000gB-Ac; Thu, 11 Mar 2010 10:36:49 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0D4251660F;
	Thu, 11 Mar 2010 10:36:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100311090424.GV2480@ece.pdx.edu>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141944>

Tait schrieb:
>> If you end up with a file whose name literally is '$@', that probably
>> means your "sh" did not expand it correctly.
> 
> It does expand the $@ when I add it explicitly to core.editor though. Maybe
> it's the ""s. I'll have to figure out how to compile git for Windows
> to try a patch.
> 
> Oddly enough, if I remove the : from the file path, it does work as
> expected. Adding the : back introduces the faulty behavior described
> earlier.

Which : are you talking about?

-- Hannes

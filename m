From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: No working tree repository
Date: Wed, 16 Jun 2010 08:20:53 +0200
Message-ID: <4C186D45.7030203@viscovery.net>
References: <4C17BEB7.90403@cfl.rr.com> <vpqy6egi2va.fsf@bauges.imag.fr> <4C17C77C.9000002@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 08:21:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOlzi-0007Wp-GT
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 08:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288Ab0FPGU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 02:20:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13507 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324Ab0FPGU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 02:20:56 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OOlzZ-0005Ha-U1; Wed, 16 Jun 2010 08:20:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 900151660F;
	Wed, 16 Jun 2010 08:20:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4C17C77C.9000002@cfl.rr.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149250>

Am 6/15/2010 20:33, schrieb Phillip Susi:
> but I can't figure out how to empty the index.

git rm -r .

-- Hannes

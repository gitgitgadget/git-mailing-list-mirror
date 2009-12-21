From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: possible code error at run_command.c
Date: Mon, 21 Dec 2009 09:30:02 +0100
Message-ID: <4B2F320A.6010908@viscovery.net>
References: <1976ea660912202246k45732bf2p111bbeb78047693e@mail.gmail.com>	 <4B2F214D.2020905@viscovery.net>	 <1976ea660912202329x42f6add3j9175867e8723a4bd@mail.gmail.com>	 <4B2F2727.4060405@viscovery.net> <1976ea660912210018y15acfe32o78841d5e0968f793@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 09:30:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMdei-0003vD-07
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 09:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbZLUIaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 03:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbZLUIaH
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 03:30:07 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29091 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750702AbZLUIaG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 03:30:06 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NMdeU-0002zf-VX; Mon, 21 Dec 2009 09:30:03 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A466B1660F;
	Mon, 21 Dec 2009 09:30:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1976ea660912210018y15acfe32o78841d5e0968f793@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135548>

Frank Li schrieb:
> Maybe some excute path miss initialized it. Otherwise compiler will
> not report warning.

LOOK AT THE CODE. There is no such code path.

-- Hannes

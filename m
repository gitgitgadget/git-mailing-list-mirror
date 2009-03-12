From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: newb: Given a commit id, find which branches have it as an ancestor
Date: Thu, 12 Mar 2009 16:38:15 +0100
Message-ID: <49B92C67.5080304@viscovery.net>
References: <63BEA5E623E09F4D92233FB12A9F794302E0F98D@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 16:45:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhn0h-0007sv-Q3
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 16:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbZCLPiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 11:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbZCLPiU
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 11:38:20 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:60865 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbZCLPiT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 11:38:19 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lhmz9-0008US-UM; Thu, 12 Mar 2009 16:38:16 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9A88869F; Thu, 12 Mar 2009 16:38:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302E0F98D@emailmn.mqsoftware.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113081>

$ git branch -a --contains the-sha1

-- Hannes

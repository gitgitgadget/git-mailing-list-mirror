From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Wed, 21 Nov 2007 08:44:22 +0100
Message-ID: <4743E1D6.4010308@viscovery.net>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 08:44:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IukGI-0000qW-It
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 08:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735AbXKUHoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 02:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756270AbXKUHoZ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 02:44:25 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58306 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525AbXKUHoY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 02:44:24 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IukFN-0003ZR-0u; Wed, 21 Nov 2007 08:43:45 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 251C96EF; Wed, 21 Nov 2007 08:44:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711210336210.27959@racer.site>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65614>

Johannes Schindelin schrieb:
> 	Oh, and it relies on "int" being castable to void * and vice 
> 	versa.  Is anybody aware of a platform where this can lead to
> 	problems?

Win64?

-- Hannes

From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] teach diff machinery about --ignore-space-at-eol
Date: Wed, 14 Feb 2007 11:18:15 -0600
Organization: Freescale
Message-ID: <45D34457.8050207@freescale.com>
References: <45D234C5.5090005@freescale.com> <7vhctpwvam.fsf@assigned-by-dhcp.cox.net> <45D23D68.6040004@freescale.com> <Pine.LNX.4.63.0702140125410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:20:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNoB-0000LL-9y
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbXBNRUk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbXBNRUk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:20:40 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:43196 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbXBNRUj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:20:39 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l1EHIGuH028001;
	Wed, 14 Feb 2007 10:18:16 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l1EHIF3N001845;
	Wed, 14 Feb 2007 11:18:15 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
In-Reply-To: <Pine.LNX.4.63.0702140125410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39694>

Johannes Schindelin wrote:
> `git diff --ignore-space-at-eol` will ignore whitespace at the
> line ends.
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

This patch works great!  Oh git maintainer, please please please please apply 
this patch to the next version of git.  My descendants will sing praises to your 
glory for a thousand years.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

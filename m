From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fix t1504 on Windows
Date: Fri, 06 Feb 2009 14:36:49 +0100
Message-ID: <498C3CF1.3000208@viscovery.net>
References: <498A1E1E.8010901@lsrfire.ath.cx> <498B3F6B.5080002@lsrfire.ath.cx> <498C3328.70804@viscovery.net> <alpine.DEB.1.00.0902061410210.7377@intel-tinevez-2-302> <498C3871.5000507@viscovery.net> <alpine.DEB.1.00.0902061425180.7377@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 14:38:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVQuS-0002Q0-Eb
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 14:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbZBFNgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 08:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753576AbZBFNgx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 08:36:53 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43716 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbZBFNgx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 08:36:53 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LVQsz-0002P6-VG; Fri, 06 Feb 2009 14:36:50 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AF44D4E4; Fri,  6 Feb 2009 14:36:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.DEB.1.00.0902061425180.7377@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108704>

Johannes Schindelin schrieb:
> So the path mangling only hits you when you run a shell script, such as 
> the tests?

Correct.

-- Hannes

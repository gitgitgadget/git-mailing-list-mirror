From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: how to change/fake the time for next commit ?
Date: Fri, 23 Nov 2007 08:20:36 +0100
Message-ID: <47467F44.80307@viscovery.net>
References: <46d6db660711221629j5d294a5dp4771778e38b14962@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 08:21:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvSqT-0005d3-RC
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 08:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbXKWHUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 02:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352AbXKWHUj
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 02:20:39 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24900 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbXKWHUi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 02:20:38 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IvSpS-00057r-1K; Fri, 23 Nov 2007 08:19:58 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A4C46546; Fri, 23 Nov 2007 08:20:36 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46d6db660711221629j5d294a5dp4771778e38b14962@mail.gmail.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65873>

Christian MICHON schrieb:
> I'd like to recreate a git repo with kernel version, using exclusively
> tar.bz2 files.

There's contrib/fast-import/import-tars.perl.

-- Hannes

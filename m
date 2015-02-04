From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git tag --no-merged?
Date: Wed, 04 Feb 2015 19:57:00 +0100
Message-ID: <54D26B7C.7020300@kdbg.org>
References: <alpine.DEB.2.00.1502041615110.30476@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Feb 04 19:57:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJ58X-0002Yo-5R
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 19:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161669AbbBDS5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 13:57:09 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:14941 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161480AbbBDS5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2015 13:57:05 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3kcsZQ3stfz5tlH;
	Wed,  4 Feb 2015 19:57:02 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2A53F19F90F;
	Wed,  4 Feb 2015 19:57:01 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <alpine.DEB.2.00.1502041615110.30476@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263356>

Am 04.02.2015 um 16:19 schrieb Peter Krefting:
> Using "git branch --no-merged" I can get a list of branches that I have
> that I haven't merged into my current branch.

Assuming v2.0.0 is a tag, using "git branch --no-merged v2.0.0" you can
see which branches haven't been merged into v2.0.0.

-- Hannes

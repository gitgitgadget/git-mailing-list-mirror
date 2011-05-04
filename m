From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: How to fork a file (git cp ?)
Date: Wed, 04 May 2011 20:16:45 +0200
Message-ID: <4DC1980D.4010009@kdbg.org>
References: <4DC1934D.6070608@aldan.algebra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mikhail T." <mi+thun@aldan.algebra.com>
X-From: git-owner@vger.kernel.org Wed May 04 20:17:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHgdB-0002on-DD
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 20:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab1EDSQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 14:16:55 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:25212 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755258Ab1EDSQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 14:16:51 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id ED1F413006A;
	Wed,  4 May 2011 20:16:46 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A64AB19F389;
	Wed,  4 May 2011 20:16:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4DC1934D.6070608@aldan.algebra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172754>

Am 04.05.2011 19:56, schrieb Mikhail T.:
> I need to add a new thing to our project. The thing will be similar to
> what already exists. I'd like to "derive" the new files from the
> existing ones -- without altering them and by preserving the
> change-history.






















> 
> This is not a separate branch -- the "forked" files will co-exist. I'd
> call this git-cp (analogous to git-mv), but it does not exist...
> 
> Any ideas? Thanks!
> 
>    -mi
> 

From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 0/4] tests: use "git xyzzy" form
Date: Wed, 03 Sep 2008 12:55:27 +0200
Message-ID: <48BE6D1F.1060603@op5.se>
References: <20080903175925.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 12:56:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaq2S-0006ex-0N
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 12:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbYICKze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 06:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754973AbYICKze
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 06:55:34 -0400
Received: from mail.op5.se ([193.201.96.20]:51383 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922AbYICKzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 06:55:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8639624B004F;
	Wed,  3 Sep 2008 13:01:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YNfmWDbGGa4S; Wed,  3 Sep 2008 13:00:58 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.181])
	by mail.op5.se (Postfix) with ESMTP id A84B324B004B;
	Wed,  3 Sep 2008 13:00:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080903175925.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94783>

Nanako Shiraishi wrote:
> These four patches update test scripts to use "git xyzzy" format so that
> they can serve as sample usage for git commands better.
> 
>  [PATCH 1/4] tests: use "git xyzzy" form (t0000 - t3599)
>  [PATCH 2/4] tests: use "git xyzzy" form (t3600 - t6999)
>  [PATCH 3/4] tests: use "git xyzzy" form (t7000 - t7199)
>  [PATCH 4/4] tests: use "git xyzzy" form (t7200 - t9001)
> 


Are you absolutely 100% certain that what you're testing is still
the files in the build directory after applying these patches?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 0/8] Rebase topology test
Date: Fri, 07 Jun 2013 21:37:05 +0200
Message-ID: <51B23661.5050002@kdbg.org>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com> <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:37:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2TM-0005uI-3W
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab3FGThK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:37:10 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:18832 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754831Ab3FGThJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:37:09 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C642613004A;
	Fri,  7 Jun 2013 21:37:05 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1A60219F5E6;
	Fri,  7 Jun 2013 21:37:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226686>

Am 07.06.2013 08:11, schrieb Martin von Zweigbergk:
> Changes since v5:
> 
>  * Improved test_linear_range
>  * Changed TODOs to be about consistency, not --topo-order
> 
> Martin von Zweigbergk (7):
>   add simple tests of consistency across rebase types
>   add tests for rebasing with patch-equivalence present
>   add tests for rebasing of empty commits
>   add tests for rebasing root
>   add tests for rebasing merged history
>   t3406: modernize style
>   tests: move test for rebase messages from t3400 to t3406

I looked at the interdiff to v3 and have nothing to add.

Well done! Thanks.

-- Hannes

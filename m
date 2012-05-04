From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 5/6] http: Avoid limit of retrying request only twice
Date: Fri, 04 May 2012 12:20:34 +0200
Message-ID: <4FA3AD72.1010407@seap.minhap.es>
References: <4FA2B4FC.3030309@seap.minhap.es> <20120504072427.GE21895@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 04 11:24:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQEkW-0005gQ-FB
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 11:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab2EDJYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 05:24:23 -0400
Received: from luthien2.map.es ([82.150.0.102]:41864 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab2EDJYW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 05:24:22 -0400
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id 4A03CB75AB;
	Fri,  4 May 2012 11:23:22 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 546E6D4C66;
	Fri,  4 May 2012 11:23:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120424 Thunderbird/12.0
In-Reply-To: <20120504072427.GE21895@sigill.intra.peff.net>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 4A03CB75AB.E4E8C
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1336728202.69269@HPhXugcyZ4tpwbl1zu3hQg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197009>

On 05/04/2012 09:24 AM, Jeff King wrote:
> On Thu, May 03, 2012 at 06:40:28PM +0200, Nelson Benitez Leon wrote:
> 
>> [snip]
>>
>> Now we retry as long as we keep receiving HTTP_REAUTH, so the previous
>> sequence correctly completes.
>>
>> Patch by Jeff King <peff@peff.net>
> 
> We usually spell that as:
> 
>   From: Jeff King <peff@peff.net>
> 
> at the beginning of the email body (which lets am set the author
> appropriately).

Are you saying the first line of the email body? isn't that for the
commit message first-line? I suppose you're not refering to the 'from
field' of the email as I would need alter identities in my email client
and found that cumbersome. Sorry for me not getting it and asking for
clarification.

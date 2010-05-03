From: wfp5p@viridian.itc.virginia.edu (Bill Pemberton)
Subject: Re: [PATCH] blame: add a range option to -L
Date: Mon, 03 May 2010 09:22:57 -0400 (EDT)
Message-ID: <20100503132257.CE99641205@viridian.itc.virginia.edu>
References: <7vvdb6uy2w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com (Junio C Hamano)
X-From: git-owner@vger.kernel.org Mon May 03 15:23:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8vc5-0006kT-DB
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 15:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759166Ab0ECNW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 09:22:59 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:47969 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759034Ab0ECNW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 09:22:58 -0400
Received: by viridian.itc.virginia.edu (Postfix, from userid 1249)
	id CE99641205; Mon,  3 May 2010 09:22:57 -0400 (EDT)
In-Reply-To: <7vvdb6uy2w.fsf@alter.siamese.dyndns.org>
X-Mailer: ELM [version 2.5.8.52.g5a79]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146236>

Junio C Hamano writes:
> 
 
> I am not interested in this patch very much myself, and after thinking
> about it, I think my dislike largely comes from this syntax, and not from
> the feature itself.  Any non-punctuation letter there looks like a sore
> thumb.  Either "-L 20??15" or even "-L 20+/-5" would have looked a _lo=
> t_
> saner.
> 

Ok, I've never been thrilled with the r either, but I couldn't come up
with anything better and I had assumed that you'd want to stick with
the <start>,<end> syntax.

-- 
Bill

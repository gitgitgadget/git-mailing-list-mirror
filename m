From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: Re: [RFC/PATCH 4/5] Documentation: reset: describe new "--keep"
	option
Date: Sat, 2 Jan 2010 12:14:23 -0500
Message-ID: <20100102171422.GA19522@panix.com>
References: <20100102053303.30066.26391.chriscool@tuxfamily.org> <20100102053934.30066.76552.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jan 02 18:14:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR7Yd-0007iX-SK
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 18:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806Ab0ABROY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 12:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777Ab0ABROY
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 12:14:24 -0500
Received: from mail1.panix.com ([166.84.1.72]:62011 "EHLO mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab0ABROY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 12:14:24 -0500
Received: from panix5.panix.com (panix5.panix.com [166.84.1.5])
	by mail1.panix.com (Postfix) with ESMTP id 563631F08E;
	Sat,  2 Jan 2010 12:14:23 -0500 (EST)
Received: by panix5.panix.com (Postfix, from userid 14662)
	id 3A1AE24235; Sat,  2 Jan 2010 12:14:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20100102053934.30066.76552.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136034>

On Sat, Jan 02, 2010 at 06:39:32AM +0100, Christian Couder wrote:
> +++ b/Documentation/git-reset.txt
...
> +--keep::
> +	Resets the index to match the tree recorded by the named commit,
> +	but keep changes in the working tree. Aborts if the reset would
> +	change files that are already changes in the working tree.

Grammar suggestion for the last line there.  Change "already changes" to 
"already changed".  Or better yet, use a different word, such as "already 
modified", since "change" based words have been used so many times 
already in the sentence.

Thanks,

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
 4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335 f: 718-854-0409

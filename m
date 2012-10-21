From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 0/2] Re: gitk: can't reload commits with new key
 binding
Date: Mon, 22 Oct 2012 09:19:01 +1100
Message-ID: <20121021221901.GA7407@bloggs.ozlabs.ibm.com>
References: <7vwqzacdb7.fsf@alter.siamese.dyndns.org>
 <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, szeder@ira.uka.de
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 00:19:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ3rW-0002cU-6Q
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 00:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647Ab2JUWTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 18:19:01 -0400
Received: from ozlabs.org ([203.10.76.45]:35852 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932626Ab2JUWTB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 18:19:01 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1FCA32C008D; Mon, 22 Oct 2012 09:19:00 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208160>

On Tue, Oct 02, 2012 at 11:04:43AM -0400, Andrew Wong wrote:
> Refactored the code for binding modified function keys as Junio suggested.
> 
> Andrew Wong (2):
>   gitk: Refactor code for binding modified function keys
>   gitk: Use bindshiftfunctionkey to bind Shift-F5
> 
>  gitk | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Thanks, applied both patches.

Paul.

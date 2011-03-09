From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: ensure quoted tag names in event bindings
Date: Wed, 9 Mar 2011 21:05:47 +1100
Message-ID: <20110309100547.GA4014@brick.ozlabs.ibm.com>
References: <20110227224024.3751.96676.reportbug@pcfelipe.sateler>
 <20110301013841.GC5597@elie>
 <87tyfmqu1x.fsf_-_@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Felipe Sateler <fsateler@debian.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 11:31:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxGgL-00061m-0F
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 11:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185Ab1CIKbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 05:31:47 -0500
Received: from ozlabs.org ([203.10.76.45]:57000 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757138Ab1CIKbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 05:31:47 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0E0FCB70D9; Wed,  9 Mar 2011 21:31:46 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <87tyfmqu1x.fsf_-_@fox.patthoyts.tk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168727>

On Tue, Mar 01, 2011 at 11:50:50PM +0000, Pat Thoyts wrote:

> Tag names that contain a % character require quoting when used in event
> bindings or the name may be mis-recognised for percent substitution in
> the event script.
> 
> Reported-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Thanks, applied.

Paul.

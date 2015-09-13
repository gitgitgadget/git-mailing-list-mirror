From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH, RESEND] gitk: adjust the menu line numbers to compensate
 for the new entry
Date: Sun, 13 Sep 2015 22:24:34 +1000
Message-ID: <20150913122434.GA12913@fergus.ozlabs.ibm.com>
References: <1441667797-5407-1-git-send-email-dev+git@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Beat Bolli <dev+git@drbeat.li>
X-From: git-owner@vger.kernel.org Sun Sep 13 14:25:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb6L8-0001My-CK
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 14:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbbIMMY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 08:24:57 -0400
Received: from ozlabs.org ([103.22.144.67]:46954 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbbIMMY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 08:24:56 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0C8AD140285; Sun, 13 Sep 2015 22:24:54 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1441667797-5407-1-git-send-email-dev+git@drbeat.li>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277779>

On Tue, Sep 08, 2015 at 01:16:37AM +0200, Beat Bolli wrote:
> Commit d835dbb9 ("gitk: Add a "Copy commit summary" command",
> 2015-08-13) in the upstream gitk repo added a new context menu entry.
> Therefore, the line numbers of the entries below the new one need to be
> adjusted when their text or state is changed.
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> Cc: Paul Mackerras <paulus@samba.org>

Thanks, applied.

Paul.

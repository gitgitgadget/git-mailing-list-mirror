From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Use translated version of "Command line" in
 getcommitlines.
Date: Sun, 17 May 2015 14:29:35 +1000
Message-ID: <20150517042935.GF21039@iris.ozlabs.ibm.com>
References: <1428422017-20645-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sun May 17 08:36:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtsB8-0004ic-CF
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 08:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbbEQGfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 02:35:54 -0400
Received: from ozlabs.org ([103.22.144.67]:34972 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbbEQGfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 02:35:48 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id CFD15140B0D; Sun, 17 May 2015 16:35:46 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1428422017-20645-1-git-send-email-marcnarc@xiplink.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269211>

On Tue, Apr 07, 2015 at 11:53:37AM -0400, Marc Branchaud wrote:
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
> 
> I noticed this today.  I think this change is needed for getcommitlines to
> work properly with translated gitk's.

Thanks, applied.

Paul.

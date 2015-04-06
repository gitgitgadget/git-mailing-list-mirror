From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Remove mc parameter from proc show_error
Date: Mon, 6 Apr 2015 13:33:52 +1000
Message-ID: <20150406033352.GB26765@iris.ozlabs.ibm.com>
References: <1428008735-10943-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bernt@norang.ca, git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 06:39:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yeyod-0003Yt-QO
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 06:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbbDFEi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 00:38:57 -0400
Received: from ozlabs.org ([103.22.144.67]:57098 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbbDFEiy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 00:38:54 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id DF3CD140216; Mon,  6 Apr 2015 14:38:52 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1428008735-10943-1-git-send-email-alexhenrie24@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266831>

On Thu, Apr 02, 2015 at 03:05:35PM -0600, Alex Henrie wrote:
> This partially reverts commit 8d849957d81fc0480a52570d66cc3c2a688ecb1b.

... and brings back the bug that 8d849957d81f solves, as far as I can
see.  If that's not the case then you need to explain that in the
patch description.

Paul.

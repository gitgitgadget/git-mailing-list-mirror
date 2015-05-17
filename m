From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCHv2] gitk: Show the current view's name in the window title.
Date: Sun, 17 May 2015 11:39:24 +1000
Message-ID: <20150517013924.GC21039@iris.ozlabs.ibm.com>
References: <20150406043711.GC31463@iris.ozlabs.ibm.com>
 <1428421911-20393-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sun May 17 06:22:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ytq5j-0000C9-62
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 06:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbbEQEWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 00:22:08 -0400
Received: from ozlabs.org ([103.22.144.67]:55280 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbbEQEWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 00:22:03 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E4815140B0D; Sun, 17 May 2015 14:21:59 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1428421911-20393-1-git-send-email-marcnarc@xiplink.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269207>

On Tue, Apr 07, 2015 at 11:51:51AM -0400, Marc Branchaud wrote:
> If the current view is the "Command line" view, show the command line
> arguments instead of the view name.
> 
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>

Thanks, applied.

Paul.

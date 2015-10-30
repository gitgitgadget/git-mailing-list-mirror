From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH] gitk: add missing accelerators
Date: Fri, 30 Oct 2015 20:56:54 +1100
Message-ID: <20151030095654.GA25993@fergus.ozlabs.ibm.com>
References: <1443642611-11827-1-git-send-email-dev+git@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Beat Bolli <dev+git@drbeat.li>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:10:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zs6e3-0004AV-NY
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 11:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030732AbbJ3KKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 06:10:47 -0400
Received: from ozlabs.org ([103.22.144.67]:42924 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030725AbbJ3KKq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 06:10:46 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id BCA77140DB1; Fri, 30 Oct 2015 21:10:44 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1443642611-11827-1-git-send-email-dev+git@drbeat.li>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280482>

On Wed, Sep 30, 2015 at 09:50:11PM +0200, Beat Bolli wrote:
> In d99b4b0de27a ("gitk: Accelerators for the main menu", 2015-09-09),
> accelerators were added to allow efficient keyboard navigation. One
> instance of the strings "Edit view..." and "Delete view" were left
> without the ampersand.
> 
> Add the missing ampersand characters to unbreak our international
> users.
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> Cc: Paul Mackerras <paulus@samba.org>

Thanks, applied.

Paul.

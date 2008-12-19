From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH][RESEND] guilt: add option guilt.diffstat
Date: Fri, 19 Dec 2008 08:08:24 +0800
Message-ID: <20081219000824.GA5562@localhost>
References: <20081213021422.GA28249@localhost> <20081213044357.GD15407@josefsipek.net> <20081213131700.GA8649@localhost> <20081218112643.GA15416@localhost> <20081218143918.GM15407@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Boyd Stephen Smith Jr." <bss03@volumehost.net>
To: Josef Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 01:10:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDSwW-0004vH-6n
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 01:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbYLSAIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 19:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbYLSAIg
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 19:08:36 -0500
Received: from mga14.intel.com ([143.182.124.37]:22820 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbYLSAIf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 19:08:35 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 18 Dec 2008 16:08:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.36,245,1228118400"; 
   d="scan'208";a="91878283"
Received: from unknown (HELO localhost) ([10.254.153.195])
  by azsmga001.ch.intel.com with ESMTP; 18 Dec 2008 16:08:29 -0800
Received: from wfg by localhost with local (Exim 4.69)
	(envelope-from <fengguang.wu@intel.com>)
	id 1LDSum-0001Uy-5Y; Fri, 19 Dec 2008 08:08:24 +0800
Content-Disposition: inline
In-Reply-To: <20081218143918.GM15407@josefsipek.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103513>

On Thu, Dec 18, 2008 at 04:39:18PM +0200, Josef Jeff Sipek wrote:
> On Thu, Dec 18, 2008 at 07:26:43PM +0800, Wu Fengguang wrote:
> > Introduce option guilt.diffstat so that we don't have to type
> > "guilt refresh --diffstat" in its full form every time.
> 
> I haven't forgotten about this. I'll try to apply it tonight/tomorrow
> morning.

Thank you. This refreshed patch resolved merge conflict against the
latest git tree :)

Thanks,
Fengguang

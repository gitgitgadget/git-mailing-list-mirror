From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 0/4] gitk crash fix and locale updates
Date: Fri, 30 Oct 2015 21:04:35 +1100
Message-ID: <20151030100435.GE25993@fergus.ozlabs.ibm.com>
References: <1445344384-12762-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zs6e9-0004F4-LD
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 11:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030736AbbJ3KKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 06:10:52 -0400
Received: from ozlabs.org ([103.22.144.67]:32779 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030726AbbJ3KKq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 06:10:46 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E72C01412E0; Fri, 30 Oct 2015 21:10:44 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1445344384-12762-1-git-send-email-tiwai@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280484>

On Tue, Oct 20, 2015 at 02:33:00PM +0200, Takashi Iwai wrote:
> Hi,
> 
> the recent change in gitk to support the menu accelerator broke the
> invocation with --all option in non-English locales.  Also, the whole
> menu translations are gone by this, too.  This patchset tries to
> address these issues.

Thanks for the series.  The patch 1/4 is the same as a patch from Beat
Bolli that I just applied, so I left out your 1/4 and applied 2, 3,
and 4.

Paul.

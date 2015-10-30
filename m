From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [gmane.comp.version-control.git] [PATCH 0/4] gitk crash fix and
 locale updates
Date: Fri, 30 Oct 2015 21:10:38 +1100
Message-ID: <20151030101038.GG25993@fergus.ozlabs.ibm.com>
References: <xmqqziz5dv3f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Takashi Iwai <tiwai@suse.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:11:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zs6eA-0004F4-DZ
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 11:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030734AbbJ3KKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 06:10:51 -0400
Received: from ozlabs.org ([103.22.144.67]:35331 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030727AbbJ3KKq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 06:10:46 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 014A41412E9; Fri, 30 Oct 2015 21:10:44 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <xmqqziz5dv3f.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280485>

On Mon, Oct 26, 2015 at 05:16:20PM -0700, Junio C Hamano wrote:
> Ping.  What do you think of these?  It appears that quite a many
> people are getting bitten by the issues this series addresses.

Yes, sorry about that.  I have applied a patch from Beat Bolli fixing
the basic issue, since his patch was the same as Takashi's first patch
and was posted earlier.  I have also applied 2-4 of Takashi's series
plus some other translation updates.  I have pushed all that out to
git://ozlabs.org/~paulus/gitk.git.

Please pull whenever is convenient for you.

Regards,
Paul.

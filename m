From: "Paulo J. Matos" <paulo@matos-sorge.com>
Subject: Re: Special branch for remote
Date: Wed, 27 Jul 2011 15:36:28 +0100
Message-ID: <j0p7pc$q51$2@dough.gmane.org>
References: <j0ohjr$fcd$1@dough.gmane.org> <4E302229.4030402@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 16:55:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm5Vy-0002zy-HJ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 16:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab1G0OzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 10:55:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:60624 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307Ab1G0OzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 10:55:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qm5Vq-0002xq-BN
	for git@vger.kernel.org; Wed, 27 Jul 2011 16:55:06 +0200
Received: from 193.128.72.68 ([193.128.72.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 16:55:06 +0200
Received: from paulo by 193.128.72.68 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 16:55:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 193.128.72.68
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
In-Reply-To: <4E302229.4030402@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177971>

On 27/07/11 15:35, Phil Hord wrote:
>
> You can also manage this with submodules [2] or subtree-merge [3].
>
> I prefer submodules since it keeps the huge stuff (docs and bins) away
> from my source code and makes my source code repo much more responsive.
>

Thanks Phil, I will be looking at this solution then.

Cheers,
-- 
PMatos

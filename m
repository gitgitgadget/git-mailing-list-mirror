From: Stephen Kelly <steveire@gmail.com>
Subject: Re: gitk with submodules does not show new commits on other branches
Date: Sun, 22 Jun 2014 17:45:54 +0200
Message-ID: <lo6tnh$p3c$1@ger.gmane.org>
References: <lo6o2h$vva$1@ger.gmane.org> <53A6F978.4010005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 17:46:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyjyB-0006O1-Qc
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jun 2014 17:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbaFVPqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2014 11:46:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:38113 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbaFVPqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2014 11:46:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Wyjy5-0006KX-Du
	for git@vger.kernel.org; Sun, 22 Jun 2014 17:46:09 +0200
Received: from g226036065.adsl.alicedsl.de ([92.226.36.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jun 2014 17:46:09 +0200
Received: from steveire by g226036065.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jun 2014 17:46:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: g226036065.adsl.alicedsl.de
User-Agent: KNode/4.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252311>

Jens Lehmann wrote:

> Am 22.06.2014 16:09, schrieb Stephen Kelly:

>> Please show the same information (ie all commits newly reachable
>> from develop) in the submodule gitk output.
> 
> This should not happen by default. If you have a feature branch based
> workflow, the merge is just what you want to see.

In my case, it is not what I want to see :).

> But I agree that this is suboptimal for your workflow. What about adding
> a "Visualize These Changes In The Submodule" menu entry for the context
> menu of a change in gitk just like the one git gui already has?

Can you tell me how to find and try that out in git gui?

Thanks,

Steve.

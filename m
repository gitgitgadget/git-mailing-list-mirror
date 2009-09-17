From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git workflow for fully distributed mini-teams
Date: Thu, 17 Sep 2009 09:28:20 +0200
Message-ID: <4AB1E514.9030501@viscovery.net>
References: <f46c52560909160035o6b09800eh5219d49e7569cf23@mail.gmail.com>	 <20090916164356.GB24893@vidovic> <f46c52560909170003l61a2e1a3kf62c94ffd7ed9710@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 09:28:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoBPm-0003LM-SW
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 09:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758678AbZIQH2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 03:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758598AbZIQH2S
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 03:28:18 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:47473 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758559AbZIQH2R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 03:28:17 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MoBPg-0002ly-Lv; Thu, 17 Sep 2009 09:28:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 75A40BC81; Thu, 17 Sep 2009 09:28:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <f46c52560909170003l61a2e1a3kf62c94ffd7ed9710@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128725>

Rustom Mody schrieb:
> I am really concerned about things like:
> 
> A commited something on the B branch, received a patch from B. That
> patch did not apply (or worse it applied -- on top of A's!)
> So ideally there should be an option that says (when A is on B branch
> and tries to commit) "Sorry buddy -- No commits here!"

I think the most important thing would be that you send bundles around,
not patches, so that you all can work with and talk about unique object names.

-- Hannes

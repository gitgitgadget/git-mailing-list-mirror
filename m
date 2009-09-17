From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git workflow for fully distributed mini-teams
Date: Thu, 17 Sep 2009 16:47:34 +0200
Message-ID: <4AB24C06.5030207@viscovery.net>
References: <f46c52560909160035o6b09800eh5219d49e7569cf23@mail.gmail.com>	 <20090916164356.GB24893@vidovic>	 <f46c52560909170003l61a2e1a3kf62c94ffd7ed9710@mail.gmail.com>	 <4AB1E514.9030501@viscovery.net>	 <f46c52560909170538q4d316d00jcccad8ec9f563574@mail.gmail.com> <f46c52560909170652t54f68c31hfbb8ae6472190ac1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 16:47:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoIGt-0004Yv-8m
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 16:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbZIQOre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 10:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbZIQOrd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 10:47:33 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:29506 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbZIQOrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 10:47:33 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MoIGk-0002t8-Td; Thu, 17 Sep 2009 16:47:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A0633BC81; Thu, 17 Sep 2009 16:47:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <f46c52560909170652t54f68c31hfbb8ae6472190ac1@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128760>

[On this list, we reply to all, so that the Cc list remains]

Rustom Mody schrieb:
> I started looking at git bundle and find things like master\~10.
> Whats the backslash doing?

It's intended as markup for the pipeline that generates the documentation
from git-bundle.txt. Either the markup is incorrect, or there is a bug in
the pipeline, because I only see it in the generated HTML. Ignore it.

-- Hannes

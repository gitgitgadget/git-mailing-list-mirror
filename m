From: "Paulo J. Matos" <pocmatos@gmail.com>
Subject: Special branch for remote
Date: Wed, 27 Jul 2011 09:18:03 +0100
Message-ID: <j0ohjr$fcd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 10:18:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlzJw-0000iO-5l
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 10:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab1G0IST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 04:18:19 -0400
Received: from lo.gmane.org ([80.91.229.12]:37224 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753351Ab1G0ISS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 04:18:18 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QlzJp-0000ev-92
	for git@vger.kernel.org; Wed, 27 Jul 2011 10:18:17 +0200
Received: from 193.128.72.68 ([193.128.72.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 10:18:17 +0200
Received: from pocmatos by 193.128.72.68 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 10:18:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 193.128.72.68
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177945>

Hi all,

I have a huge repository for a software I am developing. In it I have 
source code, docs, experiments, tests, etc. However, I want to push only 
the src/ to the github remote, nothing else. What's the best way to 
achieve this. Do I need to simply create a new branch and then push the 
new branch to github or there's anything else involved that I need to know?

Cheers,

-- 
PMatos

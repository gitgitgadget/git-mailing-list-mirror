From: "norbert.nemec" <norbert.nemec@native-instruments.de>
Subject: Status after 'git clone --no-checkout' ?
Date: Wed, 30 Nov 2011 14:02:22 +0100
Message-ID: <jb59h0$p3e$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 14:25:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVkA2-0004F6-Ad
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 14:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035Ab1K3NZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 08:25:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:40990 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668Ab1K3NZL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 08:25:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RVk9r-00047a-I8
	for git@vger.kernel.org; Wed, 30 Nov 2011 14:25:07 +0100
Received: from 93.92.134.38 ([93.92.134.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 14:25:07 +0100
Received: from norbert.nemec by 93.92.134.38 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 14:25:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 93.92.134.38
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186124>

Hi there,

what exactly is the status after 'git clone --no-checkout'? Is there any 
straightforward way how one could end up in this state starting from a 
regularly checked out repository?

A somewhat related question:

'git checkout' without any further options serves to move from the 
aforementioned special state to a regular checked out state. Otherwise 
it never seems to do anything. Are there any other situations where 'git 
checkout' on its own would have any effect?

Thanks for any insight on this!

Norbert Nemec

From: "norbert.nemec" <norbert.nemec@native-instruments.de>
Subject: git blame --follow
Date: Thu, 06 Sep 2012 09:02:17 +0200
Message-ID: <k29hpo$3av$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 09:02:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9W6q-0004m8-GS
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 09:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab2IFHCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 03:02:33 -0400
Received: from plane.gmane.org ([80.91.229.3]:51947 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965Ab2IFHCc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 03:02:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1T9W6f-0004ay-Cy
	for git@vger.kernel.org; Thu, 06 Sep 2012 09:02:29 +0200
Received: from 46.231.181.199 ([46.231.181.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 09:02:29 +0200
Received: from norbert.nemec by 46.231.181.199 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 09:02:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 46.231.181.199
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:15.0) Gecko/20120824 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204867>

Hi there,

'git blame --follow' seems to be undocumented. The exact behavior is not 
clear to me. Perhaps an alias for some combination of '-C' and '-M'? It 
seems not be be fully consistent with 'git log --follow'.

Could someone clarify? Did I miss something?

Greetings,
Norbert

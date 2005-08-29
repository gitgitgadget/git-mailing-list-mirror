From: Ben Greear <greearb@candelatech.com>
Subject: git commit question
Date: Mon, 29 Aug 2005 12:58:08 -0700
Organization: Candela Technologies
Message-ID: <431368D0.40604@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 29 21:58:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9plq-0001gu-Ad
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 21:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbVH2T6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 15:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbVH2T6K
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 15:58:10 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:17314 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S1751489AbVH2T6J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 15:58:09 -0400
Received: from [71.112.205.201] (pool-71-112-205-201.sttlwa.dsl-w.verizon.net [71.112.205.201])
	(authenticated bits=0)
	by www.lanforge.com (8.12.8/8.12.8) with ESMTP id j7TK2Mo6029165
	for <git@vger.kernel.org>; Mon, 29 Aug 2005 13:02:23 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7923>

I started a fresh kernel git repository since I buggered
my old one...

I branched, applied patch, and ran git-update-cache.

Now, when I run git commit, I see a long list of files on which
evidently I need to run git-update-cache.

Is there a way to tell it to add all modified files (that git commit mentions)
to the cache for commit, or do I have to not be so lazy and
paste them all on the cmd line?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

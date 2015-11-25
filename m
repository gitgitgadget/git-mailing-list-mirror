From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Signed tags and git repository
Date: Wed, 25 Nov 2015 16:19:07 -0700
Message-ID: <3816223.3lD8Al3iuQ@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 01:00:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1jz8-0007AE-66
	for gcvg-git-2@plane.gmane.org; Thu, 26 Nov 2015 01:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbbKZAAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 19:00:25 -0500
Received: from fed1rmfepi105.cox.net ([68.230.241.136]:57924 "EHLO
	fed1rmfepi105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbbKZAAX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 19:00:23 -0500
X-Greylist: delayed 2484 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2015 19:00:23 EST
Received: from fed1rmimpo306 ([68.230.241.174]) by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151125231858.MVJB28496.fed1rmfepo203.cox.net@fed1rmimpo306>
          for <git@vger.kernel.org>; Wed, 25 Nov 2015 18:18:58 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo306 with cox
	id lzJy1r0062tqoqC01zJyR8; Wed, 25 Nov 2015 18:18:58 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020201.565641E2.00EC,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=LKq4tuq9 c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=qtqOOiqGOCEA:10
 a=O59IILMnOeSoJVEKy6oA:9 a=CjuIK1q_8ugA:10 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id D52A313F66E
	for <git@vger.kernel.org>; Wed, 25 Nov 2015 16:19:07 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.2.0-19-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281750>

I've been following commits to the linux and git repostitories for some time.   I used signed tags for
projects that I'm working on.   

I know that the linux and git repositories have signed tags, but I'm not able to verify 
them because my key isn't signed by anyone that leads back to one of the git or linux 
maintainers. Of course I live in a technical desert since there seems to be no one that I
can find who lives in Phoenix, AZ that has a relationship to one of those two 
git repositories.

What have others done when they want their keys signed so they can be part of the 
web of trust? Does either of those two projects have a formal way of establishing these
relationships?

sps

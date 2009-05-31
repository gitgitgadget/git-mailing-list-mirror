From: Johannes Schneider <mailings@cedarsoft.com>
Subject: [OT] Using object store for other (java) applications
Date: Sun, 31 May 2009 23:16:10 +0200
Message-ID: <4A22F39A.9010900@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 31 23:43:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAso7-00019q-CH
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 23:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbZEaVmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 17:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZEaVmj
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 17:42:39 -0400
Received: from hosting.cedarsoft.com ([78.47.151.148]:54046 "EHLO
	abigail.xore.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbZEaVmj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 17:42:39 -0400
X-Greylist: delayed 1587 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 May 2009 17:42:38 EDT
Received: by abigail.xore.de (Postfix, from userid 2001)
	id CB8111C74221; Sun, 31 May 2009 23:16:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	hosting.cedarsoft.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.1.7-deb3
Received: from [192.168.0.117] (HSI-KBW-085-216-046-020.hsi.kabelbw.de [85.216.46.20])
	by abigail.xore.de (Postfix) with ESMTP id 1928B1C74052
	for <git@vger.kernel.org>; Sun, 31 May 2009 23:16:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1b3pre) Gecko/20090227 Shredder/3.0b2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120433>

Hi,

what do you think: Is it possible to use the object store (hash based 
and optimized storage) within another Java application?
Maybe the JGIT implementation contains anything that could be used?
I need to store many different images within a repository, so I would 
like to try to reuse the Git storage.

Could anyone give me a hint whether it is possible (and a good idea) and 
which classes I should take a look at first.


Thanks,

Johannes

From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: git show and gitweb gives different result for kernel
Date: Fri, 06 Oct 2006 23:26:35 +0530
Message-ID: <eg65cl$cvs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 06 19:57:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVtwh-00052j-9t
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 19:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWJFR5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 13:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWJFR5M
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 13:57:12 -0400
Received: from main.gmane.org ([80.91.229.2]:52354 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751602AbWJFR5L (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 13:57:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GVtwR-0004yT-4M
	for git@vger.kernel.org; Fri, 06 Oct 2006 19:56:59 +0200
Received: from 59.92.146.140 ([59.92.146.140])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 19:56:59 +0200
Received: from aneesh.kumar by 59.92.146.140 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 19:56:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.146.140
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28423>

Hi All,


http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=363e065c02b1273364d5356711a83e7f548fc0c8

git show 363e065c02b1273364d5356711a83e7f548fc0c8

git show  gives the correct values.

-aneesh

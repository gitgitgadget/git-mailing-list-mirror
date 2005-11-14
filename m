From: Carl Baldwin <cnb@fc.hp.com>
Subject: [Question] info/grafts file.
Date: Mon, 14 Nov 2005 11:20:19 -0700
Organization: Hewlett Packard
Message-ID: <20051114182019.GA19105@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 14 19:23:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbiwW-0002U0-R2
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 19:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVKNSUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 13:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKNSUW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 13:20:22 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:42123 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751221AbVKNSUU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 13:20:20 -0500
Received: from smtp2.fc.hp.com (smtp2b.fc.hp.com [15.15.136.253])
	by atlrel6.hp.com (Postfix) with ESMTP id 79AE2112F1
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 13:20:19 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP id 40CAA41E220
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 18:20:19 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 29B50B614; Mon, 14 Nov 2005 11:20:19 -0700 (MST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11830>

Greetings,

A simple question to clarify something in the repository.

What level of support is to be expected for the .git/info/grafts file?
I added a grafts file to a repository imported from SVN.  However, when
I cloned the repository using git clone -l -s I did not end up with a
grafts file in the cloned repository.

Cheers,
Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

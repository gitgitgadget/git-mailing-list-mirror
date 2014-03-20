From: Tanay Abhra <tanayabh@gmail.com>
Subject: [GSoC]  Inquiry about writing config file to disk
Date: Thu, 20 Mar 2014 17:25:22 +0000 (UTC)
Message-ID: <loom.20140320T181941-0@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 18:26:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQgjI-0006tB-Nr
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 18:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759324AbaCTR0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 13:26:01 -0400
Received: from plane.gmane.org ([80.91.229.3]:47542 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759309AbaCTR0A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 13:26:00 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WQgj7-0006Zw-Ii
	for git@vger.kernel.org; Thu, 20 Mar 2014 18:25:57 +0100
Received: from 117.254.217.74 ([117.254.217.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 18:25:57 +0100
Received: from tanayabh by 117.254.217.74 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 18:25:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 117.254.217.74 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244562>

Hi,

I have gone through commit.c, builtin/commit.c and api-config.txt but one
thing I cannot find is which functions handle writing config file to disk
after adding a new variable,value pair(for example git config my.option
true) . It is also marked TODO on the api-config.txt file. Can somebody help
me , I just want the starting function and will trace the function calls
after that.

Regards,
Tanay Abhra.

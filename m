From: Cap Petschulat <cap@naviasystems.com>
Subject: Re: filter-branch --subdirectory-filter prematurely truncating history?
Date: Wed, 11 Mar 2009 00:37:16 +0000 (UTC)
Message-ID: <loom.20090311T003412-973@post.gmane.org>
References: <loom.20090309T230424-857@post.gmane.org> <49B60FF9.9020805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 01:39:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhCTP-0005DM-I2
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 01:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbZCKAhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 20:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbZCKAhd
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 20:37:33 -0400
Received: from main.gmane.org ([80.91.229.2]:52395 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbZCKAhc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 20:37:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LhCRu-00079d-0z
	for git@vger.kernel.org; Wed, 11 Mar 2009 00:37:30 +0000
Received: from 69-92-193-253.cpe.cableone.net ([69.92.193.253])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 00:37:30 +0000
Received: from cap by 69-92-193-253.cpe.cableone.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 00:37:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.92.193.253 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081216 Ubuntu/8.04 (hardy) Firefox/2.0.0.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112862>

Johannes Sixt <j.sixt <at> viscovery.net> writes:
> A bug in this area was fixed in git v1.6.0-rc3. Which version are you using?

I was using 1.5.4.3 from Ubuntu Hardy, but I just rebuilt git from the most
recent sources and now filter-branch does what I want. Thanks for the suggestion!

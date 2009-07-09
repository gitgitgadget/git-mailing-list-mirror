From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v3] add --summary option to git-push and git-fetch
Date: Thu, 9 Jul 2009 18:03:22 +0000 (UTC)
Message-ID: <h35bda$kgv$1@ger.gmane.org>
References: <20090703044801.GA2072@cthulhu>
 <7viqiat965.fsf@alter.siamese.dyndns.org> <20090707015948.GA525@cthulhu>
Reply-To: Larry D'Anna <larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 20:10:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOy4a-00042J-3t
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 20:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbZGISKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 14:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbZGISKI
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 14:10:08 -0400
Received: from main.gmane.org ([80.91.229.2]:36718 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753599AbZGISKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 14:10:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MOy4J-0003pz-Ao
	for git@vger.kernel.org; Thu, 09 Jul 2009 18:10:03 +0000
Received: from cthulhu.elder-gods.org ([140.239.99.253])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 18:10:03 +0000
Received: from larry by cthulhu.elder-gods.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 18:10:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cthulhu.elder-gods.org
User-Agent: slrn/pre1.0.0-2 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122998>


This patch has a bug in it that causes it to randomly segfault, so don't bother
with it.  I'll send in a fixed version when I figure out the cause.

     --larry

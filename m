From: Kevin Ballard <kevin@sb.org>
Subject: git help broken
Date: Wed, 30 Jul 2008 13:52:26 -0700
Message-ID: <C0DB03B0-8AF5-4B6A-A9DB-16608128EB31@sb.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 22:54:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOIgI-0000Is-PG
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 22:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbYG3Uw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 16:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbYG3Uw5
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 16:52:57 -0400
Received: from mail.rapleaf.com ([208.96.16.213]:49962 "EHLO mail.rapleaf.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbYG3Uw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 16:52:57 -0400
Received: from mail.rapleaf.com (localhost.localdomain [127.0.0.1])
	by mail.rapleaf.com (Postfix) with ESMTP id 8CBEC1250313
	for <git@vger.kernel.org>; Wed, 30 Jul 2008 13:52:56 -0700 (PDT)
Received: from [192.168.1.80] (unknown [192.168.1.80])
	by mail.rapleaf.com (Postfix) with ESMTP id 7D47012500B6
	for <git@vger.kernel.org>; Wed, 30 Jul 2008 13:52:56 -0700 (PDT)
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90852>

`git help diff` no longer finds the git-diff manpage (as of tip of  
next branch). I haven't tested, but I suspect  
940208a771066229bc6a486f6a058e332b71cfe4 is responsible.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com

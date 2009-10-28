From: Tim Mazid <timmazid@hotmail.com>
Subject: Headless tags don't have a follows or precedes?
Date: Wed, 28 Oct 2009 04:36:59 -0700 (PDT)
Message-ID: <26093136.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 12:38:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N36qp-0008LW-QI
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 12:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbZJ1Lgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 07:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbZJ1Lgz
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 07:36:55 -0400
Received: from kuber.nabble.com ([216.139.236.158]:38098 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbZJ1Lgy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 07:36:54 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N36pn-0001lW-Cg
	for git@vger.kernel.org; Wed, 28 Oct 2009 04:36:59 -0700
X-Nabble-From: timmazid@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131446>


Hi all,

I've noticed that if I create a headless tag (one that doesn't have a
branch, right?), when I click on that commit, it doesn't have precedes or
follows information. Is this by design? Is there a work-around I can use
without creating a branch there?

Thanks,
Tim.
-- 
View this message in context: http://www.nabble.com/Headless-tags-don%27t-have-a-follows-or-precedes--tp26093136p26093136.html
Sent from the git mailing list archive at Nabble.com.

From: jateeq <jawad_atiq@hotmail.com>
Subject: Identifying the last push to a reposiotry
Date: Tue, 2 Mar 2010 13:07:08 -0800 (PST)
Message-ID: <27761186.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 02 22:07:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmZJG-0001sY-PM
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 22:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094Ab0CBVHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 16:07:11 -0500
Received: from kuber.nabble.com ([216.139.236.158]:38516 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab0CBVHK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 16:07:10 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1NmZJ6-00017U-Cn
	for git@vger.kernel.org; Tue, 02 Mar 2010 13:07:08 -0800
X-Nabble-From: jawad_atiq@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141413>


Hello,

I am trying to list all the modifications to the clone of a repository since
the clone was last pushed to its original. Is there a way to identify the
commit id of the HEAD(of the clone) when this last push was carried out? 

Thanks,
Jawad
-- 
View this message in context: http://old.nabble.com/Identifying-the-last-push-to-a-reposiotry-tp27761186p27761186.html
Sent from the git mailing list archive at Nabble.com.

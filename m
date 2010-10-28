From: Marat Radchenko <marat@slonopotamus.org>
Subject: Undo git svn reset?
Date: Wed, 27 Oct 2010 23:20:59 -0700 (PDT)
Message-ID: <1288246859633-5681432.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 08:21:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBLrO-0006Pw-1w
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 08:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab0J1GVC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 02:21:02 -0400
Received: from kuber.nabble.com ([216.139.236.158]:36796 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab0J1GVB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 02:21:01 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <marat@slonopotamus.org>)
	id 1PBLr9-0003aP-Kb
	for git@vger.kernel.org; Wed, 27 Oct 2010 23:20:59 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160158>


So, I accidentally did git svn reset -r <very-old-revision>. Fetching things
again will take ~ a week. Is there a quick way to undo reset (all objects
are still in repo)?
-- 
View this message in context: http://git.661346.n2.nabble.com/Undo-git-svn-reset-tp5681432p5681432.html
Sent from the git mailing list archive at Nabble.com.

From: Hans Ginzel <hans@matfyz.cz>
Subject: git tag -u feature request
Date: Wed, 06 May 2015 08:09:52 +0200
Message-ID: <9fa7de80732928631304708be9504271@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 06 08:17:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypsdk-0003Yp-Gn
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 08:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbbEFGQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 02:16:59 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.26.195]:51503 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbbEFGQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 02:16:59 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 May 2015 02:16:58 EDT
Received: from artax.karlin.mff.cuni.cz (localhost [127.0.0.1])
	by artax.karlin.mff.cuni.cz (Postfix) with ESMTP id 295C1468005
	for <git@vger.kernel.org>; Wed,  6 May 2015 08:09:52 +0200 (CEST)
X-Sender: hans@matfyz.cz
User-Agent: RoundCube Webmail/0.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268451>

Hello,

please, would it be possible to add -u option to git tag for updating 
tag
(with message) to a new commit, e.g. after rebase.

See 
http://stackoverflow.com/questions/8044583/how-can-i-move-a-tag-on-a-git-branch-to-a-different-commit

Thank you,
Hans

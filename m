From: Stephen Bash <bash@genarts.com>
Subject: Notes workflow improvements
Date: Wed, 5 Oct 2011 12:35:11 -0400 (EDT)
Message-ID: <24471333.44240.1317832510971.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 05 18:35:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBURJ-00049z-0S
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 18:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935002Ab1JEQfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 12:35:20 -0400
Received: from hq.genarts.com ([173.9.65.1]:13557 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934994Ab1JEQfT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 12:35:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 6F3D715C8001
	for <git@vger.kernel.org>; Wed,  5 Oct 2011 12:35:18 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N9AZmPPOxcid for <git@vger.kernel.org>;
	Wed,  5 Oct 2011 12:35:11 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 984D215C8018
	for <git@vger.kernel.org>; Wed,  5 Oct 2011 12:35:11 -0400 (EDT)
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182859>

Hi all-

At a developer meeting this morning, several of my coworkers expressed interest in using (shared) git notes in our workflow.  I dug back in the mail archive and found a discussion started by Yann [1] and a patch series [2] that would help the notes workflow.

Unfortunately I'm not finding any further reference to the patch series in the mail archive or in Junio's alt-git repo.  Does anyone know the status of this patch series?

[1] http://article.gmane.org/gmane.comp.version-control.git/175688
[2] http://article.gmane.org/gmane.comp.version-control.git/175983

Thanks!
Stephen

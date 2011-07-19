From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Restricted git push ?
Date: Tue, 19 Jul 2011 15:06:37 +0530
Message-ID: <20110719150637.596b9791@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 11:36:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj6jF-0006Gz-7U
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 11:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130Ab1GSJgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 05:36:32 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:38178
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903Ab1GSJgb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2011 05:36:31 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 907713804001
	for <git@vger.kernel.org>; Tue, 19 Jul 2011 11:36:29 +0200 (CEST)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177446>

Hello list,

I have installed git repo based on http://  protocol and both read+write access is based on a htpasswd based authentication. The git repo is "bare" so that push is possible. But I like to have push from a limited users only, not from all. For the rest, only pull should be possible. Is there any way to achieve this type of ACL ?

Thanks

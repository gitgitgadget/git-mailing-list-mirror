From: "J. Bakshi" <joydeep@infoservices.in>
Subject: How to push the very last modification only ?
Date: Mon, 18 Jul 2011 13:17:30 +0530
Message-ID: <20110718131730.4898ddaf@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:47:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiiY9-0003GT-6c
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740Ab1GRHr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:47:27 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:35838
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751407Ab1GRHr1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 03:47:27 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 2532B3804001
	for <git@vger.kernel.org>; Mon, 18 Jul 2011 09:47:23 +0200 (CEST)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177343>

Hello list,

I have found that during push, all local commit goes into the git server. Where I like to only push the very last modification with a meaningful comment which will be available at the git server. How can I then push only the last modified one ?

Thanks

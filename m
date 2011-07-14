From: "J. Bakshi" <joydeep@infoservices.in>
Subject: How to provide authentication along with git command itself ?
Date: Thu, 14 Jul 2011 16:15:08 +0530
Message-ID: <20110714161508.2378c155@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 12:45:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhJPu-0006Fh-8m
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 12:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab1GNKpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 06:45:06 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:53327
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754020Ab1GNKpF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 06:45:05 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 5206B2004001
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 12:45:03 +0200 (CEST)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177109>

Hello list,

During git push or fetch over http , I need to provide username and password every time, as protected by apache htpasswd file. How can I provide the same along with git command ? Or something so that It save the authentication info somewhere within .git 

Thanks

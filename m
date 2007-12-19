From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Fix git-instaweb breakage on MacOS X due to the limited sed functionality
Date: Wed, 19 Dec 2007 12:23:08 +0000
Message-ID: <20071219122308.GA32088@hashpling.org>
References: <20071219114823.GA28273@hashpling.org> <20071219115319.GA29184@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 13:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xxb-0000YM-N1
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 13:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbXLSMXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 07:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbXLSMXO
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 07:23:14 -0500
Received: from pih-relay05.plus.net ([212.159.14.132]:47744 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbXLSMXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 07:23:13 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1J4xx9-0003Lx-6q
	for git@vger.kernel.org; Wed, 19 Dec 2007 12:23:11 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBJCN8Vi032382
	for <git@vger.kernel.org>; Wed, 19 Dec 2007 12:23:08 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id lBJCN8RL032381
	for git@vger.kernel.org; Wed, 19 Dec 2007 12:23:08 GMT
Content-Disposition: inline
In-Reply-To: <20071219115319.GA29184@hashpling.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68903>

Now that I think about it, this replacement patch has invalidated the
original comment to some extent.  A replacement patch follows, with a
more consistent comment.

Charles.

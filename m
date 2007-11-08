From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 0/3] some shell portability fixes, v2
Date: Thu, 8 Nov 2007 22:46:25 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071108214624.GF31439@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 22:46:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqFDB-00024G-I2
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 22:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762395AbXKHVq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 16:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762394AbXKHVq3
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 16:46:29 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:60490 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762331AbXKHVq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 16:46:26 -0500
Received: from localhost.localdomain (xdsl-87-78-163-133.netcologne.de [87.78.163.133])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id ADA9B4000009B
	for <git@vger.kernel.org>; Thu,  8 Nov 2007 22:46:25 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1IqFCj-00058g-6j
	for git@vger.kernel.org; Thu, 08 Nov 2007 22:46:25 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64075>

Thanks for all the helpful feedback.  Here's a new series that drops the
$(()) and test -a/-o patches, and otherwise hopefully incorporates all
nits.

Cheers,
Ralf

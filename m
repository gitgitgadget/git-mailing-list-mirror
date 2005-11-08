From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Regarding: Debian: packaging updates.
Date: Tue, 8 Nov 2005 18:08:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511081806320.18374@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Nov 08 18:14:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZWxa-0007QF-Qy
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 18:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbVKHRI3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 12:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbVKHRI2
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 12:08:28 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:13265 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965149AbVKHRI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 12:08:27 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 108CD13EBB9
	for <git@vger.kernel.org>; Tue,  8 Nov 2005 18:08:27 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id E55069F1EB
	for <git@vger.kernel.org>; Tue,  8 Nov 2005 18:08:26 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id D41749F1E9
	for <git@vger.kernel.org>; Tue,  8 Nov 2005 18:08:26 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id C11E313EBB9
	for <git@vger.kernel.org>; Tue,  8 Nov 2005 18:08:26 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11340>

Hi,

I notice that there are files like "git-core.files". Wouldn't it be better 
to generate them from the Makefile? The same mechanism could then be used 
to make RPMs from the same Makefile.

Ciao,
Dscho

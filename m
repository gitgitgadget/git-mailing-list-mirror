From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Users of git-check-files?
Date: Wed, 3 Aug 2005 01:10:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Wed Aug 03 01:14:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E05x9-0002vN-FL
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 01:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVHBXNH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 19:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVHBXNH
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 19:13:07 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40095 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261925AbVHBXKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2005 19:10:48 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 3C7B5E1B14
	for <git@vger.kernel.org>; Wed,  3 Aug 2005 01:10:46 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 22E7592EB5
	for <git@vger.kernel.org>; Wed,  3 Aug 2005 01:10:46 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 1197092976
	for <git@vger.kernel.org>; Wed,  3 Aug 2005 01:10:46 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id E8C4DE1B14
	for <git@vger.kernel.org>; Wed,  3 Aug 2005 01:10:45 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

there's git-check-files in the repository, but AFAIK nobody uses it, not 
even "git status", which would be the primary candidate. If really no 
users of git-check-files exist, maybe we should remove it?

Ciao,
Dscho

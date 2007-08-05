From: Steffen Prohaska <prohaska@zib.de>
Subject: How to figure out what 'git push' would do?
Date: Sun, 5 Aug 2007 13:37:34 +0200
Message-ID: <267CDD46-549B-4BFE-B993-80CD1CFE75D8@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 13:36:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHePp-000454-Ug
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 13:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbXHELgo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 07:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbXHELgo
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 07:36:44 -0400
Received: from mailer.zib.de ([130.73.108.11]:50104 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbXHELgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 07:36:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l75BagYL011461
	for <git@vger.kernel.org>; Sun, 5 Aug 2007 13:36:42 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10786.pool.einsundeins.de [77.177.7.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l75BafP2023884
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 5 Aug 2007 13:36:42 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54996>

How can I check what a 'git push' would do, without
actually doing it?

Is there something like 'git push --dry-run', similar
to 'rsync --dry-run'?

	Steffen

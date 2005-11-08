From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Regarding: git-lost+found
Date: Tue, 8 Nov 2005 18:13:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511081811080.18406@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Nov 08 18:17:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZX20-0000h4-Mk
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 18:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbVKHRNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 12:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbVKHRNI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 12:13:08 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:22226 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030271AbVKHRNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 12:13:07 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id CE06813F12C
	for <git@vger.kernel.org>; Tue,  8 Nov 2005 18:13:06 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id B0C0FB50F4
	for <git@vger.kernel.org>; Tue,  8 Nov 2005 18:13:06 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 9451EB50E9
	for <git@vger.kernel.org>; Tue,  8 Nov 2005 18:13:06 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 811A313F12C
	for <git@vger.kernel.org>; Tue,  8 Nov 2005 18:13:06 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11341>

Hi,

I think this is a valuable addition to the "Now what?" part of git. 
However, I'd like to see the results stored into .git/refs/lost+found/ 
rather than .git/lost+found/, so that it is possible to inspect them 
easily with gitk or git-show-branch.

Just my sue tents,
Dscho

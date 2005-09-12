From: jamal <hadi@cyberus.ca>
Subject: cg-rm suggestion
Date: Mon, 12 Sep 2005 09:23:46 -0400
Organization: unknown
Message-ID: <1126531426.6380.2.camel@localhost.localdomain>
Reply-To: hadi@cyberus.ca
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 12 15:25:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEoI1-0003eo-Jg
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 15:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVILNXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 09:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVILNXt
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 09:23:49 -0400
Received: from mx01.cybersurf.com ([209.197.145.104]:8122 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S1750824AbVILNXt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 09:23:49 -0400
Received: from mail.cyberus.ca ([209.197.145.21])
	by mx01.cybersurf.com with esmtp (Exim 4.30)
	id 1EEoHj-0003AT-6z
	for git@vger.kernel.org; Mon, 12 Sep 2005 07:23:47 -0600
Received: from cpe0030ab124d2f-cm014500000962.cpe.net.cable.rogers.com ([24.103.96.183] helo=[10.0.0.229])
	by mail.cyberus.ca with esmtp (Exim 4.20)
	id 1EEoHl-00056m-KD
	for git@vger.kernel.org; Mon, 12 Sep 2005 09:23:49 -0400
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8381>


Folks,

I am not on the list so cc if you respond.

A small suggestion for cg-rm: Can you make the default not to physically
remove the file since that is more destructive?
Unless there is a way to recover it.

Let someone who wants to delete explicitly specify it. Or maybe even do
the rm -i like option of prompting.

cheers,
jamal

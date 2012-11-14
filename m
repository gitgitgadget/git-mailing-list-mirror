From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: v1.8.0-150-gb0b00a3: Weird documentation for git-rm
Date: Wed, 14 Nov 2012 15:15:29 -0300
Message-ID: <201211141815.qAEIFTBi017644@netbook1.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: gitster@pobox.com, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 19:25:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYhe4-0004yx-Ng
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 19:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423022Ab2KNSYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 13:24:50 -0500
Received: from zimbra.inf.utfsm.cl ([200.1.19.17]:45433 "EHLO
	zimbra.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422887Ab2KNSYt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 13:24:49 -0500
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Nov 2012 13:24:49 EST
Received: from localhost (localhost [IPv6:::1])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTP id DE948181502;
	Wed, 14 Nov 2012 15:15:30 -0300 (CLST)
X-Virus-Scanned: amavisd-new at zimbra.inf.utfsm.cl
Received: from zimbra.inf.utfsm.cl ([IPv6:::1])
	by localhost (zimbra.inf.utfsm.cl [IPv6:::1]) (amavisd-new, port 10026)
	with ESMTP id 4MyEI5hOSUsy; Wed, 14 Nov 2012 15:15:30 -0300 (CLST)
Received: from quelen.inf.utfsm.cl (unknown [IPv6:2800:270:c:0:201:29ff:fefc:bb25])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTPS id C1CD31813E6;
	Wed, 14 Nov 2012 15:15:30 -0300 (CLST)
Received: from netbook1.inf.utfsm.cl (ip64.4.priv.inf.utfsm.cl [10.10.4.64])
	by quelen.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id qAEIFU75015849;
	Wed, 14 Nov 2012 15:15:30 -0300
Received: from netbook1.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by netbook1.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id qAEIFTBi017644;
	Wed, 14 Nov 2012 15:15:29 -0300
Content-ID: <17642.1352916929.1@netbook1.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209736>

The file Documentation/git-rm.txt says:

---8><---- 8><-------
Using ``git add -A''
~~~~~~~~~~~~~~~~~~~~
When accepting a new code drop for a vendor branch, you probably
want to record both the removal of paths and additions of new paths
as well as modifications of existing paths.

Typically you would first remove all tracked files from the working
tree using this command:

Submodules
~~~~~~~~~~
---8><---- 8><-------

I believe a command is missing here.

The explanation also leaves me scratching my head...

(In Fedora's git-1.7.7.6-1.fc16.x86_64 there is a command and some further
explanation).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile 2340000       Fax:  +56 32 2797513

From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: git-core-arch: Missing dependency
Date: Fri, 11 Nov 2005 11:46:06 -0300
Message-ID: <200511111446.jABEk6QM023362@pincoya.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Fri Nov 11 15:48:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaaAg-000461-EJ
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 15:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVKKOqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 09:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKKOqO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 09:46:14 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:27088 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S1750796AbVKKOqO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 09:46:14 -0500
Received: from pincoya.inf.utfsm.cl (pincoya.inf.utfsm.cl [127.0.0.1])
	by pincoya.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id jABEkCCY023363
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 11:46:12 -0300
Received: (from vonbrand@localhost)
	by pincoya.inf.utfsm.cl (8.13.1/8.12.11/Submit) id jABEk6QM023362
	for git@vger.kernel.org; Fri, 11 Nov 2005 11:46:06 -0300
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11602>

The command git-archimport makes use of tla, but the relevant package(s) are
not on the requirements
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

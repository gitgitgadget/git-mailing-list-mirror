From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: RPM report on git and cogito
Date: Sat, 12 Nov 2005 10:53:22 -0300
Message-ID: <200511121353.jACDrMNk031209@pincoya.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Nov 12 23:16:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb3ey-0002zA-LV
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 23:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVKLWPm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 17:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVKLWPl
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 17:15:41 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:35480 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S932353AbVKLWPl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 17:15:41 -0500
Received: from pincoya.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by pincoya.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id jACDrMNk031209
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 10:53:22 -0300
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11714>

Fedora rawhide, x86_64

Latest git and cogito build fine, and git-core-arch now has the correct tla
dependency. But git-core-email still asks for perl(Email::Valid) which is
/not/ provided by the Fedora repositories. I don't understand enough of
what it tries to do with that to go in and hack it out.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

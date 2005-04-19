From: Marc Girod <girod@shire.ntc.nokia.com>
Subject: Re: SCM ideas from 2003
Date: 19 Apr 2005 08:31:42 +0300
Message-ID: <u0tkboecbuybl.fsf@merleau.ntc.nokia.com>
References: <42647D3D.6030906@qualitycode.com>
Reply-To: Marc Girod <girod@shire.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 19 09:31:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNnBx-0001TS-Kx
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 09:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVDSHeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 03:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVDSHeq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 03:34:46 -0400
Received: from main.gmane.org ([80.91.229.2]:3733 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261352AbVDSHeo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 03:34:44 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DNnBY-0001Qg-Nb
	for git@vger.kernel.org; Tue, 19 Apr 2005 09:30:17 +0200
Received: from finn.gmane.org ([80.91.229.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Apr 2005 09:30:16 +0200
Received: from girod by finn.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Apr 2005 09:30:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: finn.gmane.org
Mail-Copies-To: never
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "KS" == Kevin Smith <yarcs@qualitycode.com> writes:

KS> "what's so special about files ?" where the author suggests that
KS> existing SCM systems are so blinded by the tradition of file
KS> orientation that they can't see that there might be alternatives.

Correct: file orientation is eventually a limitation.

But there are other dimensions to investigate in order to overcome it.
The issue is to offer a *location* for the possible versions -- not
only sequential changes but also alternatives.

A directory may be considered as a namespace.
Note that there are other cases of 'containers': archives, packages,
libraries, etc...

-- 
Marc Girod        P.O. Box 323        Voice:  +358-71 80 25581
Nokia BI          00045 NOKIA Group   Mobile: +358-50 38 78415
Valimo 21 / B616  Finland             Fax:    +358-71 80 64474


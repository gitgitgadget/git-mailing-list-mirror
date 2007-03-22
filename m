From: Bernt Hansen <bernt@norang.ca>
Subject: Re: emacs and git...
Date: Thu, 22 Mar 2007 13:19:35 -0400
Organization: Norang Consulting Inc
Message-ID: <878xdp9owo.fsf@gollum.intra.norang.ca>
References: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com>
	<86lkhpmftt.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 18:30:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUR7R-0000St-HB
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 18:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934148AbXCVRaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 13:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934150AbXCVRaS
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 13:30:18 -0400
Received: from main.gmane.org ([80.91.229.2]:45758 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934148AbXCVRaO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 13:30:14 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HUR6v-0007nq-UJ
	for git@vger.kernel.org; Thu, 22 Mar 2007 18:30:02 +0100
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([74.119.210.211])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 18:30:01 +0100
Received: from bernt by cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 18:30:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.95 (gnu/linux)
Cancel-Lock: sha1:J6YdY3EI2XI3WEG/DWzby/cX3GU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42872>

I use M-x term instead of shell mode to interact with git.  That works
fine for me.

C-c C-j and C-c C-k switches between line and character mode so the
regular emacs control sequences are not sent directly to the term
session.
 
-Bernt

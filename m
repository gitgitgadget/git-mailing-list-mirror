From: "Steven E. Harris" <seh@panix.com>
Subject: Re: Dangerous "git am --abort" behavior
Date: Thu, 23 Dec 2010 17:06:14 -0500
Organization: SEH Labs
Message-ID: <m2tyi45ell.fsf@Spindle.sehlabs.com>
References: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
	<loom.20101220T203122-271@post.gmane.org>
	<1292881979.23145.5.camel@drew-northup.unet.maine.edu>
	<AANLkTikUn+Mco3YeJ7Rj=xZrr1H5xr1Z0=cknf1MdCqC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 23:06:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVtIv-0005iX-RE
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 23:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab0LWWG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 17:06:28 -0500
Received: from lo.gmane.org ([80.91.229.12]:35382 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098Ab0LWWG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 17:06:27 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PVtIo-0005em-Od
	for git@vger.kernel.org; Thu, 23 Dec 2010 23:06:26 +0100
Received: from 75-144-0-121-busname-pa.hfc.comcastbusiness.net ([75.144.0.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Dec 2010 23:06:26 +0100
Received: from seh by 75-144-0-121-busname-pa.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Dec 2010 23:06:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 75-144-0-121-busname-pa.hfc.comcastbusiness.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.50 (darwin)
Cancel-Lock: sha1:lqpEak5v/xhZD90wAv+F5seliE4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164138>

Adam Monsen <haircut@gmail.com> writes:

> That's a good way to keep tabs on whether you're in the middle of a
> rebase or am (as well as many other statuses).

How so? How are you using it for this purpose?

-- 
Steven E. Harris

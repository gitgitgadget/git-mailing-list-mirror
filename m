From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Use $Id$ as the ident attribute keyword rather than $ident$ 
 to be consistent with other VCSs
Date: Mon, 14 May 2007 16:19:18 +0200
Organization: eudaptics software gmbh
Message-ID: <46486FE6.16A82D9A@eudaptics.com>
References: <200705141429.58412.andyparkins@gmail.com> <200705141437.25528.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 16:19:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnbOL-0007gb-Ol
	for gcvg-git@gmane.org; Mon, 14 May 2007 16:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbXENOTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 10:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbXENOTH
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 10:19:07 -0400
Received: from main.gmane.org ([80.91.229.2]:50859 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbXENOTF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 10:19:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HnbO7-0006Ky-Nv
	for git@vger.kernel.org; Mon, 14 May 2007 16:18:59 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 May 2007 16:18:59 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 May 2007 16:18:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47242>

Andy Parkins wrote:
> I think that bzr uses $Id$; Mercurial has examples hooks for $Id$;
> monotone has $Id$ on its wishlist.  I can't think of a good reason not
> to stick with the de-facto standard and call ours $Id$ instead of
> $ident$.

I very much agree. I wondered why it was named $ident$ in the first
place. Now that I'm not alone, I thought I'd throw my 2 cents in...

-- Hannes

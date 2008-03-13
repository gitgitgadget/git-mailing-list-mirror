From: David Brown <git@davidb.org>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 10:43:28 -0700
Message-ID: <20080313174328.GA3783@old.davidb.org>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com> <20080313114738.GC2414@genesis.frugalware.org> <alpine.LSU.1.00.0803131254580.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 18:44:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrTT-0004Zo-MV
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 18:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbYCMRne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 13:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754017AbYCMRne
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 13:43:34 -0400
Received: from mail.davidb.org ([66.93.32.219]:40168 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338AbYCMRne (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 13:43:34 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1JZrSi-00011d-Bs; Thu, 13 Mar 2008 10:43:28 -0700
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803131254580.1656@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77108>

On Thu, Mar 13, 2008 at 12:55:11PM +0100, Johannes Schindelin wrote:

>The latter can be remedied (somewhat) by encrypting each object 
>individually.  In that case, .gitattributes can help (you should be able 
>to find a mail to that extent, which I sent no more than 2 weeks ago).  
>However, you must make sure that the encryption is repeatable, i.e. two 
>different encryption runs _must_ result in _identical_ output.

Any decent file encryption program will never have this characteristic.
It's normally a bad idea from a security perspective.

David

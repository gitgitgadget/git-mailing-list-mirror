From: Petko Manolov <petkan@nucleusys.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 16:45:43 +0200 (EET)
Message-ID: <alpine.DEB.1.00.0801161643480.5260@bender.nucleusys.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <ee77f5c20801160254u53e07773qb4125ffd90cf7619@mail.gmail.com> <alpine.DEB.1.00.0801161517260.5260@bender.nucleusys.com> <alpine.LSU.1.00.0801161341430.17650@racer.site>
 <alpine.DEB.1.00.0801161549140.5260@bender.nucleusys.com> <D3716EB3-10B1-4D96-AB12-BD86CBB189CB@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:47:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF9YF-00050K-Ea
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbYAPOrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 09:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753938AbYAPOrF
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 09:47:05 -0500
Received: from n152-u15.cabletel.bg ([89.253.152.15]:40044 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753847AbYAPOrE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 09:47:04 -0500
Received: from bender.nucleusys.com ([192.168.234.2])
	by zztop.nucleusys.com with esmtp (Exim 4.63)
	(envelope-from <petkan@nucleusys.com>)
	id 1JF9Xa-0007Ti-42; Wed, 16 Jan 2008 16:46:54 +0200
In-Reply-To: <D3716EB3-10B1-4D96-AB12-BD86CBB189CB@wincent.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70685>

On Wed, 16 Jan 2008, Wincent Colaiuta wrote:

> If the exact contents of these large binaries *really* don't matter, as 
> you say they don't, than why don't you just commit one and never touch 
> it again?

Unfortunately those binaries does change, although the process is slow and 
not very frequent.  And this is why it pokes me in the eye - for changing 
a few bytes i end up with much larger repository.


 		Petko

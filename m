From: Markus Prinz <markus.prinz@nuclearsquid.com>
Subject: Re: [RFH] Installing qgit under OS X 10.5.2 [was: Aloha]
Date: Sun, 27 Apr 2008 20:08:48 +0200
Message-ID: <6C7771E6-CED6-4DF6-B98E-0F3D7C2B7BFE@nuclearsquid.com>
References: <e5bfff550804270224s10ea9dacu8899aa3523926895@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>, drmark@gmail.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 20:36:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqBjG-0007Hm-3G
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 20:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758958AbYD0SfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 14:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758238AbYD0SfO
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 14:35:14 -0400
Received: from 213-239-221-182.clients.your-server.de ([213.239.221.182]:42328
	"EHLO quaternion.qsig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758107AbYD0SfN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 14:35:13 -0400
X-Greylist: delayed 1576 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Apr 2008 14:35:13 EDT
Received: from 091-141-005-094.dyn.one.at (091-141-005-094.dyn.one.at [91.141.5.94])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by quaternion.qsig.org (Postfix) with ESMTP id CCA4344E758;
	Sun, 27 Apr 2008 20:08:52 +0200 (CEST)
In-Reply-To: <e5bfff550804270224s10ea9dacu8899aa3523926895@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80476>


On 27.04.2008, at 11:24, Marco Costalba wrote:
> I have been trying to get the 3-21-08 version to compile on OS X
> 10.5.2 and I have not succeeded. Are there instructions or do you have
> advice on the proper compile steps?

Wincent Colaiuta has written up instructions for compiling QGit 2.0rc1  
on OS X Tiger: http://rails.wincent.com/wiki/Installing_QGit_2.0rc1_on_Mac_OS_X_Tiger

The same process worked for me on X.5.2 (Leopard) with Qt 4.3.4 and  
QGit 2.1.1 (using Xcode 3.0 from the Leopard DVD, haven't tried the  
beta from the iPhone SDK).

regards, Markus

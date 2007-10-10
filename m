From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] git-gui: set NO_MSGFMT to force using pure tcl replacement in msysgit
Date: Wed, 10 Oct 2007 17:58:49 +0200
Message-ID: <CC4EB4CA-3BA0-4C00-8B23-31B09032CC69@zib.de>
References: <8F81028C-9924-4AA2-A58D-961AD10F5315@zib.de> <11919995392158-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0710101651360.4174@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 17:57:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfdwB-0002lB-TA
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 17:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677AbXJJP5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 11:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755077AbXJJP5W
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 11:57:22 -0400
Received: from mailer.zib.de ([130.73.108.11]:46648 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878AbXJJP5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 11:57:21 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9AFvIfM028474;
	Wed, 10 Oct 2007 17:57:18 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9AFvHHB006355
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 10 Oct 2007 17:57:17 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710101651360.4174@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60515>


On Oct 10, 2007, at 5:52 PM, Johannes Schindelin wrote:

> On Wed, 10 Oct 2007, Steffen Prohaska wrote:
>
>> Shawn's git-gui Makefile supports the pure tcl replacement for  
>> msgfmt if
>> setting NO_MSGFMT. This patch sets the NO_MSGFMT for msysgit.
>
> Would it not be cleaner to set this in 4msysgit and export it?

What does "set this in 4msysgit" mean?

Would running 'make' in /git/git-gui/ be supported by your solution?

	Steffen

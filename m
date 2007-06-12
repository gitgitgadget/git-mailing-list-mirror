From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Port forwarding
Date: Tue, 12 Jun 2007 20:12:14 +0200
Message-ID: <20070612181213.GA2459@steel.home>
References: <466EBB1B.9060405@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Claudio Scordino <cloud.of.andor@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 20:12:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyAqp-0000XN-Pg
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 20:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbXFLSMS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 14:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbXFLSMS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 14:12:18 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:33643 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816AbXFLSMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 14:12:18 -0400
Received: from tigra.home (Fac05.f.strato-dslnet.de [195.4.172.5])
	by post.webmailer.de (fruni mo53) (RZmta 7.2)
	with ESMTP id E01c10j5CHSOhn ; Tue, 12 Jun 2007 20:12:16 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 50972277BD;
	Tue, 12 Jun 2007 20:12:15 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A26EBD261; Tue, 12 Jun 2007 20:12:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <466EBB1B.9060405@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFhL
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49984>

Claudio Scordino, Tue, Jun 12, 2007 17:26:19 +0200:
> 
> However, I don't know how make git-clone go on a port different than the 
> default (9418).
> 

git clone git://server:port/~cloud/project/

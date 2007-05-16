From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv3] connect: display connection progress
Date: Wed, 16 May 2007 10:19:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705161019390.3890@woody.linux-foundation.org>
References: <20070516170941.GA19449@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed May 16 19:23:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoNDI-00035I-2b
	for gcvg-git@gmane.org; Wed, 16 May 2007 19:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132AbXEPRWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 13:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757175AbXEPRWw
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 13:22:52 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55913 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756132AbXEPRWv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2007 13:22:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4GHM6AV003888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 May 2007 10:22:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4GHJwb8005767;
	Wed, 16 May 2007 10:19:59 -0700
In-Reply-To: <20070516170941.GA19449@mellanox.co.il>
X-Spam-Status: No, hits=-3.543 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47444>



On Wed, 16 May 2007, Michael S. Tsirkin wrote:
>
> Make git notify the user about host resolution/connection attempts.
> This is useful both as a progress indicator on slow links, and helps
> reassure the user there are no firewall problems.

Looks fine to me. Ack.

		Linus

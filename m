From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] Deltification library work by Nicolas Pitre.
Date: Thu, 19 May 2005 08:40:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0505190837430.3895@localhost.localdomain>
References: <7vwtpv1pd4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.62.0505191019180.20274@localhost.localdomain>
 <Pine.LNX.4.58.0505190736020.2322@ppc970.osdl.org>
 <Pine.LNX.4.58.0505190833380.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 19 17:41:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYn8U-0007gr-2N
	for gcvg-git@gmane.org; Thu, 19 May 2005 17:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVESPk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 11:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVESPk6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 11:40:58 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:47514 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262522AbVESPjv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 11:39:51 -0400
X-AuthUser: davidel@xmailserver.org
Received: from debstar.dev.mdolabs.com
	by xmailserver.org with [XMail 1.21 ESMTP Server]
	id <S17F173> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Thu, 19 May 2005 08:41:00 -0700
X-X-Sender: davide@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505190833380.2322@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 19 May 2005, Linus Torvalds wrote:

>
> [ This goes to the list because Davide can apparently receive the list
>   emails, but for some reason apparently doesn't like my osdl.org
>   address ]

[Just greylist timeout ;)]


> Davide,
>
> would you mind signing off on me adding the lines
>
>  *  This file is free software; you can redistribute it and/or
>  *  modify it under the terms of the GNU Lesser General Public
>  *  License as published by the Free Software Foundation; either
>  *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  Use of this within git automatically means that the LGPL
> + *  licensing gets turned into GPLv2 within this project.
>  */

Signed-off-by: Davide Libenzi <davidel@xmailserver.org>


- Davide


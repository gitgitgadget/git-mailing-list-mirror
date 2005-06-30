From: Nicolas Pitre <nico@cam.org>
Subject: verify_pack.c vs verify-pack.c
Date: Thu, 30 Jun 2005 13:41:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506301336460.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 19:36:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do2xb-0002nv-3u
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 19:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVF3RnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 13:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbVF3RnW
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 13:43:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49592 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262842AbVF3Rmg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 13:42:36 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IIW00G7XRSOU6@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Jun 2005 13:41:12 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This is confusing.  Isn't possible to rename git-verify-pack to, say, 
git-fsck-pack instead?


Nicolas

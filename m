From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Trivial path optimization test
Date: Tue, 25 Jul 2006 01:23:39 +0200
Message-ID: <20060724232339.GC14792@steel.home>
References: <Pine.LNX.4.64.0607140828250.5623@g5.osdl.org> <20060717223432.GA25522@steel.home> <7v4px7h5df.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jul 25 01:24:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G59mR-0007K1-CB
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 01:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWGXXYB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 19:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWGXXYA
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 19:24:00 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:20698 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932327AbWGXXX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 19:23:59 -0400
Received: from fwd31.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1G59mB-0005EC-00; Tue, 25 Jul 2006 01:23:51 +0200
Received: from tigra.home (TFwDsaZ6YeRMTY5iV3bEkYU2jPEoxMfo1eT3IKom8LG2XJT8NTnSc9@[84.160.82.84]) by fwd31.sul.t-online.de
	with esmtp id 1G59m0-04RX0K0; Tue, 25 Jul 2006 01:23:40 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D55A9277AF;
	Tue, 25 Jul 2006 01:23:39 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1G59lz-0002iR-RP; Tue, 25 Jul 2006 01:23:39 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4px7h5df.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-ID: TFwDsaZ6YeRMTY5iV3bEkYU2jPEoxMfo1eT3IKom8LG2XJT8NTnSc9
X-TOI-MSGID: 2b3c7dee-ccff-44eb-98dc-caefbe549c62
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24155>

Junio C Hamano, Mon, Jul 24, 2006 08:41:16 +0200:
> Clean up the commit log pretty please.

No problem.

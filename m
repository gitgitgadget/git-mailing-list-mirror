From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: gitk error: expected integer but got "Hamano"
Date: Sun, 2 Dec 2007 17:41:26 +0100
Message-ID: <FB5CFAB8-D580-4D72-A9A9-BA90ACF6F04C@zib.de>
References: <20071202160204.GA13141@fawkes>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 17:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyrs2-0008M9-HH
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 17:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbXLBQkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 11:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390AbXLBQkW
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 11:40:22 -0500
Received: from mailer.zib.de ([130.73.108.11]:59914 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbXLBQkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 11:40:21 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lB2GeHjd019744;
	Sun, 2 Dec 2007 17:40:17 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1a965.pool.einsundeins.de [77.177.169.101])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lB2GeG9r003661
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 2 Dec 2007 17:40:16 +0100 (MET)
In-Reply-To: <20071202160204.GA13141@fawkes>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66791>


On Dec 2, 2007, at 5:02 PM, Jing Xue wrote:

>
> I'd try to debug myself but my knowledge on tcl/tk is rather limited
> (read: zero).

See my mail "Corrupted (?) commit 6e6db85e confusing gitk", which
describes the reason in detail.

	Steffen

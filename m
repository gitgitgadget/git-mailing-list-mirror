From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] gitk - Handle MouseWheel events on Windows
Date: Sat, 11 Aug 2007 08:23:37 -0400
Message-ID: <46BDAA49.40802@verizon.net>
References: <1186440352826-git-send-email-mdl123@verizon.net>
 <11865372352543-git-send-email-mdl123@verizon.net>
 <11865372381125-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mdl123@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 14:24:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJq0d-00062C-OC
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 14:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbXHKMXo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 08:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbXHKMXo
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 08:23:44 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:44275 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXHKMXn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 08:23:43 -0400
Received: from [192.168.100.117] ([71.246.233.117])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JML00E90ZREIFGD@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 11 Aug 2007 07:23:38 -0500 (CDT)
In-reply-to: <11865372381125-git-send-email-mdl123@verizon.net>
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55607>

Ping - any chance of getting these two patches into 1.5.3? They fix a 
pair of long-standing frustrations for
Cygwin (and now msys/Windows) users:

[PATCH] gitk - enable selected patch text on Windows
[PATCH] gitk - Handle MouseWheel events on Windows

Mark

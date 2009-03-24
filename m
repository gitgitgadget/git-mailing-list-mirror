From: Peter <vmail@mycircuit.org>
Subject: fatal: unable to write sha1 file git 1.6.2.1
Date: Tue, 24 Mar 2009 19:20:30 +0100
Message-ID: <49C9246E.3030508@mycircuit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 20:22:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmCCd-0001ZW-JC
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 20:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215AbZCXTUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 15:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756506AbZCXTUk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 15:20:40 -0400
Received: from mailfe01.tele2.ch ([212.247.154.8]:35131 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753160AbZCXTUj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 15:20:39 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Mar 2009 15:20:39 EDT
X-Cloudmark-Score: 0.000000 []
X-Cloudmark-Analysis: v=1.0 c=1 a=U7ljaUMLlY8A:10 a=fRAkYKdf6TQA:10 a=Qy6mu5jw0WABpOr/wumM4A==:17 a=cdYCcDJ_oD3ur0an4pUA:9 a=WFk_rtoPICSlVoKTF4wA:7 a=UMrKy9I5XCRHgaoe_dagiRtkM2MA:4 a=50e4U0PicR4A:10
Received: from mail.mycircuit.org (account cxu-8g8-ypb@tele2.ch [83.180.79.156] verified)
  by mailfe01.swip.net (CommuniGate Pro SMTP 5.2.6)
  with ESMTPA id 164571489 for git@vger.kernel.org; Tue, 24 Mar 2009 19:20:31 +0100
Received: from [192.168.1.192] (unknown [192.168.1.192])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "p_email", Issuer "192.168.2.2" (verified OK))
	by mail.mycircuit.org (Postfix) with ESMTP id 036F2D0360
	for <git@vger.kernel.org>; Tue, 24 Mar 2009 19:20:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114478>

Hi
I try to add a directory with lots of binary files to a git repository.
I receive the error message:
*
fatal: unable to write sha1 file

*This is  git 1.6.2.1.

Are there limits concerning binary files ( like executables , images ) 
for the inclusion in a git repo ?

Thanks a lot for your help

Peter

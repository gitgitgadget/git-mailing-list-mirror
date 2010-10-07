From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Differing results between gitk --follow and git log --follow
Date: Thu, 07 Oct 2010 12:13:04 -0600
Message-ID: <4CAE0DB0.1090608@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 07 20:13:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3uxu-0007AE-Fb
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 20:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab0JGSNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 14:13:08 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:42761 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237Ab0JGSNG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 14:13:06 -0400
Received: (qmail 20579 invoked by uid 399); 7 Oct 2010 12:13:05 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@69.98.187.106)
  by hsmail.qwknetllc.com with ESMTPAM; 7 Oct 2010 12:13:05 -0600
X-Originating-IP: 69.98.187.106
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158422>

  When I run git log --follow, I see a nice history of my file as it was 
renamed.

When I run gitk --follow, I see the beginnings of the history, but there 
are missing parts.

Is there a way to convince gitk to show me the same bits as git log 
--follow?

Thanks.

Josh

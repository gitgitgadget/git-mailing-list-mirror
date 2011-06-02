From: Andrew Spiers <aspiers@vpac.org>
Subject: git status --ignored
Date: Thu, 02 Jun 2011 14:43:14 +1000
Message-ID: <4DE714E2.7040002@vpac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 06:43:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRzkX-0003rt-RB
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 06:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab1FBEm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 00:42:27 -0400
Received: from mail.vpac.org ([202.158.218.6]:34832 "EHLO mail.vpac.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879Ab1FBEm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 00:42:26 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jun 2011 00:42:26 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vpac.org (Postfix) with ESMTP id 1CB0EC01A773B
	for <git@vger.kernel.org>; Thu,  2 Jun 2011 14:42:25 +1000 (EST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.91 tagged_above=-10 required=5
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, T_RP_MATCHES_RCVD=-0.01]
	autolearn=ham
Received: from mail.vpac.org ([127.0.0.1])
	by localhost (mail.vpac.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S2wy5HCu+EuV for <git@vger.kernel.org>;
	Thu,  2 Jun 2011 14:42:20 +1000 (EST)
Received: from [172.31.4.36] (cape.in.vpac.org [172.31.4.36])
	by mail.vpac.org (Postfix) with ESMTPSA id 55ADFC01A76FD
	for <git@vger.kernel.org>; Thu,  2 Jun 2011 14:42:20 +1000 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174924>

***git status --ignored -h does show my ignored files and directories.
sorry, that should read:
git status --ignored -s does show my ignored files and directories.

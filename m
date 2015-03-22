From: Johannes Schneider <mailings@cedarsoft.com>
Subject: rebase with commit.gpgsign = true
Date: Sun, 22 Mar 2015 22:13:31 +0100
Message-ID: <550F307B.3030708@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 22:21:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZnJe-0007ZE-Eq
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 22:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbbCVVVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 17:21:46 -0400
Received: from hosting.cedarsoft.com ([176.9.159.237]:42939 "EHLO
	mail.cedarsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbbCVVVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 17:21:45 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Mar 2015 17:21:45 EDT
Received: from [192.168.0.81] (HSI-KBW-37-209-77-150.hsi15.kabel-badenwuerttemberg.de [37.209.77.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.cedarsoft.com (Postfix) with ESMTPSA id 5E17F1E8C0D
	for <git@vger.kernel.org>; Sun, 22 Mar 2015 22:13:33 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266095>

Hey guys,

I love the commit.gpgsign feature.

When rebasing some commits, every commit is signed - even those of other 
authors.
Is there a way to configure git to only sign my commits?


Thanks,

Johannes

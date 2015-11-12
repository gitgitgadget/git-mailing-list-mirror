From: Francis ANDRE <francis.andre.kampbell@orange.fr>
Subject: GitGui: get rid of information popup window
Date: Thu, 12 Nov 2015 15:26:28 +0100
Message-ID: <5644A194.7090505@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 15:26:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zwspm-0001Li-5d
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 15:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349AbbKLO0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 09:26:38 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:49400 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbbKLO0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 09:26:37 -0500
Received: from [192.168.1.2] ([2.5.195.151])
	by mwinf5d49 with ME
	id geSX1r0063GThDe03eSXw3; Thu, 12 Nov 2015 15:26:34 +0100
X-ME-Helo: [192.168.1.2]
X-ME-Auth: ZnJhbmNpcy5hbmRyZS5rYW1wYmVsbEB3YW5hZG9vLmZy
X-ME-Date: Thu, 12 Nov 2015 15:26:34 +0100
X-ME-IP: 2.5.195.151
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281219>

Hi Git people

This popup  saying that "No difference has been detected" is little bit 
boring and useless since it states that an automatic resync will be 
started and there is no way to stop the resync.

Can GitGui remove this popup?

Thanks

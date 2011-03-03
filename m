From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: libgit2: Resolving HEAD to a SHA
Date: Thu, 03 Mar 2011 09:08:32 -0700
Message-ID: <4D6FBD00.6010208@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 03 17:08:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvB4z-0008JM-6c
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 17:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758463Ab1CCQId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 11:08:33 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:45283 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758430Ab1CCQIc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 11:08:32 -0500
Received: (qmail 15672 invoked by uid 399); 3 Mar 2011 09:08:31 -0700
Received: from unknown (HELO ?192.168.1.10?) (jjensen@workspacewhiz.com@50.8.99.117)
  by hsmail.qwknetllc.com with ESMTPAM; 3 Mar 2011 09:08:31 -0700
X-Originating-IP: 50.8.99.117
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b3pre Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168400>

I spent a couple hours yesterday trying different methods of resolving 
HEAD to its appropriate SHA-1.  At best, I could get a resolution of 
HEAD to 'master'.

How do I achieve the functionality of 'git rev-parse' with the libgit2 API?

Thanks.

Josh

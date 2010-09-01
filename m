From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: getting git to ignore modifications to specific files
Date: Wed, 01 Sep 2010 13:06:33 -0600
Message-ID: <4C7EA439.2000901@workspacewhiz.com>
References: <4C7EA1FF.8030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 21:06:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqsdu-0006aF-Lm
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 21:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab0IATGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 15:06:37 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:44759 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab0IATGg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 15:06:36 -0400
Received: (qmail 14763 invoked by uid 399); 1 Sep 2010 13:06:36 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.196.133.190)
  by hsmail.qwknetllc.com with ESMTPAM; 1 Sep 2010 13:06:36 -0600
X-Originating-IP: 75.196.133.190
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <4C7EA1FF.8030307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155069>

  ----- Original Message -----
From: Chris Packham
Date: 9/1/2010 12:57 PM
> I did a bit of googling and found
>    git update-index --assume-unchanged
>
> Which works locally to stop git status from complaining. Is there anyway
> for me to make a change to our clone (a .gitattribues entry?) so that
> everyone can get this by default?
I don't think so (but I hope I'm wrong!).

Good idea, though.  +1 from me for being necessary.

Josh

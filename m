From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git config --list --local?
Date: Tue, 03 Aug 2010 19:09:49 -0600
Message-ID: <4C58BDDD.6020600@workspacewhiz.com>
References: <4C583EA5.5000406@workspacewhiz.com> <m38w4npssl.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 03:10:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgSUb-0005P5-5S
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 03:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758025Ab0HDBJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 21:09:51 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:58766 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757956Ab0HDBJu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 21:09:50 -0400
Received: (qmail 16552 invoked by uid 399); 3 Aug 2010 19:09:50 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 3 Aug 2010 19:09:50 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.7) Gecko/20100713 Lightning/1.0b2 Thunderbird/3.1.1
In-Reply-To: <m38w4npssl.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152550>

  ----- Original Message -----
From: Jakub Narebski
Date: 8/3/2010 10:25 AM
> git config --file .git/config --list
This looks like it will work for me.

I've never looked at the config section of the Git code.  I'll have to 
see what it would take to add a --local command line option to do the 
same thing as above but in a more convenient fashion.

Josh

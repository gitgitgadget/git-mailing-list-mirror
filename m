From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git branch --track to link existing local branch to remote?
Date: Tue, 25 May 2010 13:55:04 -0600
Message-ID: <4BFC2B18.2050904@workspacewhiz.com>
References: <AANLkTinxohzZE6uinzYPIAx3iVjw7afDLsr9MPMUAvHj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue May 25 21:55:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH0Da-0002nz-VP
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 21:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516Ab0EYTzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 15:55:08 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39097 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758708Ab0EYTzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 15:55:07 -0400
Received: (qmail 5585 invoked by uid 399); 25 May 2010 13:55:05 -0600
Received: from unknown (HELO ?192.168.1.121?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 25 May 2010 13:55:05 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
In-Reply-To: <AANLkTinxohzZE6uinzYPIAx3iVjw7afDLsr9MPMUAvHj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147726>

skillzero@gmail.com wrote:
> Is there a way to link a local branch, which already exists, to a
> remote branch without editing the git config file?
git branch --set-upstream

Josh

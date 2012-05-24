From: Ben Tebulin <nntp.20.jexpert@spamgourmet.com>
Subject: Re: git-svn: --ignore-paths appears to be ignored
Date: Thu, 24 May 2012 13:45:33 +0200
Message-ID: <jpl70m$r97$1@dough.gmane.org>
References: <CAH3Anrrz3OB2CofKAnRn2yR3DQRvHyQQSp6=GG-jqvYyD79b9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 13:45:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXWUL-0006Vk-IS
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 13:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369Ab2EXLpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 07:45:49 -0400
Received: from plane.gmane.org ([80.91.229.3]:41117 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab2EXLps (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 07:45:48 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SXWUC-0005xZ-Hx
	for git@vger.kernel.org; Thu, 24 May 2012 13:45:44 +0200
Received: from 217.6.238.194 ([217.6.238.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 May 2012 13:45:44 +0200
Received: from nntp.20.jexpert by 217.6.238.194 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 May 2012 13:45:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 217.6.238.194
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAH3Anrrz3OB2CofKAnRn2yR3DQRvHyQQSp6=GG-jqvYyD79b9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198365>

Am 07.05.2012 00:42, schrieb Jon Seymour:
> I configured ignore-paths as follows:
>      svn-remote.svn.ignore-paths=^DB.*
>
> I expected this would exclude paths of this kind on the initial fetch:
>      DB/.project

I have the same issue here. I'm failing to import multiple svn 
repository into Git and --ignore-paths provides me no cure.

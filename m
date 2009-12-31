From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] MinGW: Use pid_t more consequently, introduce uid_t
 	for greater compatibility
Date: Thu, 31 Dec 2009 14:50:37 +0100
Message-ID: <4B3CAC2D.5050500@kdbg.org>
References: <hhbldr$di8$1@ger.gmane.org> <4B3A7000.4050308@kdbg.org> <bdca99240912291649h1c727072q3b1e4099cab426df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 14:51:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQLQt-0003yz-EV
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 14:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbZLaNui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 08:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbZLaNui
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 08:50:38 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:58056 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751859AbZLaNuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 08:50:37 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 69620A7EFE;
	Thu, 31 Dec 2009 14:50:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <bdca99240912291649h1c727072q3b1e4099cab426df@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135949>

Sebastian Schuberth schrieb:
> On Tue, Dec 29, 2009 at 22:09, Johannes Sixt <j6t@kdbg.org> wrote:
> 
>>> MinGW: Use pid_t more consequently, introduce uid_t for greater
>>> compatibility
>> Why this? Compatibility with what? What's the problem with the status quo?
> 
> I wanted to include Hany's Dos2Unix tool (hd2u) into msysGit.

We have dos2unix. What's wrong with it?

-- Hannes

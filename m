From: alex@bellandwhistle.net
Subject: gitignore vs. exclude vs =?UTF-8?Q?assume-unchanged=3F?=
Date: Wed, 16 Apr 2014 09:33:33 -0700
Message-ID: <b3f480af1c362c615ad9ce85296e2be2@bellandwhistle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 19:21:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaTVy-0002ez-CT
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 19:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbaDPRUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 13:20:43 -0400
Received: from selene.fortifiedserver.net ([98.158.151.224]:48379 "EHLO
	selene.fortifiedserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755205AbaDPRUk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2014 13:20:40 -0400
X-Greylist: delayed 2824 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Apr 2014 13:20:40 EDT
Received: from localhost.uu.net ([127.0.0.1]:35121 helo=selene.fortifiedserver.net)
	by selene.fortifiedserver.net with esmtpa (Exim 4.82)
	(envelope-from <alex@bellandwhistle.net>)
	id 1WaSmD-0003iU-Iw
	for git@vger.kernel.org; Wed, 16 Apr 2014 09:33:33 -0700
X-Sender: alex@bellandwhistle.net
User-Agent: Roundcube Webmail/0.9.5
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - selene.fortifiedserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bellandwhistle.net
X-Get-Message-Sender-Via: selene.fortifiedserver.net: authenticated_id: alex@bellandwhistle.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246350>

Any clarification on the differences much appreciated:

http://stackoverflow.com/questions/23097368/git-ignore-vs-exclude-vs-assume-unchanged/23097509

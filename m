From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: git format-patch glitch?
Date: Thu, 6 Aug 2009 09:57:06 +0200
Message-ID: <2319BD2A-EA70-4C77-940E-924EF833379B@dbservice.com>
References: <ED82D2F5-3E0A-491E-BDD8-3742B769193D@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Aug 06 10:31:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYyNZ-0001zH-ON
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 10:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbZHFIav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 04:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbZHFIav
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 04:30:51 -0400
Received: from office.neopsis.com ([78.46.209.98]:39008 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbZHFIau (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 04:30:50 -0400
X-Greylist: delayed 1995 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Aug 2009 04:30:50 EDT
Received: from calvin.emmen.dbservice.com ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Thu, 6 Aug 2009 09:57:32 +0200
In-Reply-To: <ED82D2F5-3E0A-491E-BDD8-3742B769193D@uwaterloo.ca>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125052>


On Aug 6, 2009, at 6:55 AM, Mark A Rada wrote:

> I noticed this at the top of every patch that git creates for me:
>
> From 3c34cfa3987c310e4c3194e06d25a08557f0bdb0 Mon Sep 17 00:00:00 2001
>
> Well, the commit hash is different, but the date is always the same.  
> Is this expected
> behaviour? It happens for different repositories on different  
> computers that use different
> versions of git.

http://thread.gmane.org/gmane.comp.version-control.git/124082

tom

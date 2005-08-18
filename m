From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] gitweb - Use <description> instead of <content:encoded>.
Date: Thu, 18 Aug 2005 17:36:07 +0200
Message-ID: <20050818153607.GX11882MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <87ll2zwc4u.wl@mail2.atmark-techno.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 17:32:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5mM1-0007dF-Gg
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 17:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVHRPav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 11:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVHRPav
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 11:30:51 -0400
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:45501 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S932252AbVHRPau (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 11:30:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by nibbel.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 513E34C1D7
	for <git@vger.kernel.org>; Thu, 18 Aug 2005 17:30:49 +0200 (CEST)
Received: from smtp03.kuleuven.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by nibbel.kulnet.kuleuven.ac.be (Postfix) with ESMTP id C764B4C065
	for <git@vger.kernel.org>; Thu, 18 Aug 2005 17:30:47 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by smtp03.kuleuven.be (Postfix) with ESMTP id BAF2D33273E
	for <git@vger.kernel.org>; Thu, 18 Aug 2005 17:30:47 +0200 (CEST)
Received: (qmail 12000 invoked by uid 500); 18 Aug 2005 15:36:07 -0000
To: Yasushi SHOJI <yashi@atmark-techno.com>
Mail-Followup-To: Yasushi SHOJI <yashi@atmark-techno.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87ll2zwc4u.wl@mail2.atmark-techno.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2005 at 11:30:41PM +0900, Yasushi SHOJI wrote:
> Use <description> instead of <content:encoded>.
> 

Hmm.... in snownews this gets displayed as "Use  instead of .".
(http://www.liacs.nl/~sverdool/gitweb.cgi?p=gitweb.git;a=rss)

Is that a problem with snownews or with gitweb ?

skimo

From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: cogito Mac OS X compatibility
Date: Sat, 9 Jul 2005 18:50:28 +0200
Message-ID: <20050709165028.GY18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <42CF0D9F.8040909@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 19:10:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrIq3-0007vA-UP
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 19:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVGIRJc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 13:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVGIRJc
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 13:09:32 -0400
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:37819 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261627AbVGIRJY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 13:09:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by rusty.kulnet.kuleuven.ac.be (Postfix) with ESMTP id C9C651D735D
	for <git@vger.kernel.org>; Sat,  9 Jul 2005 19:09:17 +0200 (CEST)
Received: from octavianus.kulnet.kuleuven.ac.be (octavianus.kulnet.kuleuven.ac.be [134.58.240.71])
	by rusty.kulnet.kuleuven.ac.be (Postfix) with ESMTP id DC6791D73B7
	for <git@vger.kernel.org>; Sat,  9 Jul 2005 19:09:15 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by octavianus.kulnet.kuleuven.ac.be (Postfix) with ESMTP id D07ABAED85
	for <git@vger.kernel.org>; Sat,  9 Jul 2005 19:09:15 +0200 (CEST)
Received: (qmail 12807 invoked by uid 500); 9 Jul 2005 16:50:28 -0000
To: Bryan Larsen <bryan.larsen@gmail.com>
Mail-Followup-To: Bryan Larsen <bryan.larsen@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <42CF0D9F.8040909@gmail.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 08, 2005 at 07:34:55PM -0400, Bryan Larsen wrote:
> This appears to be some sort of weird shell thing.  I've got bash 3.0 
> compiling in the background to see if that fixes the problem.
> 
Sounds like you're missing "stat" from coreutils.

skimo

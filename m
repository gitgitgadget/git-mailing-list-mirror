From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: Re: Honoring a checked out gitattributes file
Date: Thu, 12 Mar 2009 10:36:13 +0100
Message-ID: <1236850575-27973-1-git-send-email-kristian.amlie@nokia.com>
References: <1233320413-28069-1-git-send-email-kristian.amlie@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 10:38:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhhMx-0004cN-Nf
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 10:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbZCLJgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 05:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbZCLJgo
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 05:36:44 -0400
Received: from hoat.troll.no ([62.70.27.150]:41186 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbZCLJgn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 05:36:43 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id E9AB52115E
	for <git@vger.kernel.org>; Thu, 12 Mar 2009 10:36:40 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id E2F792114D
	for <git@vger.kernel.org>; Thu, 12 Mar 2009 10:36:40 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n2C9aeAo025981
	for <git@vger.kernel.org>; Thu, 12 Mar 2009 10:36:40 +0100
Received: from axis.localdomain ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Thu, 12 Mar 2009 10:36:40 +0100 (CET)
Received: by axis.localdomain (Postfix, from userid 1000)
	id 332B73618807; Thu, 12 Mar 2009 10:36:40 +0100 (CET)
In-Reply-To: <1233320413-28069-1-git-send-email-kristian.amlie@trolltech.com>
x-scalix-Hops: 1
X-Mailer: git-send-email 1.6.2.105.g16bc7.dirty
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113029>


Ok, it took a bit longer than I thought to get around to this, but I
finally have a patch for the problem. I am not so familiar with the
Git source code, so I apologize if I do something incredibly stupid.

Hopefully the commit message should explain what I do, but please ask
questions if it's not clear. I'm sure there's room for improvements.

--
Kristian

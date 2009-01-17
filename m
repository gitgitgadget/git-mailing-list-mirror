From: jidanni@jidanni.org
Subject: Re: log-tree.c: date hardwired
Date: Sun, 18 Jan 2009 07:50:35 +0800
Message-ID: <87bpu5cx10.fsf@jidanni.org>
References: <81b0412b0901171538l5e9fb66bh862c9b7a125fc98f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: raa.lkml@gmail.com
X-From: git-owner@vger.kernel.org Sun Jan 18 00:52:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOKxV-0008BR-Q8
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 00:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbZAQXui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 18:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbZAQXui
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 18:50:38 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:42213 "EHLO
	homiemail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752071AbZAQXui (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jan 2009 18:50:38 -0500
Received: from jidanni.org (122-127-32-36.dynamic.hinet.net [122.127.32.36])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a6.g.dreamhost.com (Postfix) with ESMTP id 7AEC115478;
	Sat, 17 Jan 2009 15:50:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106113>

Perhaps a comment could be added to the code as to the reason a date
or that certain date is hardwired. Any reason would be satisfactory.

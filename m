From: Andrew Mackenzie <andrew@mackenzie-serres.net>
Subject: Re: remote helper example with push/fetch capabilities
Date: Wed, 14 Jan 2015 21:57:31 +0000 (UTC)
Message-ID: <loom.20150114T225554-824@post.gmane.org>
References: <CAPCWLt6kxoJJSWAcyH_kW071Md0vc4zeo41hCKBQHd-_pvUMXQ@mail.gmail.com> <xmqqegs0d1qv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 23:25:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBWNJ-0003YZ-CC
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 23:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbbANWZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 17:25:10 -0500
Received: from plane.gmane.org ([80.91.229.3]:33732 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbbANWZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 17:25:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YBWN6-0003RV-G0
	for git@vger.kernel.org; Wed, 14 Jan 2015 23:25:04 +0100
Received: from 204.27.133.37.dynamic.jazztel.es ([37.133.27.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 23:25:04 +0100
Received: from andrew by 204.27.133.37.dynamic.jazztel.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 23:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 37.133.27.204 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262437>

I'm interested in doing something very similar (not to S3, but to a customer 
CMS repository), but have found it very difficult to find any documentation or 
good example code on git-remote-helpers.

If you can share any learnings or references I would really appreciate it!

thanks, Andrew

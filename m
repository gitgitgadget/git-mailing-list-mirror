From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from
 remote remote"
Date: Sun, 15 Apr 2012 14:09:01 +0200
Message-ID: <20120415120901.GA14003@ecki>
References: <4F893CD8.5020700@gmail.com>
 <20120414201446.GB29999@ecki>
 <4F8A0F96.5060408@gmail.com>
 <20120415011118.GA4123@ecki>
 <4F8A8211.2010908@gmail.com>
 <20120415105943.GD6263@ecki>
 <4F8AAE7C.1020507@gmail.com>
 <20120415114518.GB9338@ecki>
 <4F8AB7F1.1020705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 14:10:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJOHl-0003uz-9Q
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 14:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839Ab2DOMKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 08:10:22 -0400
Received: from smtpout11.highway.telekom.at ([195.3.96.69]:41621 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754734Ab2DOMKT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 08:10:19 -0400
Received: (qmail 25917 invoked from network); 15 Apr 2012 12:10:14 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL604.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub77.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <stefano.lattarini@gmail.com>; 15 Apr 2012 12:10:14 -0000
Content-Disposition: inline
In-Reply-To: <4F8AB7F1.1020705@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195564>

On Sun, Apr 15, 2012 at 01:58:41PM +0200, Stefano Lattarini wrote:
>
> OK, I cut & pasted your command; it ran successfully, with this output:

And your installed git version is the same as the one you are seeing the
deadlock with?

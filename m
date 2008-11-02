From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: Make revision display
 configurable
Date: Sun, 02 Nov 2008 15:24:48 -0800
Message-ID: <490E36C0.5040701@pcharlan.com>
References: <1225668059-12670-1-git-send-email-pgit@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 00:26:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwmKZ-0001Yq-GK
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 00:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbYKBXYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 18:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753721AbYKBXYt
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 18:24:49 -0500
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:48240 "EHLO
	swarthymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753681AbYKBXYt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Nov 2008 18:24:49 -0500
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a4.g.dreamhost.com (Postfix) with ESMTP id C6953129A83;
	Sun,  2 Nov 2008 15:24:48 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <1225668059-12670-1-git-send-email-pgit@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99887>

Sorry for the repeat emails....this first-time "git send-email" user was
a little surprised that it appears to always cc git@vger...

<hides behind rock>

--Pete

Pete Harlan wrote:
> Add configuration option hooks.showrev, letting the user override how
> revisions will be shown in the commit email.

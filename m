From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH next] git-cherry usage: correct nesting of commit-ish options
Date: Sun, 4 Jan 2009 17:16:00 +0100
Message-ID: <200901041716.00673.markus.heidelberg@web.de>
References: <200901041711.23026.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 04 17:16:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJVeq-0003vb-0x
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 17:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbZADQPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 11:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbZADQPd
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 11:15:33 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:56981 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbZADQPd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 11:15:33 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0BC53F634BE1;
	Sun,  4 Jan 2009 17:15:31 +0100 (CET)
Received: from [89.59.126.169] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LJVdS-0006Al-00; Sun, 04 Jan 2009 17:15:30 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <200901041711.23026.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/R9pQx+yskmXYjgp5MnnZkvs8e8Y0f8CCcWD65
	UCB7GSS1nij+JSKbfkBXHLShigQ+pvUH1s6RCnU9L7pf/dzyTn
	52IiyrC1+RC7CQqQCFBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104523>

Markus Heidelberg, 04.01.2009:
> 
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> ---
> 
> What is the preferred way to say the patch is against next? In the
> subject like this?
> Another question: should this patch be split up into two, one for
> maint/master and another for next?

For the second patch against next I meant it being based on origin/next
that already includes the extracted patch for maint/master.

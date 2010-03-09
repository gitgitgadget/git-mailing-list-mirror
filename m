From: rhlee <richard@webdezign.co.uk>
Subject: Re: Handling non-git config files
Date: Tue, 9 Mar 2010 02:50:27 -0800 (PST)
Message-ID: <1268131827388-4701369.post@n2.nabble.com>
References: <8440EA2C12E50645A68C4AA9887166513FC19C@SERVER.webdezign.local> <2cfc40321002241337q6b437803m82d05fb272cca6b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 13:53:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyXl-0001Do-6j
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab0CIKu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 05:50:29 -0500
Received: from kuber.nabble.com ([216.139.236.158]:51250 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab0CIKu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 05:50:28 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <richard@webdezign.co.uk>)
	id 1Nox19-0007iW-Cl
	for git@vger.kernel.org; Tue, 09 Mar 2010 02:50:27 -0800
In-Reply-To: <2cfc40321002241337q6b437803m82d05fb272cca6b2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141826>


Git-list,

Thanks to Jon, Ian and Tim for your replies.

I was reading Jon's reply and the workflow he uses seems to fit my purpose.
To migrate an application, you would branch it, set any local configuration
and commit. To bring over any changes you would just merge them over. This
would leave any deployment artifacts (a great term to describe local
changes) intact.

I have only been using branching and merging since November, when I was
instructed how to do so by git-list. I realise now that this is just basic
branching and merging. The workflow described will work with any SCM
software that supports branching and merging.

Richard
-- 
View this message in context: http://n2.nabble.com/Handling-non-git-config-files-tp4622419p4701369.html
Sent from the git mailing list archive at Nabble.com.

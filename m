From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Sun, 6 Apr 2008 23:30:16 +0300
Message-ID: <200804062330.16900.tlikonen@iki.fi>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 22:31:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JibW9-00033F-Fg
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 22:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbYDFUaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 16:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbYDFUaV
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 16:30:21 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:58578 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753285AbYDFUaU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2008 16:30:20 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB9600491F48; Sun, 6 Apr 2008 22:30:19 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78922>

Adam Simpkins kirjoitti:

> I think there are benefits to having the graphing functionality built
> in to git.  This way all of the existing log functionality (argument
> parsing, pretty formats, etc) can be easily re-used.  Other builtin
> parts of git can also take advantage of the graphing API. 

I don't know anything about the inside stuff but from user's point of 
view this is the kind of text-based graph I'd agree to be integrated to 
Git (well, I integrated it already to my Git). I like this a lot, 
thanks.

Maybe git-doc.txt should be updated with new option(s)?

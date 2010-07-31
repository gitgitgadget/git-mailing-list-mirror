From: Walter Bright <boost@digitalmars.com>
Subject: noob user, want checkins to all be forced to LF terminated lines
Date: Fri, 30 Jul 2010 21:23:43 -0700
Organization: Digital Mars
Message-ID: <i308gl$v6p$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 06:24:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of3cQ-0003la-6e
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 06:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076Ab0GaEX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 00:23:59 -0400
Received: from lo.gmane.org ([80.91.229.12]:37671 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab0GaEX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 00:23:58 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Of3c5-0003ff-Ar
	for git@vger.kernel.org; Sat, 31 Jul 2010 06:23:57 +0200
Received: from c-24-16-56-60.hsd1.wa.comcast.net ([24.16.56.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 06:23:57 +0200
Received: from boost by c-24-16-56-60.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 06:23:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-56-60.hsd1.wa.comcast.net
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152299>

I've just started with git. Exactly what do I put in $HOME/.gitconfig ?

I find the text at 
http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html#_checking_out_and_checking_in

to be confusing. Which of the text, eol, crlf, or autocrlf attributes do I set, 
and exactly what text do I put in the config file?

Thanks for any help!

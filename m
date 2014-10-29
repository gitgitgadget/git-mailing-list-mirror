From: Francis Irving <francis@scraperwiki.com>
Subject: Bug reporting method too hard to find
Date: Wed, 29 Oct 2014 11:58:57 +0000
Message-ID: <20141029115857.GB33348@bat.dot-bit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 13:39:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjSXK-0005Xb-0d
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 13:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797AbaJ2Mje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 08:39:34 -0400
Received: from haggis.mythic-beasts.com ([93.93.131.52]:38603 "EHLO
	haggis.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932759AbaJ2Mjd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 08:39:33 -0400
X-Greylist: delayed 2432 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Oct 2014 08:39:33 EDT
Received: from [93.93.130.55] (port=46898 helo=sphinx.mythic-beasts.com)
	by haggis.mythic-beasts.com with esmtp (Exim 4.80)
	(envelope-from <francis@scraperwiki.com>)
	id 1XjRu0-0000Kc-Cu
	for git@vger.kernel.org; Wed, 29 Oct 2014 11:59:00 +0000
Received: from secure.pacec.co.uk ([93.93.130.55]:50330 helo=bat.localdomain)
	by sphinx.mythic-beasts.com with esmtp (Exim 4.72)
	(envelope-from <francis@scraperwiki.com>)
	id 1XjRtz-0007Q6-5C
	for git@vger.kernel.org; Wed, 29 Oct 2014 11:58:59 +0000
Received: by bat.localdomain (Postfix, from userid 502)
	id 0558652AF4DD; Wed, 29 Oct 2014 11:58:57 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Mythic-Sender-Verify: + host 64.233.166.27 accepted RCPT TO with '250 2.1.5 OK fu14si5931588wjc.11 - gsmtp'
X-Spam-Status: No, score=-1.2
X-BlackCat-Spam-Score: -11
Received-SPF: softfail (secure.pacec.co.uk: transitioning domain of francis@scraperwiki.com does not designate 93.93.130.55 as permitted sender) client-ip=93.93.130.55 envelope-from=francis@scraperwiki.com helo=bat.localdomain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I could not find out how to report a bug. In the end, a colleague
had to tell me.

Some suggested improvements:


1) Explicitly mention the word "bug" on the home page, or have
a page which Google will find called "Reporting bugs".


2) I did eventually get to the Community page:
http://git-scm.com/community

Alas, when I scanned the headline "Mailing List" I ignored that
whole section because I didn't want to join a mailing list - I just
wanted to report a bug.

I'd call it maybe "Mailing List and Bug Reporting". Or have a 
separate bugs section below called "Bug Reporting" which refers
to the mailing list.


3) I definitely wasn't going to subscribe to a mailing list to report
a bug (no idea why - I'm just reporting my instinct which lots of
people likely have). 

I am only doing so because I saw that I don't have to subscribe.

I'm not sure how to make it clearer, but it needs to be as it is
highly unintuitive. These days, you have to join most email lists to
post to them.


This all matters, because Git is likely losing lots of basic bugs,
particularly ones to do with usability for beginner users.

Thanks for a great tool!

Francis

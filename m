From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Sun, 6 Apr 2008 14:44:46 -0700
Message-ID: <20080406214445.GA5822@adamsimpkins.net>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net> <200804062330.16900.tlikonen@iki.fi>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sun Apr 06 23:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JicgB-0006U1-8p
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 23:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbYDFVot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 17:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbYDFVot
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 17:44:49 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:50576 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbYDFVos (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 17:44:48 -0400
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id BC86972D429;
	Sun,  6 Apr 2008 17:44:47 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 9BB9272D3C8;
	Sun,  6 Apr 2008 17:44:47 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 7CFB114100BB; Sun,  6 Apr 2008 14:44:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200804062330.16900.tlikonen@iki.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78933>

On Sun, Apr 06, 2008 at 11:30:16PM +0300, Teemu Likonen wrote:
> 
> Maybe git-doc.txt should be updated with new option(s)?

Ah, you're right, I forgot about that.  I'll send out a new patch to
update Documentation/rev-list-options.txt

-- 
Adam Simpkins
adam@adamsimpkins.net

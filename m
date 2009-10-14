From: Petr Baudis <pasky@suse.cz>
Subject: Re: gitweb atom feeds broken (on repo.or.cz only?)
Date: Wed, 14 Oct 2009 16:17:44 +0200
Message-ID: <20091014141744.GO6695@machine.or.cz>
References: <4ABFA258.8020301@hartwork.org>
 <be6fef0d0909280023x46522d91oc786feef23cb226a@mail.gmail.com>
 <4AC0CBBE.7020603@hartwork.org>
 <4AD46F38.30100@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 16:35:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My4wq-0000pr-2a
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 16:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760891AbZJNO1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 10:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758461AbZJNO1Z
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 10:27:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47335 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757387AbZJNO1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 10:27:24 -0400
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2009 10:27:24 EDT
Received: by machine.or.cz (Postfix, from userid 2001)
	id 04DE186201D; Wed, 14 Oct 2009 16:17:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4AD46F38.30100@hartwork.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130293>

On Tue, Oct 13, 2009 at 02:14:48PM +0200, Sebastian Pipping wrote:
> Petr, any news on this one?
> 
> I just check and it still seems broken.

Fixed, it's a HTML::Email::Obfuscate bug.

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth

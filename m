From: Pavel Roskin <proski@gnu.org>
Subject: Re: qgit shows wrong popup
Date: Fri, 13 Jan 2006 16:06:21 -0500
Message-ID: <1137186381.2480.3.camel@dv>
References: <1137021690.10975.22.camel@dv>
	 <e5bfff550601120455p1b1654cx43beb684a3fd5dc7@mail.gmail.com>
	 <43C7E645.2050702@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 13 22:08:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExW9m-0003DV-E9
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 22:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422967AbWAMVH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 16:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422971AbWAMVH4
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 16:07:56 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:3714 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1422967AbWAMVH4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 16:07:56 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1ExW6s-0004zb-D6
	for git@vger.kernel.org; Fri, 13 Jan 2006 16:05:23 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1ExW7p-0000y2-Je; Fri, 13 Jan 2006 16:06:21 -0500
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <43C7E645.2050702@yahoo.it>
X-Mailer: Evolution 2.5.4 (2.5.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14648>

Hi, Marco!

On Fri, 2006-01-13 at 18:41 +0100, Marco Costalba wrote:
> please test the following an let me know if it is ok for you.

It works, but not the first time.  Suppose I have two unapplied patches
and one applied.  qgit focuses on the top unapplied patch on startup.
Right-click on the applied patch shows disabled "Push Patch".  Then I
select the top line again, right-click on the applied patch, and I see
enabled "Pop Patch".

-- 
Regards,
Pavel Roskin

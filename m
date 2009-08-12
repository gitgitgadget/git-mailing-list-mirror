From: Jimmy Angelakos <vyruss@hellug.gr>
Subject: Re: git-gui translation pushed
Date: Wed, 12 Aug 2009 23:29:49 +0300
Message-ID: <1250108989.2088.1.camel@blob>
References: <1245870671.5526.14.camel@blob>
	 <20090810154429.GU1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 22:45:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbKhX-0006rG-E9
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 22:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbZHLUp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 16:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754897AbZHLUp2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 16:45:28 -0400
Received: from mx-out.forthnet.gr ([193.92.150.105]:36420 "EHLO
	mx-out.forthnet.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbZHLUp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 16:45:27 -0400
X-Greylist: delayed 920 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2009 16:45:27 EDT
Received: from mx-av-06.forthnet.gr (mx-av.forthnet.gr [193.92.150.27])
	by mx-out-05.forthnet.gr (8.14.3/8.14.3) with ESMTP id n7CKU5cI012880;
	Wed, 12 Aug 2009 23:30:05 +0300
Received: from MX-IN-01.forthnet.gr (mx-in-01.forthnet.gr [193.92.150.23])
	by mx-av-06.forthnet.gr (8.14.3/8.14.3) with ESMTP id n7CKU5r6018722;
	Wed, 12 Aug 2009 23:30:05 +0300
Received: from [192.168.10.100] (adsl16-148.ath.forthnet.gr [77.49.207.148])
	by MX-IN-01.forthnet.gr (8.14.3/8.14.3) with ESMTP id n7CKU10o023453;
	Wed, 12 Aug 2009 23:30:02 +0300
Authentication-Results: MX-IN-01.forthnet.gr smtp.mail=vyruss@hellug.gr; spf=neutral
Authentication-Results: MX-IN-01.forthnet.gr header.from=vyruss@hellug.gr; sender-id=neutral
In-Reply-To: <20090810154429.GU1033@spearce.org>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125744>

On Mon, 2009-08-10 at 08:44 -0700, Shawn O. Pearce wrote:
> Jimmy Angelakos <vyruss@hellug.gr> wrote:
> > I have pushed a Greek translation for git-gui on repo.or.cz's
> > git-gui-i18n (mob branch).
> 
> Thanks, I have cherry-picked this through to master.  The charset
> was set wrong in the files, it was "CHARSET", which isn't a valid
> charset.  I modified to UTF-8 before applying.  I suspect something
> is up with your PO editor.
> 

Thanks for mentioning that, I'll check it out. It's either something
wrong with Lokalize or my mistake.

Regards
Jimmy

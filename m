From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: non-ascii filenames issue
Date: Sun, 5 Apr 2009 12:23:35 -0400
Message-ID: <76718490904050923j105e383dsf650afa0a0687858@mail.gmail.com>
References: <20090405093640.GA9803@home> <87ab6v2zor.fsf@iki.fi>
	 <20090405100127.GA12126@home>
	 <43d8ce650904050351p72590d52l8861b3901f95201a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 18:25:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqVAM-0004ek-DJ
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 18:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbZDEQXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 12:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbZDEQXi
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 12:23:38 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:48578 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbZDEQXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 12:23:37 -0400
Received: by gxk4 with SMTP id 4so3942207gxk.13
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kxjAIQKNOS57xDdc9Bgbq/MC3mGvJZehvzzFuw0lk8M=;
        b=Dn7QUelvOcrKSRAag3W+/3lczQubTXbGE8Ur8ECyguZorbO/cgEGJIEeNX0eW+PjKQ
         lWC5TCHqBlX+R3bkI6o8rTMuskjDWKWTCPcGD3uXC/BWXcWGI57XWAn0QkcX30JotWGP
         EFz8YB0A34WFUDTybR8QmgBvIEZdt8lnOugRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qy9SLC301bcdovuM0tVW5QH90LvUEs8buTMhsjLYC8noyhRCh9tGPn6QC2dIir3jf9
         rpbqiSSmFB889pHNUjNFm9RB/xIO1DirYQldGpBYIaJbMH1s60C7lwh+5tMLG1xXa14I
         +bLyMtOjFueOHHni1SRe+IBgeI11H5w/uMI44=
Received: by 10.150.143.5 with SMTP id q5mr5188918ybd.124.1238948615033; Sun, 
	05 Apr 2009 09:23:35 -0700 (PDT)
In-Reply-To: <43d8ce650904050351p72590d52l8861b3901f95201a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115673>

On Sun, Apr 5, 2009 at 6:51 AM, John Tapsell <johnflux@gmail.com> wrote:
> Unfortunately not, because for some absolutely crazy reason

Bzzt. http://article.gmane.org/gmane.comp.version-control.git/50830

And, as always, patches welcomed.

j.

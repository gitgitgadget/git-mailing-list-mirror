From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git-aware Issue Tracking?
Date: Thu, 21 Aug 2008 11:23:25 +0200
Message-ID: <200808211123.26372.jnareb@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <m3fxozsepa.fsf@localhost.localdomain> <20080821083042.GA6517@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 11:23:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW6OA-0006Gp-TU
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 11:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbYHUJW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 05:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYHUJW1
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 05:22:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:15047 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbYHUJW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 05:22:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so520937fgg.17
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=XiiwcKTKQwYZpn1sjIKkLblxMTvr0tyjRKZH/7hQob0=;
        b=KU6ayoFXCnJmiDQ+5gCpgxHMS518EOMnusQSScguGq1oCfuckBFIiD+eyDYxZTeZIx
         N2w+SFg2GRl4mMq010jIE1Tf52ZAVEzIrLIkLiha3QaxzuyW2CMSKLHPF+lqLeX06cgd
         ACyBU61GoS3WwsYsMeFuWWZxJxOsPlR1Nt4es=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YsRKeLVoaHWcx+fbVIFswClR9i9JpnQgZRKXzju+4OMkwpxUKlER8KNVSkbXVkTbpG
         1VC0fzAUW4qL+6HRvGoOpYYxGL2nTRBj3JiwvYHZtheOFnQUh3MZPNKXf/dGUXkWv7Gd
         miWzA7ycpViROFGcPcQc/SNTqkdztJomKKldM=
Received: by 10.181.5.1 with SMTP id h1mr698110bki.7.1219310545017;
        Thu, 21 Aug 2008 02:22:25 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.246.2])
        by mx.google.com with ESMTPS id g17sm2696914nfd.3.2008.08.21.02.22.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 02:22:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080821083042.GA6517@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93128>

On Thu, 21 Aug 2008, Pierre Habouzit wrote:

> Actually there is a list, bugs-dist@kitenet.net or sth similar where
> I did it. One should look at the archives of that list. Though it's
> somehow dead again.

Archives are at http://kitenet.net/pipermail/dist-bugs/ for what its
worth (only 39 messages there).

-- 
Jakub Narebski
Poland

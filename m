From: david@lang.hm
Subject: Re: [RFC] Adding a challenge-response authentication method to
 git://
Date: Thu, 14 Aug 2008 10:18:38 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808141018220.13400@asgard.lang.hm>
References: <20080813162644.GC12200@cuci.nl> <20080813164038.GE3782@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 19:19:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTgTh-0002Eb-Ac
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 19:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756926AbYHNRSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 13:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756589AbYHNRSJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 13:18:09 -0400
Received: from mail.lang.hm ([64.81.33.126]:60948 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756144AbYHNRSI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 13:18:08 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m7EHHu0D029633;
	Thu, 14 Aug 2008 10:17:56 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20080813164038.GE3782@spearce.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92373>

On Wed, 13 Aug 2008, Shawn O. Pearce wrote:

> Isn't there some authentication frontend that some IMAP servers
> use to handle the authentication for them?  I think last time
> I setup bincimap it used checkpassword.  We might want to do the
> same if we are going down this road...

are you thinking of SASL?

David Lang

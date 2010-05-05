From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Does recent 'smart' HTTP feature help git-svn thru unfriendly
	corp. firewalls too?
Date: Wed, 5 May 2010 07:16:36 -0700
Message-ID: <20100505141636.GG11053@spearce.org>
References: <t2td43c95441005050710rb5123219v9ca23aebc01e40ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Norman <mwnorman@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 16:16:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9fPF-0000pg-IL
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 16:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760264Ab0EEOQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 10:16:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56743 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759165Ab0EEOQn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 10:16:43 -0400
Received: by wyb35 with SMTP id 35so356337wyb.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 07:16:42 -0700 (PDT)
Received: by 10.227.147.143 with SMTP id l15mr2862572wbv.17.1273069002279;
        Wed, 05 May 2010 07:16:42 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id u8sm58335483wbc.23.2010.05.05.07.16.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 07:16:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <t2td43c95441005050710rb5123219v9ca23aebc01e40ad@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146396>

Michael Norman <mwnorman@gmail.com> wrote:
> Subject line says it all - does it help?

Not sure I can see how/why.  The smart HTTP code helps git go
through a firewall, not SVN.  SVN already speaks HTTP, just
somewhat inefficiently.

-- 
Shawn.

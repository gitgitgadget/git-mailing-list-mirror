From: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v3 1/1] Makefile: make curl-config path configurable
Date: Mon, 5 Oct 2015 23:19:49 +0200
Message-ID: <20151005211949.GD386@cruxbox>
References: <1444077159-3268-1-git-send-email-repk@triplefau.lt>
 <20151005204909.GE11993@google.com>
 <20151005210545.GC386@cruxbox>
 <20151005211107.GF11993@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:19:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjDAj-0007VI-2H
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 23:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbbJEVTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 17:19:45 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54391 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbJEVTo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 17:19:44 -0400
Received: from mfilter16-d.gandi.net (mfilter16-d.gandi.net [217.70.178.144])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 764EE172070;
	Mon,  5 Oct 2015 23:19:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter16-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter16-d.gandi.net (mfilter16-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id Twb-fEqSOAAb; Mon,  5 Oct 2015 23:19:41 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id AE91F17208C;
	Mon,  5 Oct 2015 23:19:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151005211107.GF11993@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279098>

On Mon, Oct 05, 2015 at 02:11:07PM -0700, Jonathan Nieder wrote:
> Remi Pommarel wrote:
> 
> > Do I need to resend a v4 patch with these modifications ? I am not sure
> > about the correct workflow here.
> 
> If you like the changes, you can ask Junio to squash them in.
> 
> If you don't like them, that's also fine and you can just say so.

These modifications are very fine with me and can be squash in.

Thanks a lot.

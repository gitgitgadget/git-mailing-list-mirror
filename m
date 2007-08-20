From: Mike Hommey <mh@glandium.org>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 21:50:37 +0200
Organization: glandium.org
Message-ID: <20070820195037.GA9774@glandium.org>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org> <867inqhyuk.fsf@lola.quinscape.zz> <20070820181357.GA8264@glandium.org> <86zm0mgicy.fsf@lola.quinscape.zz> <20070820184829.GA8617@glandium.org> <20070820194328.GE8542@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Aug 20 21:52:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INDI6-0000ki-Nd
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 21:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbXHTTvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 15:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbXHTTvw
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 15:51:52 -0400
Received: from vawad.err.no ([85.19.200.177]:55940 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbXHTTvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 15:51:52 -0400
Received: from aputeaux-153-1-3-249.w82-124.abo.wanadoo.fr ([82.124.49.249] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1INDHd-0006bO-J2; Mon, 20 Aug 2007 21:51:50 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1INDGn-0002Xt-3n; Mon, 20 Aug 2007 21:50:37 +0200
Content-Disposition: inline
In-Reply-To: <20070820194328.GE8542@efreet.light.src>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56244>

On Mon, Aug 20, 2007 at 09:43:28PM +0200, Jan Hudec <bulb@ucw.cz> wrote:
> Git does not have tracking of file's history either.

Well, it has ways to track file's history, with blame and log, for
example. There is nothing similar for directories, though it could be
possible to do.

Mike

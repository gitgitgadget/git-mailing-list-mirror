From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: require $ENV{'GITWEB_CONFIG'}
Date: Wed, 2 Aug 2006 16:59:51 -0400
Message-ID: <20060802205951.GB15714@sigio.intra.peff.net>
References: <20060802192333.GA30861@coredump.intra.peff.net> <E1G8NLU-0006TL-J7@moooo.ath.cx> <20060802205033.GB15678@sigio.intra.peff.net> <7vhd0uua6e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 23:00:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Np5-0004NN-6F
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 23:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWHBU7y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWHBU7y
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:59:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:36049 "HELO
	peff.net") by vger.kernel.org with SMTP id S932107AbWHBU7x (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:59:53 -0400
Received: (qmail 973 invoked from network); 2 Aug 2006 16:59:17 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 2 Aug 2006 16:59:17 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Wed,  2 Aug 2006 16:59:51 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd0uua6e.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24690>

On Wed, Aug 02, 2006 at 01:58:33PM -0700, Junio C Hamano wrote:

> Sounds very sane.  So Matthias's patch now becomes something
> like this:

Acked-by: Jeff King <peff@peff.net>

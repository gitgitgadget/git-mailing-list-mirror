From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: use single quotes for values replaced by the Makefile
Date: Wed, 2 Aug 2006 16:58:58 -0400
Message-ID: <20060802205858.GA15714@sigio.intra.peff.net>
References: <20060802192333.GA30861@coredump.intra.peff.net> <E1G8N9c-0004GK-Gz@moooo.ath.cx> <7vmzamuaj6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:59:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NoC-0004C8-IJ
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWHBU7B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWHBU7B
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:59:01 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:24785 "HELO
	peff.net") by vger.kernel.org with SMTP id S932095AbWHBU7A (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:59:00 -0400
Received: (qmail 925 invoked from network); 2 Aug 2006 16:58:24 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 2 Aug 2006 16:58:23 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Wed,  2 Aug 2006 16:58:58 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzamuaj6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24689>

On Wed, Aug 02, 2006 at 01:50:53PM -0700, Junio C Hamano wrote:

> So why don't we use something other than @@, perhaps "++FOO++"?

Acked-by: Jeff King <peff@peff.net>

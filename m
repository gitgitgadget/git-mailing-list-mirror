From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: [PATCH] Clean up the SunOS Makefile rule
Date: Wed, 2 Nov 2005 20:49:48 +0100
Message-ID: <20051102194947.GB17706@ebar091.ebar.dtu.dk>
References: <20051102192730.GA17706@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 02 21:06:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXOq0-0005GA-Fg
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 21:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbVKBUDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 15:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbVKBUDz
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 15:03:55 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:53158 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S965209AbVKBUDy
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 15:03:54 -0500
Received: (qmail 18067 invoked by uid 5842); 2 Nov 2005 19:49:48 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051102192730.GA17706@ebar091.ebar.dtu.dk>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11033>

On Wed, Nov 02, 2005 at 08:27:31PM +0100, Peter Eriksen wrote:
> Don't set a non-standard CURLDIR as default, and fix an error
> in Solaris 10 by setting NEEDS_LIBICONV.

Ups, I forgot to say, that this is

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>

Regards,

Peter

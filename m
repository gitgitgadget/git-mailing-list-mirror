From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: remove PATH_INFO from $my_url and $my_uri
Date: Thu, 2 Oct 2008 16:22:35 +0200
Message-ID: <20081002142235.GO10544@machine.or.cz>
References: <1222693662-27426-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:24:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlP5r-00084b-Ur
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbYJBOWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbYJBOWl
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:22:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55000 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbYJBOWl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:22:41 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 710BC3939B52; Thu,  2 Oct 2008 16:22:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1222693662-27426-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97339>

On Mon, Sep 29, 2008 at 03:07:42PM +0200, Giuseppe Bilotta wrote:
> This patch fixes PATH_INFO handling by removing the relevant part from
> $my_url and $my_uri, thus making it unnecessary to specify them by hand
> in the gitweb configuration.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Petr Baudis <pasky@suse.cz>

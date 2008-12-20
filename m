From: Josef Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH][RESEND] guilt: add option guilt.diffstat
Date: Fri, 19 Dec 2008 23:33:38 -0500
Message-ID: <20081220043338.GS15407@josefsipek.net>
References: <20081213021422.GA28249@localhost> <20081213044357.GD15407@josefsipek.net> <20081213131700.GA8649@localhost> <20081218112643.GA15416@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Boyd Stephen Smith Jr." <bss03@volumehost.net>
To: Wu Fengguang <fengguang.wu@intel.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 05:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDtYR-000673-DO
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 05:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbYLTEdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 23:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYLTEdk
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 23:33:40 -0500
Received: from josefsipek.net ([141.211.133.196]:35966 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbYLTEdj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 23:33:39 -0500
Received: by josefsipek.net (Postfix, from userid 1000)
	id DD9761C01BA2; Fri, 19 Dec 2008 23:33:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20081218112643.GA15416@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103620>

On Thu, Dec 18, 2008 at 07:26:43PM +0800, Wu Fengguang wrote:
> Introduce option guilt.diffstat so that we don't have to type
> "guilt refresh --diffstat" in its full form every time.

Applied.

Thanks,

Josef 'Jeff' Sipek.

-- 
In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like
that.
		- Linus Torvalds

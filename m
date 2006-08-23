From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/3] gitweb: Use here-doc
Date: Tue, 22 Aug 2006 18:34:11 -0700
Message-ID: <7voducjkvg.fsf@assigned-by-dhcp.cox.net>
References: <200608221651.19629.jnareb@gmail.com>
	<200608222342.53861.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 03:34:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFhdK-0005vH-0Y
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 03:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWHWBeN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 21:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWHWBeN
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 21:34:13 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:42695 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932154AbWHWBeN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 21:34:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060823013412.WQYZ4015.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 21:34:12 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25884>

Jakub Narebski <jnareb@gmail.com> writes:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e09204d..5301213 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1185,11 +1185,13 @@ sub die_error {
>  	my $error = shift || "Malformed query, file missing or permission 
> denied";

Corrupt patch applied by hand.  Please check the result in
"next".

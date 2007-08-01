From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make the name of the library directory a config option
Date: Tue, 31 Jul 2007 22:36:39 -0700
Message-ID: <7vsl73byu0.fsf@assigned-by-dhcp.cox.net>
References: <20070801043035.GH29424@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 07:36:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG6t3-0000iP-Oj
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 07:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbXHAFgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 01:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbXHAFgl
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 01:36:41 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50071 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbXHAFgl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 01:36:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801053639.KCUM1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 1 Aug 2007 01:36:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WVcf1X00U1kojtg0000000; Wed, 01 Aug 2007 01:36:40 -0400
In-Reply-To: <20070801043035.GH29424@schiele.dyndns.org> (Robert Schiele's
	message of "Wed, 1 Aug 2007 06:30:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54410>

The patch is obvious and trivial so I'll swallow, but as a
general rule I'd like to avoid changes to the build procedure
this late in the game.

Thanks for the patch, will apply.

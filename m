From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH 3/3] git-daemon: rewrite kindergarden
Date: Wed, 13 Aug 2008 10:58:51 +0200
Message-ID: <20080813085851.GD12628@cuci.nl>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl> <20080813084331.30845.21129.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 10:59:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTCCy-0005JQ-Vz
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 10:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbYHMI6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 04:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbYHMI6w
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 04:58:52 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:58541 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbYHMI6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 04:58:52 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 5394B5465; Wed, 13 Aug 2008 10:58:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080813084331.30845.21129.stgit@aristoteles.cuci.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92197>

>+			if (max_connections<=0)
>+				max_connections=0;	        /* unlimited */

Hmmm, slight formatting error.  Sorry about that.  I'll resend this
last patch.
-- 
Sincerely,
           Stephen R. van den Berg.

"And now for something *completely* different!"

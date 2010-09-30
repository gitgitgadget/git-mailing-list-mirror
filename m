From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: Svn2git: question about --branches
Date: Thu, 30 Sep 2010 16:07:34 +0200
Message-ID: <20100930160734.056754ec@jk.gs>
References: <4E10ACF241081344B9702AA8C6440440C5B15CB469@MX01A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: nolan.ring@emc.com
X-From: git-owner@vger.kernel.org Thu Sep 30 16:07:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Jnc-0002Ey-6O
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 16:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab0I3OHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 10:07:44 -0400
Received: from zoidberg.org ([88.198.6.61]:39034 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185Ab0I3OHn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 10:07:43 -0400
Received: from jk.gs (xdsl-89-0-44-190.netcologne.de [::ffff:89.0.44.190])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 30 Sep 2010 16:07:36 +0200
  id 0040027F.4CA499AF.00004C5C
In-Reply-To: <4E10ACF241081344B9702AA8C6440440C5B15CB469@MX01A.corp.emc.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157670>

Hi,

--- nolan.ring@emc.com <nolan.ring@emc.com> wrote:

> Our svn directory structure at the top level is:
> [...]
> branches
> REbranches
> [...]
> Branches is developer branches; REbranches is release engineering
> branches.  Is there any way to specify both using --branches?

Yep... just use --branches twice. The documentation for these options
even mentions that you can do that, actually. Just saying. :)

-Jan

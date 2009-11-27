From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: change URL
Date: Fri, 27 Nov 2009 12:22:28 +0100
Message-ID: <20091127122228.660131af@perceptron>
References: <4B0FA253.6060804@gulfsat.mg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rakotomandimby Mihamina <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Fri Nov 27 12:22:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDyuM-0006aP-18
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 12:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbZK0LW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 06:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbZK0LW0
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 06:22:26 -0500
Received: from zoidberg.org ([88.198.6.61]:45296 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887AbZK0LWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 06:22:25 -0500
Received: from perceptron (xdsl-78-35-137-75.netcologne.de [::ffff:78.35.137.75])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Fri, 27 Nov 2009 12:22:29 +0100
  id 004D8092.4B0FB676.00007E00
In-Reply-To: <4B0FA253.6060804@gulfsat.mg>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133893>

Hi,

Rakotomandimby Mihamina <mihamina@gulfsat.mg> wrote:

> When I first cloned a project, I used the non fully qualified hostname
> if the repo:
>    $ git clone ssh://git/git/Mailaka
> [...] 
> What should I edit to make "git push" uses "git.rktmb.org" rather
> than "git.domainsearch-in-resolv.conf"?

it's in .git/config, and it's rather easy to find there.

Jan

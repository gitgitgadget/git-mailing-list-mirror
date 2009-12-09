From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool--lib: add diffmerge as a pre-configured
	mergetool option
Date: Wed, 9 Dec 2009 22:34:09 +0000
Message-ID: <20091209223409.GA32744@hashpling.org>
References: <1260302477-49412-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 23:45:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIVHz-00031L-3t
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 23:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758501AbZLIWpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 17:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758487AbZLIWpb
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 17:45:31 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:22535 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758467AbZLIWpa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Dec 2009 17:45:30 -0500
X-Greylist: delayed 673 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2009 17:45:30 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEACi1H0tUXebq/2dsb2JhbADWfIQsBIMX
Received: from relay07.plus.net ([84.93.230.234])
  by relay.ptn-ipout02.plus.net with ESMTP; 09 Dec 2009 22:34:10 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by relay07.plus.net with esmtp (Exim) id 1NIV6n-0003am-RC; Wed, 09 Dec 2009 22:34:09 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id nB9MY9W4000835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 Dec 2009 22:34:09 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id nB9MY97K000834;
	Wed, 9 Dec 2009 22:34:09 GMT
Content-Disposition: inline
In-Reply-To: <1260302477-49412-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 05f94bd81ec9f21a545893f448d73a5a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135003>

On Tue, Dec 08, 2009 at 12:01:17PM -0800, Jay Soffian wrote:
> Add SourceGear DiffMerge to the set of built-in diff/merge tools, and update
> bash completion and documentation.
> ---
>  Documentation/git-difftool.txt         |    2 +-
>  Documentation/git-mergetool.txt        |    2 +-
>  Documentation/merge-config.txt         |    4 ++--
>  contrib/completion/git-completion.bash |    2 +-
>  git-mergetool--lib.sh                  |   22 ++++++++++++++++++++--
>  5 files changed, 25 insertions(+), 7 deletions(-)

I'm not a diffmerge user but the patch looks fine to me.

Is diffmerge free but not Free?

Any reason for holding back on sign-off?

Charles.

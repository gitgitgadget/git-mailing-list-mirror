From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH] In Examples, explain option -r and refer to git-rev-list[1]
Date: Mon, 27 Aug 2007 10:02:10 +0200
Message-ID: <46D28502.3030003@etek.chalmers.se>
References: <r6lqfgnp.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 10:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPZYC-0003wH-4h
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbXH0ICP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 04:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbXH0ICP
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:02:15 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:58114 "EHLO
	anubis.medic.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbXH0ICN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 04:02:13 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by anubis.medic.chalmers.se (Postfix) with ESMTP id D9420E33E
	for <git@vger.kernel.org>; Mon, 27 Aug 2007 10:02:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.6) Gecko/20070804 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <r6lqfgnp.fsf@cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56772>

Jari Aalto wrote:
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-log.txt |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 49bb539..aa42f0e 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -76,7 +76,8 @@ git log -r --name-status release..test::
>  
>  	Show the commits that are in the "test" branch but not yet
>  	in the "release" branch, along with the list of paths
> -	each commit modifies.
> +	each commit modifies. Opton -r (see gitlink:git-rev-list[1])
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ spelling mistake (option)

/Lukas

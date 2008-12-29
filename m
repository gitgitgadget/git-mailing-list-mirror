From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Document git-ls-tree --full-tree
Date: Mon, 29 Dec 2008 23:36:37 +0100
Message-ID: <200812292336.37812.markus.heidelberg@web.de>
References: <20081230071818.6117@nanako3.lavabit.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 23:38:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHQkS-0003ne-H9
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 23:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbYL2Wgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 17:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbYL2Wgm
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 17:36:42 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:56836 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbYL2Wgl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 17:36:41 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9D5DFFB3D39D;
	Mon, 29 Dec 2008 23:36:38 +0100 (CET)
Received: from [91.19.66.120] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LHQj0-0006FC-00; Mon, 29 Dec 2008 23:36:38 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20081230071818.6117@nanako3.lavabit.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/QMS7z19EEzFr8Qsos1CcFh+btcee8NICOAI5J
	eQkXeV166h1d3HNyi52irz/jF3AnKjy95k0fDe4DJBw1sWTlAW
	dUqxM5EdIMzcT8APSHdg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104137>

Nanako Shiraishi, 29.12.2008:
> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
>  'git ls-tree' [-d] [-r] [-t] [-l] [-z]
> -	    [--name-only] [--name-status] [--full-name] [--abbrev=[<n>]]
> +	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev=[<n>]]
>  	    <tree-ish> [paths...]

This can additionally be done in the usage array in the source.

Markus

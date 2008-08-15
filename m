From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH] bash-completion: Add non-command git help files to
 bash-completion
Date: Fri, 15 Aug 2008 12:38:38 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808151234110.17004@harper.uchicago.edu>
References: <1218816948-7864-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Aug 15 19:41:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU3IT-0002sB-O3
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 19:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbYHORkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 13:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753937AbYHORkG
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 13:40:06 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:44260 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbYHORkF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 13:40:05 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7FHceOM024091;
	Fri, 15 Aug 2008 12:38:40 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7FHcdH1017146;
	Fri, 15 Aug 2008 12:38:39 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <1218816948-7864-1-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92497>

Hi,

Marcus Griep wrote:

> Git allows access to the gitattributes man page via `git help attributes`,
> but this is not discoverable via the bash-completion mechanism.  This
> patch adds all current non-command man pages to the completion candidate
> list.
[...]
> +		diffcore glossary hooks ignore k modules

I think k should be gitk here :)

Regards,
Jonathan

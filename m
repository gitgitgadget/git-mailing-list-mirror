From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 19/19] .gitignore: add git-remote-cvs
Date: Thu, 29 Oct 2009 11:05:38 -0700
Message-ID: <20091029180538.GC10505@spearce.org>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> <1256839287-19016-20-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:05:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZNY-0005x5-IX
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207AbZJ2SFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755172AbZJ2SFe
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:05:34 -0400
Received: from george.spearce.org ([209.20.77.23]:53954 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbZJ2SFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:05:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 92FF4381D3; Thu, 29 Oct 2009 18:05:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1256839287-19016-20-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131640>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> diff --git a/.gitignore b/.gitignore
> index 51a37b1..461f6ee 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -105,6 +105,7 @@ git-reflog
>  git-relink
>  git-remote
>  git-remote-curl
> +git-remote-cvs
>  git-repack
>  git-replace
>  git-repo-config

Uh, squash to "[PATCH 14/19] git-remote-cvs: Remote help..." ?

-- 
Shawn.

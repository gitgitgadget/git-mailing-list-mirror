From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 5/5] completion: complete values for send-email
Date: Mon, 4 May 2009 07:29:28 -0700
Message-ID: <20090504142928.GT23604@spearce.org>
References: <1241418335-18474-1-git-send-email-bebarino@gmail.com> <1241418335-18474-2-git-send-email-bebarino@gmail.com> <1241418335-18474-3-git-send-email-bebarino@gmail.com> <1241418335-18474-4-git-send-email-bebarino@gmail.com> <1241418335-18474-5-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 16:29:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0zAm-0002C1-5m
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 16:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252AbZEDO33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 10:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756326AbZEDO32
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 10:29:28 -0400
Received: from george.spearce.org ([209.20.77.23]:48222 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659AbZEDO32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 10:29:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6747438195; Mon,  4 May 2009 14:29:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1241418335-18474-5-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118242>

Stephen Boyd <bebarino@gmail.com> wrote:
> Add completion for --confirm, --suppress-cc, and --smtp-encryption
> command line arguments. Add completion for aliasfiletype and confirm
> configuration variables.
> 
> Since --smtp-ssl is deprecated, replace it with --smtp-encryption and
> the two options ssl and tls.
> 
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>

For all 5 patches in this series: nicely written, thanks.

Acked-by: Shawn O. Pearce <spearce@spearce.or>

-- 
Shawn.

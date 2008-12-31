From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Remove unused NLS messages and texts
Date: Wed, 31 Dec 2008 07:44:37 -0800
Message-ID: <20081231154437.GG29071@spearce.org>
References: <1230720430-1182-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 16:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI3Gi-0000Sa-AW
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 16:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbYLaPoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 10:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755846AbYLaPoi
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 10:44:38 -0500
Received: from george.spearce.org ([209.20.77.23]:50586 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773AbYLaPoi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 10:44:38 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9C9DA38200; Wed, 31 Dec 2008 15:44:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1230720430-1182-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104275>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
>  public class CoreText extends NLS {
> -	/** */
> -	public static String AssumeUnchangedOperation_failed;
> -
> -	/** */
> -	public static String AssumeUnchangedOperation_adding;

Nope, this is used by AssumeUnchangedOperation.
  
-- 
Shawn.

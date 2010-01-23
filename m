From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Make it possible to apply a range of changes at
	once
Date: Sat, 23 Jan 2010 15:05:43 -0800
Message-ID: <20100123230543.GG12679@spearce.org>
References: <1260231763-19194-1-git-send-email-jepler@unpythonic.net> <1260231763-19194-3-git-send-email-jepler@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Peter Baumann <waste.manager@gmx.de>
To: jepler@unpythonic.net
X-From: git-owner@vger.kernel.org Sun Jan 24 00:06:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYp3I-00066n-R1
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 00:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab0AWXFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 18:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406Ab0AWXFs
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 18:05:48 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:42498 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab0AWXFs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 18:05:48 -0500
Received: by iwn16 with SMTP id 16so1123665iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 15:05:46 -0800 (PST)
Received: by 10.231.145.70 with SMTP id c6mr4743627ibv.36.1264287946855;
        Sat, 23 Jan 2010 15:05:46 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm3273749iwn.3.2010.01.23.15.05.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 15:05:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1260231763-19194-3-git-send-email-jepler@unpythonic.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137876>

jepler@unpythonic.net wrote:
> From: Jeff Epler <jepler@unpythonic.net>
> 
> Signed-off-by: Jeff Epler <jepler@unpythonic.net>
> ---
>  git-gui.sh   |   15 +++-
>  lib/diff.tcl |  242 ++++++++++++++++++++++++++++++++++------------------------
>  2 files changed, 153 insertions(+), 104 deletions(-)

Thanks, applied.

-- 
Shawn.

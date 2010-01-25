From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: use different icon for new and modified files
	in the index
Date: Mon, 25 Jan 2010 07:35:31 -0800
Message-ID: <20100125153531.GC13899@spearce.org>
References: <201001241954.19626.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 16:37:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZQzM-0003M8-18
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 16:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab0AYPfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 10:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906Ab0AYPfm
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 10:35:42 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:43584 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab0AYPfl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 10:35:41 -0500
Received: by yxe17 with SMTP id 17so2819477yxe.33
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 07:35:36 -0800 (PST)
Received: by 10.151.93.2 with SMTP id v2mr4656994ybl.44.1264433734030;
        Mon, 25 Jan 2010 07:35:34 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm1773944ywh.16.2010.01.25.07.35.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 07:35:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201001241954.19626.kumbayo84@arcor.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137968>

Peter Oberndorfer <kumbayo84@arcor.de> wrote:
> This allows to quickly differentiate between new and modified files
> in the index without selecting the file and looking at the diff.
> 
> Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>

Thanks.

> While creating the patch i found out that file_parttick seems to be unused.

Yup, it is unused.  Thanks for noticing, I removed it.

-- 
Shawn.

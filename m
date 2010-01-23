From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui PATCH Keep repo_config(gui.recentrepos) and .gitconfig
	in synch
Date: Sat, 23 Jan 2010 14:39:43 -0800
Message-ID: <20100123223943.GC12679@spearce.org>
References: <564f37c41001231118m3f253259g8876ac4fb2b927c2@mail.gmail.com> <564f37c41001231121o10f88b6cwc35a126a0e79d3fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christopher Beelby <chris@celabs.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 23:39:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYodz-0008DY-6t
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 23:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab0AWWjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 17:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189Ab0AWWjr
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 17:39:47 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:47662 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0AWWjq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 17:39:46 -0500
Received: by iwn16 with SMTP id 16so1115192iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 14:39:46 -0800 (PST)
Received: by 10.231.161.143 with SMTP id r15mr1265350ibx.62.1264286386345;
        Sat, 23 Jan 2010 14:39:46 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm3253242iwn.13.2010.01.23.14.39.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 14:39:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <564f37c41001231121o10f88b6cwc35a126a0e79d3fc@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137870>

Christopher Beelby <chris@celabs.com> wrote:
> This patch addresses two issues:

Thanks, applied.  In the future please follow the SubmittingPatches
guidelines, which includes sending the patch inline in your message
using the formatting created by `git format-patch`.
 
-- 
Shawn.

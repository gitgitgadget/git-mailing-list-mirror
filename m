From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC/PATCH 1/3] git-find-git: a new helper.
Date: Thu, 1 Dec 2005 21:33:52 +0100
Message-ID: <200512012133.53030.Josef.Weidendorfer@gmx.de>
References: <7vmzjuzphl.fsf@assigned-by-dhcp.cox.net> <200512011535.25022.Josef.Weidendorfer@gmx.de> <7vr78wirj7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 21:37:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehv7z-0004mA-LD
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 21:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVLAUd6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 15:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVLAUd6
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 15:33:58 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:62618 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932448AbVLAUd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 15:33:58 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 3B4C127AF;
	Thu,  1 Dec 2005 21:33:54 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9
In-Reply-To: <7vr78wirj7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13070>

On Thursday 01 December 2005 19:46, you wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> 
> > can we revive this idea?
> 
> I forgot git-rev-parse had --show-prefix and git-rev-parse --git-dir
> already when I did that one.

Ah, thanks.
By the way, the documentation ofr --git-dir is missing.

It would be nice to have some docu about "How to write a porcelain", and
this should go under the section "Making commands work in subdirs of
a working copy"...

Josef

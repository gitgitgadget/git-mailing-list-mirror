From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Fri, 28 Oct 2005 11:16:40 +0200
Message-ID: <200510281116.41842.Josef.Weidendorfer@gmx.de>
References: <20051027203945.GC1622@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 28 11:19:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVQLy-0005mJ-KE
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 11:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbVJ1JQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 05:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbVJ1JQs
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 05:16:48 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:28128 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S965198AbVJ1JQr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 05:16:47 -0400
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 0E3FD27B5
	for <git@vger.kernel.org>; Fri, 28 Oct 2005 11:16:44 +0200 (MEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051027203945.GC1622@pe.Belkin>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10764>

On Thursday 27 October 2005 22:39, Chris Shoemaker wrote:
> 
> I really like gitweb (thanks Kay!), but I thought it would be nice to
> have a visual indication of patch size.  I found this helpful when
> scanning though the shortlogs.

Looks nice.
What about splitting this up into red (removed lines)
and green (added lines) bars?

Josef

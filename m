From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] git gui: visually wrap lines of commit message
Date: Sat, 9 Aug 2008 23:44:33 +0200
Message-ID: <200808092344.33332.johannes.sixt@telecom.at>
References: <20080809160557.GA902@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Aug 09 23:45:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRwFn-0007oY-KF
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 23:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbYHIVoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 17:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbYHIVog
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 17:44:36 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:44171 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbYHIVog (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 17:44:36 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 5130810A7B6;
	Sat,  9 Aug 2008 23:44:33 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 672A51D232;
	Sat,  9 Aug 2008 23:44:33 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080809160557.GA902@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91784>

On Samstag, 9. August 2008, Clemens Buchacher wrote:
> Visually wrap lines in the commit message text box. That way we can avoid
> a horizontal scroll bar (which was not available anyways).
>
> Note: This does _not_ break lines in the actual commit message.

Please don't do that. I want to get what I see.

-- Hannes

From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Shorten and simplify sendemail.alias* configuration variables.
Date: Tue, 18 Mar 2008 09:13:05 +0100
Message-ID: <20080318081305.GG18624@mail-vs.djpig.de>
References: <1205794384-14513-1-git-send-email-xma@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 18 09:14:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbWxL-0005Ai-C7
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 09:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbYCRINT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 04:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbYCRINS
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 04:13:18 -0400
Received: from pauli.djpig.de ([78.46.38.139]:45523 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbYCRINR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 04:13:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 5B9EC90079;
	Tue, 18 Mar 2008 09:13:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gJPZVLuCdN2A; Tue, 18 Mar 2008 09:13:07 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id D6A2590077;
	Tue, 18 Mar 2008 09:13:06 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JbWwT-0003Ms-D9; Tue, 18 Mar 2008 09:13:05 +0100
Content-Disposition: inline
In-Reply-To: <1205794384-14513-1-git-send-email-xma@gnu.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77493>

On Mon, Mar 17, 2008 at 11:53:04PM +0100, Xavier Maillard wrote:
> I find it more consistent and less error prone to have aliasfile
> instead of aliasesfile and aliastype instead of aliasfiletype.

I don't think that justifies breaking existing configs (which I assume
it does).

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/

From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH JGIT] fix typo
Date: Sat, 31 Jan 2009 17:45:16 +0100
Message-ID: <200901311745.16803.robin.rosenberg@dewire.com>
References: <1233411967.8213.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 17:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTIzc-0004Ui-0M
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 17:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbZAaQp0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jan 2009 11:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbZAaQpZ
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 11:45:25 -0500
Received: from mail.dewire.com ([83.140.172.130]:17223 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbZAaQpZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jan 2009 11:45:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EB5C9802811;
	Sat, 31 Jan 2009 17:45:18 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id am6z6vgvzfAv; Sat, 31 Jan 2009 17:45:18 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 74E8F800271;
	Sat, 31 Jan 2009 17:45:18 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <1233411967.8213.4.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107931>

l=F6rdag 31 januari 2009 15:26:07 skrev Yann Simon:
> fix a little typo
> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
> ---
>  .../src/org/spearce/jgit/lib/WindowedFile.java     |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Cleanups are nice too, but please try to follow the existing
style when it comes to comments. I don't think we have
stated these implicit rules anywhere.

- New sentences start with a capital letter.
- Don't repeat yourself You do not need a body in the comment=20
if the first line says it all, except the SOB line which technically
is part of the body.
- Make sure there is an empty line before the SOB line.

Cheers,
	-- robin

From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 05/10] Documentation: remove howto's now incorporated into manual
Date: Tue, 15 May 2007 10:48:56 -0400
Message-ID: <20070515144855.GA6212@fieldses.org>
References: <-7504805328344940638@unknownmsgid> <8aa486160705150305w5265a5d5w82cfaee49ff4e8b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 16:49:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnyKp-0003Gs-EM
	for gcvg-git@gmane.org; Tue, 15 May 2007 16:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbXEOOtA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 10:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756158AbXEOOtA
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 10:49:00 -0400
Received: from mail.fieldses.org ([66.93.2.214]:44257 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467AbXEOOs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 10:48:59 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HnyKe-0001km-4n; Tue, 15 May 2007 10:48:56 -0400
Content-Disposition: inline
In-Reply-To: <8aa486160705150305w5265a5d5w82cfaee49ff4e8b1@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47345>

On Tue, May 15, 2007 at 12:05:07PM +0200, Santi B=C3=A9jar wrote:
> What about the core-tutorial.txt? It is also included in the Git User
> Manual. We could backport the changes and actually do an
> include::core-tutorial.txt[] in the user-manual.txt.

Sure.

Actually, there's at least three documents with some overlap:
	- the core tutorial
	- tutorial-2.txt
	- the "DISCUSSION" section of git.7, also chapter 8 of the user
	  manual, also previously the README.

I'd eventually like to get those down to just one or two.

Updating the core-tutorial and figuring out how to work it into the
manual might be a good first step.

--b.

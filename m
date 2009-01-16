From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/5] bash: removed unnecessary checks for long options
	with argument
Date: Fri, 16 Jan 2009 17:09:47 +0100
Message-ID: <20090116160947.GR9794@neumann>
References: <1232121717-10145-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 17:11:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNrHt-0002Pi-4E
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 17:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760058AbZAPQJu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 11:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753114AbZAPQJt
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 11:09:49 -0500
Received: from francis.fzi.de ([141.21.7.5]:55923 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759889AbZAPQJs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 11:09:48 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 17:09:46 +0100
Content-Disposition: inline
In-Reply-To: <1232121717-10145-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 16 Jan 2009 16:09:46.0754 (UTC) FILETIME=[D9DB8E20:01C977F4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105970>

Oh, I have run 'git format-patch master.. && rm
patches-i-dont-want-to-submit-yet' and haven't noticed that
'format-patch' autonumbered the patches.  So, there are only three
patches: 2, 3, 5.

G=E1bor

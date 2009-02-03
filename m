From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Tue, 3 Feb 2009 14:08:18 +0100
Message-ID: <20090203130818.GA20359@neumann>
References: <1233432317.26364.5.camel@wren>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jesse van den Kieboom <jesse@icecrew.nl>
X-From: git-owner@vger.kernel.org Tue Feb 03 14:10:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUL2M-0002jo-GZ
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 14:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbZBCNI0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 08:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbZBCNIZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 08:08:25 -0500
Received: from francis.fzi.de ([141.21.7.5]:23781 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754417AbZBCNIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 08:08:25 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Feb 2009 14:08:18 +0100
Content-Disposition: inline
In-Reply-To: <1233432317.26364.5.camel@wren>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 03 Feb 2009 13:08:18.0680 (UTC) FILETIME=[7B7ECF80:01C98600]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108185>

Hi Jesse,

On Sat, Jan 31, 2009 at 09:05:17PM +0100, Jesse van den Kieboom wrote:
> I have been developing a gui application for git for gtk+/GNOME based=
 on
> GitX (which in turn is based on gitk). I feel that it's reaching the
> point where it might potentially be useful for other people to use. I=
t
> currently features:
>=20
> - Loading large repositories very fast
> - Show/browse repository history
> - Show highlighted revision diff
> - Browse file tree of a revision and export by drag and drop
> - Search in the revision history on subject, author or hash
> - Switch between history view of branches easily
> - Commit view providing per hunk stage/unstage and commit
>=20
> The project is currently hosted on github:
> http://github.com/jessevdk/gitg
>=20
> clone: git://github.com/jessevdk/gitg.git
>=20
> Please let me know what you think,

Great!

I wanted to give it a try, but didn't want to install it, and
experienced some problems.  The following two patches should improve
the situation a little bit, but it's still not a full-scale solution.

Regards,
G=E1bor

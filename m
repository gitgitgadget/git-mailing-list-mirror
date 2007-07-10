From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Support wholesale directory renames in fast-import
Date: Tue, 10 Jul 2007 16:03:39 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070710140338.GA18450@informatik.uni-freiburg.de>
References: <7154c5c60707091809y7e0b67d5u3f94658b7e814325@mail.gmail.com> <20070710031036.GA9045@spearce.org> <7154c5c60707092116p70aaeb8l90cda9265311b999@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: David Frech <nimblemachines@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 16:03:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8GJq-0006MJ-Q3
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 16:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbXGJODz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Jul 2007 10:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbXGJODz
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 10:03:55 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:49228 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221AbXGJODz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2007 10:03:55 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I8GJl-0006zQ-PV; Tue, 10 Jul 2007 16:03:53 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l6AE3pUE018644;
	Tue, 10 Jul 2007 16:03:51 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l6AE3dhC018642;
	Tue, 10 Jul 2007 16:03:39 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	David Frech <nimblemachines@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7154c5c60707092116p70aaeb8l90cda9265311b999@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52073>

Hallo David,

David Frech wrote:
> Now my challenge is that the svn dump doesn't *actually* say "rename
> a/ to b/"; it says "copy a/ to b/; delete a/", so I have to infer the
> rename.
I don't know fast-import very well, but why not doing exactly what the
dump file suggests:  copy a b; delete a ?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D12+divided+by+3

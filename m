From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Mon, 23 Nov 2009 12:50:12 -0800
Message-ID: <20091123205012.GG11919@spearce.org>
References: <20090813144327.GK1033@spearce.org> <alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302> <20090813150446.GM1033@spearce.org> <fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com> <20090813152419.GN1033@spearce.org> <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com> <alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302> <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com> <20090813172508.GO1033@spearce.org> <fabb9a1e0911230939m56e20812o939456c41becf5fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 21:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCfrY-0003Nv-4y
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 21:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251AbZKWUuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 15:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbZKWUuG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 15:50:06 -0500
Received: from george.spearce.org ([209.20.77.23]:52320 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbZKWUuF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 15:50:05 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 33DB43842F; Mon, 23 Nov 2009 20:50:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0911230939m56e20812o939456c41becf5fd@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133534>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> I think the simplest is to allow the stream to specify a marks file
> exactly once, and commandline arguments override what's in the stream.
> Listing import-marks on the commandline is still valid and keeps the
> old behavior.
> 
> Sensible?

Yes.

-- 
Shawn.

From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Sat, 04 Aug 2007 09:44:26 +0200
Message-ID: <85odhniw11.fsf@lola.goethe.zz>
References: <11858118802945-git-send-email-prohaska@zib.de>
	<20070802181853.GB31885@fieldses.org>
	<20070803030459.GJ20052@spearce.org>
	<20070803125846.GC28323@fieldses.org>
	<20070804062010.GQ20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 09:44:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHEJN-00040T-HO
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 09:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbXHDHob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 03:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755590AbXHDHob
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 03:44:31 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:51695 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752343AbXHDHoa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 03:44:30 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 8F8D0183E2B;
	Sat,  4 Aug 2007 09:44:29 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 7C0081B8E05;
	Sat,  4 Aug 2007 09:44:29 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 4E4D736E86A;
	Sat,  4 Aug 2007 09:44:29 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BBDA91C4F932; Sat,  4 Aug 2007 09:44:26 +0200 (CEST)
In-Reply-To: <20070804062010.GQ20052@spearce.org> (Shawn O. Pearce's message of "Sat\, 4 Aug 2007 02\:20\:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54812>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I haven't explored any in-Tk rendering options yet, been too busy
> with other projects.  Ideally I'd like to just render the asciidoc
> markup directly, but I don't think anyone has done an asciidoc
> viewer for Tk.  I can't imagine it would be that difficult to get
> some sort of parser working though...

With regard to my Texinfo proposal in a different thread, it must be
mentioned that "tkinfo" can be used as an embedded info viewer in
existing applications.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum

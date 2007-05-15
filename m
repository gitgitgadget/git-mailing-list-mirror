From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Tue, 15 May 2007 10:29:35 +0200
Message-ID: <20070515082935.GC9096@diana.vm.bytemark.co.uk>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <8b65902a0705070440t40889af0p1fb8dbf7e2a072e4@mail.gmail.com> <87wszagayt.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue May 15 10:29:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnsPl-0007yA-N7
	for gcvg-git@gmane.org; Tue, 15 May 2007 10:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193AbXEOI3o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 04:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756657AbXEOI3o
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 04:29:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3650 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbXEOI3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 04:29:43 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HnsPX-0002Ok-00; Tue, 15 May 2007 09:29:35 +0100
Content-Disposition: inline
In-Reply-To: <87wszagayt.fsf@morpheus.local>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47326>

On 2007-05-14 17:57:30 -0700, David K=E5gedal wrote:

> And it's broken as well. If you "update" in the emacs mode you
> cannot do a "git commit" in a terminal without manually running "git
> update-index" first.
>
> I think an emacs-mode that is closer to git-gui would be better, and
> closer to the git philosophy

I agree. (But for the record, I find the existing Emacs mode
tremendously useful too. It's just that in some circumstances, you can
get confused if you don't know what you're doing.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

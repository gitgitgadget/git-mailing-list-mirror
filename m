From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: A better approach to diffing and merging
Date: Tue, 2 Dec 2008 09:37:26 +0100
Message-ID: <20081202083726.GA17563@diana.vm.bytemark.co.uk>
References: <823242bd0811291012g15c4d442qa5d7afc9cc762b20@mail.gmail.com> <m3y6z0i0mu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ian Clarke <ian.clarke@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 09:38:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7QmO-0003Eh-U0
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 09:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbYLBIhb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2008 03:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbYLBIhb
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 03:37:31 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1848 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbYLBIhb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 03:37:31 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1L7Ql5-0004fY-00; Tue, 02 Dec 2008 08:37:27 +0000
Content-Disposition: inline
In-Reply-To: <m3y6z0i0mu.fsf@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102127>

On 2008-12-01 03:41:38 -0800, Jakub Narebski wrote:

> Third, it would require embedding knowledge about various programming
> languages (including C, shell, Perl, TeX) and document formats
> (including XML, HTML, AsciiDoc) in version control system...

Really? I was under the impression that you could specify external
diff and merge programs in .gitattributes, which would be precisely
the right way to hook this stuff into git.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

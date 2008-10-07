From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 5/6] Refresh the main stg man page
Date: Tue, 7 Oct 2008 09:32:47 +0200
Message-ID: <20081007073247.GD31332@diana.vm.bytemark.co.uk>
References: <20081005155450.19886.43748.stgit@yoghurt> <20081005160157.19886.7137.stgit@yoghurt> <b0943d9e0810061415n551acbc5r812bbd0e75eeb572@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 09:34:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn759-0008VT-Nc
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 09:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbYJGHc4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Oct 2008 03:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbYJGHc4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 03:32:56 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2680 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbYJGHc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 03:32:56 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Kn73n-0008FP-00; Tue, 07 Oct 2008 08:32:47 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0810061415n551acbc5r812bbd0e75eeb572@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97679>

On 2008-10-06 22:15:42 +0100, Catalin Marinas wrote:

> 2008/10/5 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > +  * You can easily 'rebase' your patch stack on top of any other G=
it
> > +    branch. (The 'base' of a patch stack is the most recent Git co=
mmit
> > +    that is not an StGit patch.) For example, if you started makin=
g
>
> You may want to move the bracket before the dot.

You mean like this?

  You can easily 'rebase' your patch stack on top of any other Git
  branch (the 'base' of a patch stack is the most recent Git commit
  that is not an StGit patch).

I slightly prefer the original, since the paretheses contain a full
stand-alone sentence, but it doesn't matter that much.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

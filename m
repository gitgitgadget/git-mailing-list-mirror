From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add a --tree flag to stg push
Date: Tue, 19 May 2009 10:03:38 +0200
Message-ID: <20090519080338.GB8451@diana.vm.bytemark.co.uk>
References: <20090518144754.30487.84132.stgit@krank> <20090519072512.GA8451@diana.vm.bytemark.co.uk> <87d4a5fs59.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin marinas <catalin.marinas@gmail.com>
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue May 19 10:03:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6KIe-0001Np-6A
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 10:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbZESIDl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 04:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbZESIDk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 04:03:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:47160 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbZESIDj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 04:03:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1M6KIU-0002Pt-00; Tue, 19 May 2009 09:03:38 +0100
Content-Disposition: inline
In-Reply-To: <87d4a5fs59.fsf@krank.kagedal.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119503>

On 2009-05-19 09:50:26 +0200, David K=E5gedal wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > There's no sign-off.
>
> I counted on getting comments, so it's not finished yet...

The sign-off has nothing to do with the patch being finished. It's
simply you saying "I promise I have the right to distribute the
following patch under GPLv2." See Documentation/SubmittingPatches
(which we've stolen from git and hardly changed).

> > --set-tree maybe?
>
> Probably better. But perhaps there is a way to not have to talk
> about "trees" at all?

Hmm, maybe. Personally, I find that "tree" is a very descriptive word
for this operation, but that may be because I know git too well.

Something like "overwrite" maybe?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

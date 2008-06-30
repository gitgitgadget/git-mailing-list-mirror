From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/7] Documentation: complicate example of "man git-command"
Date: Tue, 1 Jul 2008 01:39:17 +0200
Message-ID: <200807010139.17754.chriscool@tuxfamily.org>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu> <Pine.GSO.4.62.0806301706090.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Tue Jul 01 01:36:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSuw-00013u-PD
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 01:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbYF3XfW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 19:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754285AbYF3XfW
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 19:35:22 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:33629 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177AbYF3XfV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 19:35:21 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id DC4911AB2C9;
	Tue,  1 Jul 2008 01:35:20 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 806581AB2B4;
	Tue,  1 Jul 2008 01:35:20 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <Pine.GSO.4.62.0806301706090.7190@harper.uchicago.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86967>

Le mardi 1 juillet 2008, Jonathan Nieder a =E9crit :
> The manual page for the command invoked as "git clone" is named
> git-clone(1), and similarly for the rest of the git commands.
> Make sure our first example of this in tutorials makes it clear
> that it is the first two words of a command line that make up the
> command's name (that is: for example, the effect of "git svn
> dcommit" is described in git-svn(1)).
>
> Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
> ---
> 	If I didn't make this change, consistency would mean
> 	saying "you can get documentation for a command such
> 	as `git-diff` with `man git-diff`", which might not be
> 	very enlightening.

By the way, while at it, maybe we could talk about "git help <cmd/topic=
>" at=20
the same time.

Thanks,
Christian.

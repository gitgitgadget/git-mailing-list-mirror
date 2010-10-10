From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Sep 2010, #07; Wed, 29)
Date: Sun, 10 Oct 2010 23:26:46 +0200
Message-ID: <20101010212646.GA6092@neumann>
References: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 23:27:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53Q2-0005bF-Oy
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab0JJV0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 17:26:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:52833 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0JJV0v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 17:26:51 -0400
Received: from [127.0.1.1] (p5B130D54.dip0.t-ipconnect.de [91.19.13.84])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Lm8VZ-1OWGd422y1-00ZOJy; Sun, 10 Oct 2010 23:26:47 +0200
Content-Disposition: inline
In-Reply-To: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V02:K0:LikJloYeBBHbSV8BbaYCeEJffc1A3OT8gvmyUS7W9JD
 iejXM4BOHQVwdeEn2xoQPNBB9cfDu3b0S+WyGju7vmaB8lSQNU
 3KQdjcyOvTf7EFr6JZGNplGbN9QgQ/vDMW1xS0MrYjFh5N0vBj
 3jE6sh7EcC8uT4a7XgWpCN+0vJmLlXI66SrYZar3t+DyhgyupX
 cfJkvHeeoQ0lVLjN57z6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158711>

Hi,


On Wed, Sep 29, 2010 at 05:16:10PM -0700, Junio C Hamano wrote:
> * ml/completion-zsh (2010-09-06) 1 commit
>   (merged to 'next' on 2010-09-22 at d62d10e)
>  + completion: make compatible with zsh
>=20
> Comments from bash users regarding regressions?

No regressions so far here, but I don't use the "divergence from svn
upstream" feature (although the two changes in that codepath seem to
be fairly trivial).


Best,
G=E1bor

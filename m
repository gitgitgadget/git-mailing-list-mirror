From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] fix diff-tree --stdin documentation
Date: Wed, 6 Aug 2008 12:04:50 +0200
Message-ID: <20080806100450.GB18336@diana.vm.bytemark.co.uk>
References: <20080805164839.GA3934@diana.vm.bytemark.co.uk> <7vwsivusy2.fsf@gitster.siamese.dyndns.org> <7v7iauu2s3.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 11:44:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQfZ9-0003iu-Mt
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 11:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763163AbYHFJm7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 05:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761874AbYHFJm7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 05:42:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2289 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758805AbYHFJm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 05:42:58 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KQfsw-0004oC-00; Wed, 06 Aug 2008 11:04:50 +0100
Content-Disposition: inline
In-Reply-To: <7v7iauu2s3.fsf_-_@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91497>

On 2008-08-05 22:32:28 -0700, Junio C Hamano wrote:

> -	reads either one <commit> or a pair of <tree-ish>
> +	reads either one <commit> or a list of <commit>

Thanks. Didn't quite solve my problem though, since diffing trees was
what I wanted to use diff-tree for. :-/ But I think I can rephrase my
problem so that I give it a commit instead.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

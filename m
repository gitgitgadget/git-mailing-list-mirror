From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] Add an option not to use link(src, dest) && 
	unlink(src) when that is unreliable
Date: Sun, 26 Apr 2009 23:37:53 -0400
Message-ID: <76718490904262037r5dc39225k2adb500cd855b4f2@mail.gmail.com>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
	 <200904232116.10769.j6t@kdbg.org>
	 <alpine.DEB.1.00.0904251155130.10279@pacific.mpi-cbg.de>
	 <7vbpqkznjs.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.2.00.0904251039460.3101@localhost.localdomain>
	 <49F3588A.4000707@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Gaber <Michael.Gaber@gmx.net>
X-From: git-owner@vger.kernel.org Mon Apr 27 09:10:26 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyHhF-0002R8-08
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 05:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbZD0Dhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 23:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbZD0Dhz
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 23:37:55 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:12196 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbZD0Dhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 23:37:54 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1256476yxj.1
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 20:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rZqAjTU4c2e0qnhNlfa82ivTZrhjVgOFnvToVxb21To=;
        b=ShbJw175/MhyM5L64s2IqnQh//Q+oqxxHEC+mAKZ3PUW1xR0xND/YyrdbnBuyJqTdY
         ngPR2tc7FMH8IjFTmi9HvIx7uXUjMvKVb0oKg4H9ybwaF2c+PICO2qIaJufZkQbrCFzb
         FqZo+/kFDuugFYvi+GOLDKhMwx/X70OKUYw+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vu3ug0QACO3fdH0+7BSMM29J3UkB1x1elNlRpOos7AasRBtBZxrvH5D27yEZbmWd9v
         q/KyOHHnhg6rxWulhlLFwrX7f1lYpTiXYj1DJe+JdRGB7QGDeW3bx35a+PD14t7xC+Ab
         jmEcGnNs0Tv5eu03iQVB0tyLcEWChqhjZmxUo=
Received: by 10.151.68.6 with SMTP id v6mr8056924ybk.149.1240803473611; Sun, 
	26 Apr 2009 20:37:53 -0700 (PDT)
In-Reply-To: <49F3588A.4000707@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117598>

On Sat, Apr 25, 2009 at 2:38 PM, Michael Gaber <Michael.Gaber@gmx.net> wrote:
> http://www.cs.utexas.edu/users/EWD/ewd02xx/EWD215.PDF

http://www.bartleby.com/59/3/foolishconsi.html

j.

From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 1/2] parse_commit_buffer: don't parse invalid commits
Date: Mon, 14 Jan 2008 07:46:54 +0100
Message-ID: <20080114064654.GA1229@auto.tuwien.ac.at>
References: <12002478702664-git-send-email-mkoegler@auto.tuwien.ac.at> <7vzlv9nwdj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:47:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEJ6S-0003S8-3T
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 07:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbYANGq5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2008 01:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbYANGq5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 01:46:57 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:35180 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbYANGq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 01:46:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id EC332680BF79;
	Mon, 14 Jan 2008 07:46:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ISl72ggxd29; Mon, 14 Jan 2008 07:46:54 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id D1CEE680BF78; Mon, 14 Jan 2008 07:46:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vzlv9nwdj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70442>

On Sun, Jan 13, 2008 at 03:23:04PM -0800, Junio C Hamano wrote:
> I think I saw this patch and vaguely recall commenting on it,
> but your message is not very helpful locating the previous
> thread to see what kind of improvements are made to this new
> round.

http://marc.info/?l=3Dgit&m=3D119965688320973&w=3D2

mfg Martin K=F6gler

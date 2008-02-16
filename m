From: Remi Vanicat <vanicat@debian.org>
Subject: Re: [BUG] git filter-branch failed to suppress a file with an accentuated letter in the filename
Date: Sat, 16 Feb 2008 09:26:57 +0100
Message-ID: <87pruxtige.dlv@maison.homelinux.org>
References: <87bq6iw42w.dlv@maison.homelinux.org>
	<7vd4qygld8.fsf@gitster.siamese.dyndns.org>
	<87tzk9tnnu.dlv@maison.homelinux.org>
	<7v63wpcp4o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 09:28:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQIP9-0005fV-Ud
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 09:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbYBPI1O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Feb 2008 03:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbYBPI1O
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 03:27:14 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:55583
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751695AbYBPI1N convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 03:27:13 -0500
Received: from neuf-infra-smtp-out-sp604012av.neufgp.fr ([84.96.92.115])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id q73o1Y0042VLLWC070C700; Sat, 16 Feb 2008 09:27:06 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604012av.neufgp.fr with neuf telecom
	id q8Sz1Y00520lBGc0C00000; Sat, 16 Feb 2008 09:27:06 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JQINt-0001II-8k; Sat, 16 Feb 2008 09:26:58 +0100
In-Reply-To: <7v63wpcp4o.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 15 Feb 2008 23\:54\:47 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: moi@vanicat.homelinux.org
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS autolearn=ham
	version=3.2.3
X-SA-Exim-Version: 4.2.1 (built Tue, 21 Aug 2007 23:39:36 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74030>

Junio C Hamano <gitster@pobox.com> writes:

> Not just those two lines but the next two lines were also very
> old fashioned.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Could you try this one?

It work both on my real word case and on my tests git repositories.=20


--=20
R=C3=A9mi Vanicat

From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/config.txt: Order variables alphabetically
Date: Thu, 02 Dec 2010 07:43:02 +0200
Organization: Private
Message-ID: <87oc94spax.fsf@picasso.cante.net>
References: <1291209174-9239-1-git-send-email-jari.aalto@cante.net>
	<201012011557.30849.jnareb@gmail.com>
	<20101201150917.GD6537@picasso.cante.net>
	<201012011737.53652.jnareb@gmail.com>
	<87vd3dv2ow.fsf@picasso.cante.net> <20101202010229.GA4832@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 06:55:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO28m-00062J-Ui
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 06:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125Ab0LBFzJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 00:55:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:34886 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596Ab0LBFzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 00:55:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PO28G-0005sl-Al
	for git@vger.kernel.org; Thu, 02 Dec 2010 06:55:04 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 06:55:04 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 06:55:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:ZJX9MhkXdhiIgRmIoQ5GVTlyWtA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162672>

2010-12-02 03:02 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> On Wed, Dec 01, 2010 at 07:10:55PM +0200, Jari Aalto wrote:
>> Same for command line options. You read zillions of scripts and cryp=
tic
>> options. You want to consult manual page to see what an option means=
=2E Again
>> you're searching A-Z.
>
> When I want to look up X or a command line option seen somewhere, I
> never search A-Z.  I always search using the pager's or browser's
> search function.  And when it found what I was searching for, then I
> much prefer to see related options on the same screen.

That=C3=A4s real slow method.

You don't need specific search function (or reliance on those
availability[*]) when you can just tap

    PgUp
    PgDown

to locate the information by visual cues (A-Z).

[*] less(1) is not the default manual page pager everywhere.

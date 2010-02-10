From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: GSoC 2010
Date: Wed, 10 Feb 2010 21:23:55 +0100
Message-ID: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Eric Wong <normalperson@yhbt.net>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spe
X-From: git-owner@vger.kernel.org Wed Feb 10 21:24:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfJ6j-0000hw-7F
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 21:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab0BJUYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 15:24:17 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:57398 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab0BJUYP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 15:24:15 -0500
Received: by pzk17 with SMTP id 17so407726pzk.4
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 12:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=uTwYtBPYbYR5F5iV7BAYcNepnNNM6Mv2gYuwMlNuiyk=;
        b=iNY9/TNNZ40euEy1lh6/oIPJlfeOAQNkoirG3NZdzLlNfx0Mj4NFwpGOun0YykZQOK
         oaQp+ETNZe2gGmTv4wsjD1P850+/l9+3/o0lfdj05PfzzE71+kfuEcpBCmWZGVkmHQa5
         D07IL6RZkGV1yr2mCkiigLjp6/qDE4t5epgMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=ZYSPXZxsNMBho85SSwDoyfpdQaG0We4yBqzd/q3NKNfsBgo96SNodrKbEJAyYeXuFz
         /KqtBgNKrV2vZtiyGMCiQRW9rdzm8iCvcRlDJtWsyeoiU8NSfqEQqkXBFBrSMV2o18q+
         CZKZVZdOxYl9nhK3eD2PMEHYOY5Sr7T2I7NOI=
Received: by 10.142.67.11 with SMTP id p11mr444345wfa.342.1265833455080; Wed, 
	10 Feb 2010 12:24:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139545>

Heya,

Dscho created a GSoC 2010 idea's page [0] a few weeks ago, but it's a
bit sad at the moment (only two idea's). Part of the reason Git was
listed as 'example application' before was our awesome idea list, we
should live up to that again this year :). If you feel like mentoring
a summer of code student, or if you have a great idea, please add it
to the list so that our would-be students have some variety in
choosing their projects. I just added "A remote helper for svn" [1]
myself, since I would love to see native svn support in git. Would
either Daniel or Eric (or someone else of course) be interested in
being a co- or backup-mentor for this project?

Also, unless Shawn volunteers again, we need a Summer of Code admin
for this year. Dscho, Peff, as you two have both jumped in for Junio
before, do either of you have the time and inclination to do so if
Shawn cannot? And of course, Shawn, do you have time to admin again
this year? If not, (and no-one else steps up) I'm willing to admin
myself, but I'll also be backup-admin and mentor for Melange, so if at
all possible it would be awesome if someone else jumps in.

Anyway, Summer of Code 2010 is a go [2], now is the time to get ready
and prepare for an awesome summer :).

[0] http://git.wiki.kernel.org/index.php/SoC2010Ideas
[1] http://git.wiki.kernel.org/index.php/SoC2010Ideas#A_remote_helper_for_svn
[2] http://socghop.appspot.com/

-- 
Cheers,

Sverre Rabbelier

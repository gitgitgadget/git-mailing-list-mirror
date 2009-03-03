From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: First round of UGFWIINI results
Date: Tue, 3 Mar 2009 15:09:50 +0000
Message-ID: <3f4fd2640903030709r6e585d9j57ad3ae08cf38df1@mail.gmail.com>
References: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 16:11:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWHC-0007wG-Bh
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbZCCPJz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 10:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbZCCPJy
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:09:54 -0500
Received: from mail-ew0-f177.google.com ([209.85.219.177]:35213 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbZCCPJx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 10:09:53 -0500
Received: by ewy25 with SMTP id 25so2353347ewy.37
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 07:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pt7mXta64fGWcpHITYS2x8lW5DOeI3P5waEok094pnE=;
        b=veKXsGhHw0cMQ64o7UwBaEgriOtnWMGFMpIW5AhtMvtjglD+phb/E3uQLwJB+sH8Uj
         ELRVgdMVn90QmbeYcqzNaOCEuBL03PntHUa13QxBUgCGNL30Cub5YLucR2Mr/p+qXKOD
         o5i5U67eKZLiwtx84BuuhQwPhGU6K85uFtqQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nE02SkdGJPO4Ce7yB3eK83uMKhJaGD0/lmIq7N5mAq8DCEaoeIlZdF8XMqSy0uavyM
         Mc4T4pinFo16U8xRYOM3X8rFbmMEcgzx7NRhqFmJk65YjJX1akTnBXyZcspouy/iNb3T
         F8xaHADbHoxBwhx97EaDjKqI4cMO3jcdhCN8o=
Received: by 10.210.52.15 with SMTP id z15mr5764820ebz.50.1236092990261; Tue, 
	03 Mar 2009 07:09:50 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112083>

2009/2/17 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Dear fans of Git,
>
> a while ago I announced the UGFWIINI contest, a glorious battle of id=
eas
> how to
>
> =A0 =A0 =A0 =A0Use Git For What It Is Not Indended

Does using Git to track edits when proofreading a html/text document
(short story, novel, ...) count?

This is similar to the ODF <-> Git entry. Now all that needs to happen
is to replace the ZIP format with a git repository and create a plugin
for an ODF reader that makes git calls when doing the content tracking
checks.

- Reece

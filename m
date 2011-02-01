From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: moving to a git-backed wiki
Date: Tue, 1 Feb 2011 17:36:49 -0500
Message-ID: <AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org> <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
 <20110131225529.GC14419@sigill.intra.peff.net> <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
 <20110201201144.GA16003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 23:37:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkOqk-00016r-44
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 23:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322Ab1BAWhV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 17:37:21 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53219 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1BAWhU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 17:37:20 -0500
Received: by iwn9 with SMTP id 9so6998904iwn.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 14:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Z+WnG/AMpv7NmT1Ua4CFxJMVdZ7phiSjHrl7V7Re+7k=;
        b=KyI7hRe2JPaTJV8Z3G1YvH+/rCVRUz0CflW8VU5lGtIvCplOuF5FVq73/p0KZ36INM
         O1I7qzX87cQUlYlJfKlMT52GDJJmgoucPMKjC1ISn8g7DXdWsIBHK0pkKh+4dP7BB1Wl
         rJsFFWjRenY80S/1fG5rpjzClkLStXWagYj1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QCETVutI9Llm9MkJMknnAy/9ReG3+6MfzhWVVwOViVD2uatplfoC743IlnL/OFL321
         OGMH4Gl8JK4V0x3aszQMQt5a50l5azyS0FV7TUSJJtSE7jDToKI8OpNC+0QCxJ/Lskmz
         I5W9av7DHGiQuGmZnrM/An/iFilP/BRfhcATI=
Received: by 10.231.173.12 with SMTP id n12mr9006904ibz.77.1296599839105; Tue,
 01 Feb 2011 14:37:19 -0800 (PST)
Received: by 10.231.30.65 with HTTP; Tue, 1 Feb 2011 14:36:49 -0800 (PST)
In-Reply-To: <20110201201144.GA16003@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165870>

On Tue, Feb 1, 2011 at 3:11 PM, Jeff King <peff@peff.net> wrote:
> =C2=A0https://github.com/peff/foo/wiki

A git-backed git wiki would be great. As a related matter, the hosting
infrastructure for https://git.wiki.kernel.org/index.php/Main_Page
seems overloaded. About half the time I try to access it, it's either
down completely or very slow to respond. If the wiki were git-backed I
could get to it even if the central site were down. :-)

That said, didn't the wiki just migrate to Mediawiki recently?

j.

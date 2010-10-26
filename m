From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 09/10] user-manual.txt: explain better the
 remote(-tracking) branch terms
Date: Tue, 26 Oct 2010 02:07:08 -0400
Message-ID: <AANLkTiky=FiLX=FQL5V66FW_t4yeHjAxE_JJyovTTw5u@mail.gmail.com>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr> <1287986922-16308-10-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Oct 26 08:07:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAchF-0005KO-3W
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 08:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab0JZGHj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010 02:07:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57404 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0JZGHj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 02:07:39 -0400
Received: by gwj21 with SMTP id 21so3050829gwj.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 23:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IGhGLeNM4QhqvmhGDfowY3GYh5cWRq1nG37mVCFibbw=;
        b=lTBwDPEqhXdrWtIkrmeh3mc+glTkVY6hKpcUOxY83tvl1Vouj/J9VbYXgPtk0nu4k7
         eTnd6RjBEDZ/uvBF6pThJ7WdIuefQFb1IPCDYDaeejwnhaEsIRF+gJ/fJMfgiqxAPIyB
         HS4VHozsEL4YkHVO0qZ8VYu9Oqv5rTIt1FEo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=k0pJmu8xUt9YXuZUXdBVXORpbkXmIk9NO0aYAXHD1hCPUVFFSGmB4StgyoqdGsCLyn
         U78lcjRRDIAQjUaUl8DDCiF64nS16Sh2ZavNPX+naP/m8RzBBG2mXB2j5y39ujlkc/JX
         JzdtwcmuWbjIviDXICt9snURvPg+OPbIxn4VU=
Received: by 10.42.189.5 with SMTP id dc5mr5916865icb.126.1288073258225; Mon,
 25 Oct 2010 23:07:38 -0700 (PDT)
Received: by 10.231.150.201 with HTTP; Mon, 25 Oct 2010 23:07:08 -0700 (PDT)
In-Reply-To: <1287986922-16308-10-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159980>

On Mon, Oct 25, 2010 at 2:08 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wr=
ote:
> =C2=A0You cannot check out these remote-tracking branches, but you ca=
n
> =C2=A0examine them on a branch of your own, just as you would a tag:

Suggestion: "You do not commit directly to remote-tracking branches,
but you can examine them or create a branch from them, just as you
would a tag:"

j.

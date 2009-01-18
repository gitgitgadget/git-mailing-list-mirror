From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: meaning of --8<--
Date: Sun, 18 Jan 2009 11:04:37 -0500
Message-ID: <eaa105840901180804k64a745f9q1a092fe3915db868@mail.gmail.com>
References: <200901181656.37813.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sun Jan 18 17:11:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOaFM-00012Z-KG
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 17:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919AbZARQKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 11:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754756AbZARQKM
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 11:10:12 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:14219 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbZARQKL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 11:10:11 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1077426yxm.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 08:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=LWzGjnv/G6gpaCO8TrjbLuZ2PzZkuPZxZpQQkfUGdtk=;
        b=NTaj8eiSHOXkj2D8i8Mf1Bnxp7D8hBYo5WuYzCOEI5O2hFMg+zjlvpbB/qDmjGMyl3
         uq2d6NGfuk2SmBMY+6u7DlBsgTpYmpE1cXpJaDQghjtpv72dlnSIUKvjRRORnJq0F3TE
         fl4h0kwRXnqrjm54QDDlbJ2ohtow/4mdyGtfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=mzIHQNIMrMKxg5RFpoFpnpqS0/M9aCJDNDwWDyUM4ZQNLrv4R5tclbpuMqx0Yth3y2
         98NtPuT/ILRPkuxBCbBo5jvaXKs1evacq8SNuJBiE/cWGGplR9xSMHJWGSGv2SvA9LaO
         OP1aG1cfyun6Gd2XKZ0AENftoBwZ/Gav2dWhg=
Received: by 10.65.133.12 with SMTP id k12mr2247182qbn.65.1232294678026; Sun, 
	18 Jan 2009 08:04:38 -0800 (PST)
In-Reply-To: <200901181656.37813.markus.heidelberg@web.de>
X-Google-Sender-Auth: d7e0be083745e06f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106234>

On Sun, Jan 18, 2009 at 10:56 AM, Markus Heidelberg wrote:
> I've seen lines like "--8<--" several times on this list, but have no
> clue what it is about. OK, seems like it's used to insert diffs in the
> middle of a mail message.
> But is this a common convention or git specific and handled by git-am?
> Is it documented anywhere?

Common convention, meaning 'cut here'.

Perforated line ------
Scissors 8<

Also used in print (although usually with picture of scissors instead
of the ASCII-art).

Peter Harris
